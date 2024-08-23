"
2国同盟のワンペア,ツーペア,非対称ペアを構成する2つのセルで
どちらか片方のセルに入る数字が決まったときもう一方のセルに入る
数字を自動的に決めるロジックを表現するクラス。


Instance variables
thisCell       <SudokuCell>    セルに入る数が確定したSudokuCell
otherCell      <SudokuCell>    thisCellで確定したことでセルに入る数が自動的に決まる可能性があるSudokuCell

otherCell は OttiezTactics>>getAlliedCellForMapping: aBlock cell: thisCell を使って取得する。

- ワンペア   1つの数字が2つのセルのどちらか一方に必ず入る状態

- ツーペア   2つの数字が2つのセルのどちらか一方に必ず入る状態


- 非対称ペア 2つの数字で重なる2つのワンペアを作り,いづれかのセルに入る数字が決まれば他のセルに入る数字が決まる状態
             (1)  -  (1 2)   - (2)



"
Class {
	#name : #BilateralAlliance,
	#superclass : #Object,
	#instVars : [
		'thisCell',
		'otherCell'
	],
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #creating }
BilateralAlliance class >> thisCell: cell1 otherCell: cell2 [
	
	| etherCell |
	etherCell := self new.
	etherCell thisCell: cell1.
	etherCell otherCell: cell2.
	^etherCell 
	
]

{ #category : #logic }
BilateralAlliance >> determineTheNumber [
	"
	他のブロックで確定した数字によりツーペアが解消する際は,thisCell element: に 
	もう片方の数字をセットしpossibleNumber はいじらずにtreatAsTwoPairsを呼び出す
	"
	| logger result  |
	logger := M946FileLogger new.
	logger debug: thisContext.
	logger debug: ('thisCell =>
{1}' format:{thisCell}).
	logger debug: ('otherCell =>
{1}' format:{otherCell}).
	result := nil.
	(thisCell possibleNumbers isEmpty or: [ otherCell possibleNumbers isEmpty ])
		ifTrue: [ result := self ].
	(thisCell possibleNumbers size = 1 and: [ otherCell possibleNumbers  size = 1])
		ifTrue: [  result := self treatAsOnePair ].
	(thisCell possibleNumbers size = 2 and: [ otherCell possibleNumbers  size = 2])
		ifTrue: [ result := self treatAsTwoPairs ].
	(thisCell possibleNumbers size = 2 and: [ otherCell possibleNumbers size = 1])
		ifTrue: [ result := self treatAsAsymmetricPair1 ].
	(thisCell possibleNumbers size = 1 and: [ otherCell possibleNumbers size = 2])
		ifTrue: [ result := self treatAsAsymmetricPair2 ].
	^result
	
	

]

{ #category : #accessing }
BilateralAlliance >> otherCell: sudokuCell [

	otherCell := sudokuCell 
	
]

{ #category : #accessing }
BilateralAlliance >> thisCell: sudokuCell [

	thisCell := sudokuCell 
	
]

{ #category : #logic }
BilateralAlliance >> treatAsAsymmetricPair1 [
	"
	thisCellの予約数が2種類、otherCellの予約数が1種類の非対称ペア 
	otherCell 

	2  1  $38  <= thisCell
	4  5  $8   <= otherCell
	9  4  $3  (<= otherCell)	
	"
	| logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	(thisCell possibleNumbers includes: thisCell element) 
		ifFalse: [ self error: 'element should be in possibleNumbers' ].
	(thisCell possibleNumbers intersection: otherCell possibleNumbers ) isEmpty
		ifTrue: [ ^self ].
	
	(otherCell possibleNumbers includes: thisCell element)
		ifTrue: [ ^self ].
	 otherCell element: (otherCell possibleNumbers at: 1 ).
	 otherCell clearPossibleNumbers .
	^otherCell
]

{ #category : #logic }
BilateralAlliance >> treatAsAsymmetricPair2 [
	"
	thisCellの予約数が1種類、otherCellの予約数が2種類の非対称ペア 

	2  1  $38    <= otherCell
	4  5  $8     <= thisCell 
	9  4  $3    (<= thisCell)
	"
	| logger |
	logger := M946FileLogger new: thisContext.
	(thisCell possibleNumbers includes: thisCell element) 
		ifFalse: [ self error: 'element should be in possibleNumbers' ].

	(otherCell possibleNumbers includes: thisCell element)
		ifTrue: [
			otherCell possibleNumbers remove: thisCell element.
			thisCell clearPossibleNumbers .
			^otherCell].
	^self
]

{ #category : #logic }
BilateralAlliance >> treatAsOnePair [
	"
	thisCellのelementが決まったときのワンペアの相棒の状態
	"
	|logger|
	logger := M946FileLogger new: thisContext.
	logger debug: ('thisCell => {1}' format: {thisCell}).
	logger debug: ('otherCell => {1}' format: {otherCell}).
	thisCell possibleNumbers = otherCell possibleNumbers 
		ifTrue: [ 
			thisCell element = (thisCell possibleNumbers at: 1)
				ifTrue: [ otherCell element: 0]
				ifFalse: [ otherCell element: (thisCell possibleNumbers at: 1)].
			thisCell clearPossibleNumbers .
			otherCell clearPossibleNumbers.
			^otherCell].
	^otherCell
]

{ #category : #logic }
BilateralAlliance >> treatAsTwoPairs [
	"
	 thisCellのelementが確定した時のツーペアの相棒の状態。
    elementが予約数に含まれない時は例外を発生させる。
	"
	| logger |
	logger := M946FileLogger new: thisContext.
	(thisCell possibleNumbers includes: thisCell element) ifFalse: [ self error: 'element should be in possibleNumbers' ].
	thisCell possibleNumbers asBag = otherCell possibleNumbers asBag
		ifTrue: [ 
			otherCell possibleNumbers remove: (thisCell element).
			otherCell element: (otherCell possibleNumbers at: 1).
			otherCell clearPossibleNumbers.
			thisCell clearPossibleNumbers .
			^otherCell].
	^self
]
