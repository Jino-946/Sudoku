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

	| logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	(thisCell possibleNumbers isEmpty or: [ otherCell possibleNumbers isEmpty ])
		ifTrue: [ ^self ].
	(thisCell possibleNumbers size = 1 and: [ otherCell possibleNumbers  size = 1])
		ifTrue: [ ^self treatAsOnePair ].
	(thisCell possibleNumbers size = 2 and: [ otherCell possibleNumbers  size = 2])
		ifTrue: [ ^self treatAsTwoPairs ].
	(thisCell possibleNumbers size = 2 and: [ otherCell possibleNumbers size = 1])
		ifTrue: [ ^self treatAsAsymmetricPair1 ].
	(thisCell possibleNumbers size = 1 and: [ otherCell possibleNumbers size = 2])
		ifTrue: [ ^self treatAsAsymmetricPair2 ].
	
	
	

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

	2  1  $38  <= thisCell
	4  5  $8
	9  4  $3	
	"
	| logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	(thisCell possibleNumbers intersection: otherCell possibleNumbers ) isEmpty
		ifTrue: [ ^self ].
	
	(otherCell possibleNumbers includes: thisCell element)
		ifFalse: [ otherCell element: (otherCell possibleNumbers at: 1)]
		ifTrue: [ otherCell element: 0].
	otherCell clearPossibleNumbers .
	^otherCell 
]

{ #category : #logic }
BilateralAlliance >> treatAsAsymmetricPair2 [
	"
	thisCellの予約数が1種類、otherCellの予約数が2種類の非対称ペア 

	2  1  $38  <= otherCell
	4  5  $8
	9  4  $3	
	"
	(thisCell possibleNumbers intersection: otherCell possibleNumbers)
		isEmpty ifTrue: [ ^ self ].

	(otherCell possibleNumbers includes: thisCell element) ifFalse: [
		^ self ].
	otherCell possibleNumbers remove: thisCell element.
	otherCell element: (otherCell possibleNumbers at: 1).
	otherCell clearPossibleNumbers .
	
	^ otherCell
]

{ #category : #logic }
BilateralAlliance >> treatAsOnePair [

	thisCell possibleNumbers = otherCell possibleNumbers 
		ifTrue: [ 
			thisCell element = (thisCell possibleNumbers at: 1)
				ifTrue: [ otherCell element: 0]
				ifFalse: [ otherCell element: (thisCell possibleNumbers at: 1)].
			otherCell clearPossibleNumbers.
			thisCell clearPossibleNumbers .
			^otherCell].
	^self
]

{ #category : #logic }
BilateralAlliance >> treatAsTwoPairs [

	thisCell possibleNumbers asBag = otherCell possibleNumbers asBag
		ifTrue: [ 
			otherCell possibleNumbers remove: (thisCell element).
			otherCell element: (otherCell possibleNumbers at: 1).
			otherCell clearPossibleNumbers.
			thisCell clearPossibleNumbers.
			^otherCell].
	^self
]
