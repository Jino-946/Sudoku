"
ブロックにおけるブランクセルが２つになりどちらかのセルに必ず同一の数字が入る場合,
２つのセルの座標をSudokuCellのインスタンスとしてcellsに保持する。

SudokuBlock2オブジェクトのインスタンス変数として生成される。

Instance variables
thisCell       <SudokuCell>    セルに入る数が確定したSudokuCell
otherCell      <SudokuCell>    thisCellで確定したことでセルに入る数が自動的に決まる可能性があるSudokuCell

"
Class {
	#name : #EitherCell,
	#superclass : #Object,
	#instVars : [
		'thisCell',
		'otherCell'
	],
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #creating }
EitherCell class >> thisCell: cell1 otherCell: cell2 [
	
	| etherCell |
	etherCell := self new.
	etherCell thisCell: cell1.
	etherCell otherCell: cell2.
	^etherCell 
	
]

{ #category : #logic }
EitherCell >> determineTheNumber [

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
EitherCell >> otherCell: sudokuCell [

	otherCell := sudokuCell 
	
]

{ #category : #accessing }
EitherCell >> thisCell: sudokuCell [

	thisCell := sudokuCell 
	
]

{ #category : #logic }
EitherCell >> treatAsAsymmetricPair1 [

	(thisCell possibleNumbers intersection: otherCell possibleNumbers ) isEmpty
		ifTrue: [ ^self ].
	
	(otherCell possibleNumbers includes: thisCell element)
		ifFalse: [ otherCell element: (otherCell possibleNumbers at: 1)]
		ifTrue: [ otherCell element: 0].
	otherCell clearPossibleNumbers .
	^otherCell 
]

{ #category : #logic }
EitherCell >> treatAsAsymmetricPair2 [

	(thisCell possibleNumbers intersection: otherCell possibleNumbers)
		isEmpty ifTrue: [ ^ self ].

	(otherCell possibleNumbers includes: thisCell element) ifFalse: [
		^ self ].
	otherCell possibleNumbers remove: thisCell element.
	^ otherCell
]

{ #category : #logic }
EitherCell >> treatAsOnePair [

	thisCell possibleNumbers = otherCell possibleNumbers 
		ifTrue: [ 
			otherCell element: 0.
			otherCell clearPossibleNumbers.
			^otherCell].
	^self
]

{ #category : #logic }
EitherCell >> treatAsTwoPairs [

	thisCell possibleNumbers asBag = otherCell possibleNumbers asBag
		ifTrue: [ 
			otherCell possibleNumbers remove: (thisCell element).
			otherCell element: (otherCell possibleNumbers at: 1).
			otherCell clearPossibleNumbers.
			^otherCell].
	^self
]
