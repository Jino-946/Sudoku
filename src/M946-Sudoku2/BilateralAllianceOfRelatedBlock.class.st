"
2国同盟のワンペア,ツーペア,非対称ペアを構成する2つのセルで
他のブロックの交差する行列にあるセルに入る数字が確定したとき,
このセル (thisCell)と同盟関係にあるセル(otherCell)の状態を決定する
ロジックを実装するクラス。

Instance variables
thisCell       <SudokuCell>    セルに入る数が確定下セルと同じ行また列にあるセル
otherCell      <SudokuCell>    thisCellとの同盟関係によりセルに入る数が自動的に決まる可能性があるセル
confirmNumber  <SmallInteger>  thisCellと関連するセルに入ることが確定した数字


同盟関係
- ワンペア   1つの数字が2つのセルのどちらか一方に必ず入る状態

- ツーペア   2つの数字が2つのセルのどちらか一方に必ず入る状態


- 非対称ペア 2つの数字で重なる2つのワンペアを作り,いづれかのセルに入る数字が決まれば他のセルに入る数字が決まる状態
             (1)  -  (1 2)   - (2)



"
Class {
	#name : #BilateralAllianceOfRelatedBlock,
	#superclass : #Object,
	#instVars : [
		'thisCell',
		'otherCell',
		'confirmNumber'
	],
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #creating }
BilateralAllianceOfRelatedBlock class >> thisCell: cell1 otherCell: cell2 [
	
	| allies  |
	allies := self new.
	allies thisCell: cell1.
	allies otherCell: cell2.
	^allies
	
]

{ #category : #'as yet unclassified' }
BilateralAllianceOfRelatedBlock class >> thisCell: cell1 otherCell: cell2 confirmNumber: aNumber [
	
	| allies  |
	allies := self new.
	allies thisCell: cell1.
	allies otherCell: cell2.
	allies confirmNumber: aNumber .
	^allies
	
]

{ #category : #accessing }
BilateralAllianceOfRelatedBlock >> confirmNumber [

	^confirmNumber 
]

{ #category : #accessing }
BilateralAllianceOfRelatedBlock >> confirmNumber: aNumber [	

	confirmNumber := aNumber 
	
]

{ #category : #logic }
BilateralAllianceOfRelatedBlock >> determineTheNumber [
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
BilateralAllianceOfRelatedBlock >> otherCell [

	^otherCell 
]

{ #category : #accessing }
BilateralAllianceOfRelatedBlock >> otherCell: aSudokuCell [

	otherCell := aSudokuCell 
	
]

{ #category : #accessing }
BilateralAllianceOfRelatedBlock >> thisCell [

	^thisCell 
]

{ #category : #accessing }
BilateralAllianceOfRelatedBlock >> thisCell: aSudokuCell [

	thisCell := aSudokuCell 
	
]

{ #category : #logic }
BilateralAllianceOfRelatedBlock >> treatAsAsymmetricPair1 [
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
	thisCell removePossibleNumber: confirmNumber .	
	(otherCell possibleNumbers includes: confirmNumber)
		ifTrue: [  
			otherCell element: confirmNumber.
			otherCell clearPossibleNumbers].
		"
		ifFalse: [ 
			otherCell element: (thisCell possibleNumbers at: 1).
			otherCell clearPossibleNumbers].
		"
	^otherCell
]

{ #category : #logic }
BilateralAllianceOfRelatedBlock >> treatAsAsymmetricPair2 [
	"
	thisCellの予約数が1種類、otherCellの予約数が2種類の非対称ペア 

	2  1  $38    <= otherCell
	4  5  $8     <= thisCell 
	9  4  $3    (<= thisCell)
	"
	| logger  |
	logger := M946FileLogger new: thisContext.
	otherCell element: confirmNumber  .

	^otherCell
]

{ #category : #logic }
BilateralAllianceOfRelatedBlock >> treatAsOnePair [
	"
	ワンペア同盟
	"
	|logger|
	logger := M946FileLogger new: thisContext.
	logger debug: ('thisCell => 
{1}' format: {thisCell}).
	logger debug: ('otherCell => 
{1}' format: {otherCell}).
	(thisCell possibleNumbers = otherCell possibleNumbers and: [ thisCell possibleNumbers size = 1 ])
		ifTrue: [ 
			otherCell element: confirmNumber  .
			thisCell clearPossibleNumbers .
			otherCell clearPossibleNumbers.
			logger debug: ('otherCell => 
{1}' format: {otherCell}).
		
			^otherCell].
	^self
]

{ #category : #logic }
BilateralAllianceOfRelatedBlock >> treatAsTwoPairs [
	"
	2ペア同盟
	"
	|logger|
	logger := M946FileLogger new: thisContext.
	(thisCell possibleNumbers = otherCell possibleNumbers and: [ thisCell possibleNumbers size = 2 ])
	ifFalse: [ ^self ].
	thisCell removePossibleNumber: confirmNumber .
	thisCell element: (thisCell possibleNumbers at: 1).
	thisCell clearPossibleNumbers .
	otherCell element: confirmNumber  .
	otherCell clearPossibleNumbers .
	^otherCell
]
