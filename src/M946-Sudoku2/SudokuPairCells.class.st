"
SudokuOnePair及びSudokuTwoPairの基底クラス

Instance Variables
thisCell         <SudokuCell>  
otherCell        <SudokuCell>

"
Class {
	#name : #SudokuPairCells,
	#superclass : #Object,
	#instVars : [
		'thisCell',
		'otherCell'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #creating }
SudokuPairCells class >> pairOf: aSudokuCell and: aSudokuCell2 [

	| sdPairCells |
	sdPairCells := self new.
	sdPairCells thisCell: aSudokuCell .
	sdPairCells thisCell element: 0.
	sdPairCells otherCell: aSudokuCell2.
	sdPairCells otherCell element: 0.
	
	^sdPairCells 
	
	
]

{ #category : #'as yet unclassified' }
SudokuPairCells >> isHorizontal [

	^thisCell y = otherCell y
	
]

{ #category : #'as yet unclassified' }
SudokuPairCells >> isVertical [

	^thisCell x = otherCell x
	
]

{ #category : #accessing }
SudokuPairCells >> otherCell [

	^otherCell 
]

{ #category : #accessing }
SudokuPairCells >> otherCell: aSudokuCell [

	otherCell := aSudokuCell 
	
]

{ #category : #accessing }
SudokuPairCells >> thisCell [

	^thisCell 
	
]

{ #category : #accessing }
SudokuPairCells >> thisCell: aSudokuCell [

	thisCell := aSudokuCell 
	
]

{ #category : #'accessing - structure variables' }
SudokuPairCells >> x [

	self isHorizontal ifTrue: [ ^thisCell x].
	^0
	
]

{ #category : #'accessing - structure variables' }
SudokuPairCells >> y [

	self isVertical ifTrue: [ ^ thisCell y ].
	^ 0
	
]
