"
2個で一組のセルを表すクラス

 

Instance Variables
thisCell         <SudokuCell>  
otherCell        <SudokuCell>
pairOfNumbers    <OrderedCollection>
pairKinds        <PairKindsEnum>        ペアの種類を表す(onePair twoPair isolated)


Instance methods
isHorizontal     2つのセルが水平に並んでいる(同一行にある)時true
isVertical       2つのセルが垂直に並んでいる(同一列にある)時true
"
Class {
	#name : #SudokuPairCells,
	#superclass : #Object,
	#instVars : [
		'thisCell',
		'otherCell',
		'pairOfNumbers',
		'pairKinds'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #creating }
SudokuPairCells class >> thisCell: aSudokuCell otherCell: aSudokuCell2 [

	| sdPairCells |
	sdPairCells := self new.
	sdPairCells thisCell: aSudokuCell .
	sdPairCells thisCell element: 0.
	sdPairCells otherCell: aSudokuCell2.
	sdPairCells otherCell element: 0.
	
	^sdPairCells 
	
	
]

{ #category : #initialization }
SudokuPairCells >> initialize [ 

	super initialize .
	pairOfNumbers := OrderedCollection new.
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
SudokuPairCells >> pairKinds [

	^pairKinds 
]

{ #category : #accessing }
SudokuPairCells >> pairKinds: aPairKinds [

	pairKinds := aPairKinds 
]

{ #category : #accessing }
SudokuPairCells >> pairOfNumbers [ 

	^pairOfNumbers 
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
