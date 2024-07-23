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

- 非対称ペア ワンペアを構成し,かつどちらかのセルにもう一つ入る可能性がある数字がある状態
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

	| logger |
	logger := M946Logger new: LogLevel debug.
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

	(thisCell possibleNumbers intersection: otherCell possibleNumbers)
		isEmpty ifTrue: [ ^ self ].

	(otherCell possibleNumbers includes: thisCell element) ifFalse: [
		^ self ].
	otherCell possibleNumbers remove: thisCell element.
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
			^otherCell].
	^self
]
