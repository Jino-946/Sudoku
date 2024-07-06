"
アルゴリズムが複雑になりすぎるので使用しないことにする

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
	#name : #SudokuPairCell,
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
SudokuPairCell class >> thisCell: aSudokuCell otherCell: aSudokuCell2 [

	| sdPairCells |
	sdPairCells := self new.
	sdPairCells thisCell: aSudokuCell .
	sdPairCells thisCell element: 0.
	sdPairCells otherCell: aSudokuCell2.
	sdPairCells otherCell element: 0.
	
	^sdPairCells 
	
	
]

{ #category : #converting }
SudokuPairCell >> asSpecialString [	
	"
	SudokuBoard2>>asStringでSudokuPairCellを見やすく表示するために使用するメソッド
	"
	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: (pairOfNumbers at: 1) asString;
				 			nextPutAll: (pairOfNumbers at: 2) asString .

	^aStream contents 
			

]

{ #category : #converting }
SudokuPairCell >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream cr; nextPutAll: '<SudokuPairCell>'; cr;
			nextPutAll: 'thisCell:      '; nextPutAll: thisCell asString;cr;
			nextPutAll: 'otherCell:     '; nextPutAll: otherCell asString; cr;
			nextPutAll: 'pairOfNumbers: '; nextPutAll: pairOfNumbers asString; cr;
			nextPutAll: 'pairKinds:     '; nextPutAll: pairKinds asString.
		
	^aStream contents 
]

{ #category : #initialization }
SudokuPairCell >> initialize [ 

	super initialize .
	pairOfNumbers := OrderedCollection new.
]

{ #category : #boolean }
SudokuPairCell >> isHorizontal [

	^thisCell y = otherCell y
	
]

{ #category : #boolean }
SudokuPairCell >> isVertical [

	^thisCell x = otherCell x
	
]

{ #category : #accessing }
SudokuPairCell >> otherCell [

	^otherCell 
]

{ #category : #accessing }
SudokuPairCell >> otherCell: aSudokuCell [

	otherCell := aSudokuCell 
	
]

{ #category : #accessing }
SudokuPairCell >> pairKinds [

	^pairKinds 
]

{ #category : #accessing }
SudokuPairCell >> pairKinds: aPairKinds [

	pairKinds := aPairKinds 
]

{ #category : #accessing }
SudokuPairCell >> pairOfNumbers [ 

	^pairOfNumbers 
]

{ #category : #accessing }
SudokuPairCell >> pairOfNumbers: anArray [

	pairOfNumbers := anArray 
]

{ #category : #printing }
SudokuPairCell >> printOn: aStream [	

	pairKinds = PairKinds onePair 
		ifTrue: [ aStream nextPutAll: '$'; nextPutAll: (pairOfNumbers at: 1) asString]
		ifFalse: [  
			pairKinds = PairKinds twoPairs 
				ifTrue: [ aStream nextPutAll: (pairOfNumbers at: 1) asString;
				 			nextPutAll: (pairOfNumbers at: 2) asString ]
			ifFalse: [ aStream nextPutAll: '???' ]]
			
				

]

{ #category : #accessing }
SudokuPairCell >> thisCell [

	^thisCell 
	
]

{ #category : #accessing }
SudokuPairCell >> thisCell: aSudokuCell [

	thisCell := aSudokuCell 
	
]

{ #category : #'accessing - structure variables' }
SudokuPairCell >> x [

	 ^thisCell x
	
]

{ #category : #'accessing - structure variables' }
SudokuPairCell >> y [

	 ^ thisCell y

	
]
