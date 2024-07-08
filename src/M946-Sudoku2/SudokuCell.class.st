"
数独ボードの一つのセルを表現するクラス

    Instance Variables
	rowIndex        <SmallInteger>	  ボードの行インデックス
	colIndex        <SmallInteger>	  ボードの列インデックス
	element	         <Object>		      セルの要素
	possibleNumbers <OrderedCollection> セルに入る可能性がある数
				
想定する使いみち
- ボードの指定座標に要素をセットする

- 上級課題を解決する時に作業用ボードにSudokuCellを配置する


"
Class {
	#name : #SudokuCell,
	#superclass : #Object,
	#instVars : [
		'rowIndex',
		'colIndex',
		'element',
		'possibleNumbers'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #creation }
SudokuCell class >> row: rIndex column: cIndex element: elem [

	| cell |
	cell := self new.
	cell rowIndex:  rIndex .
	cell colIndex:  cIndex .
	cell element: elem.
	cell possibleNumbers: OrderedCollection new.
	^ cell 
	

	
]

{ #category : #comparing }
SudokuCell >> = sudokuCell [

	^ sudokuCell class = self class
		and: [ sudokuCell rowIndex = self rowIndex 
			and: [ sudokuCell colIndex  = self colIndex 
				and: [ sudokuCell element = self element  ] ] ]
]

{ #category : #'as yet unclassified' }
SudokuCell >> asSpecialString [	
	"
	SudokuBoard2>>asStringでSudokuCellを見やすく表示するために使用するメソッド
	"
	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: '$'.
	possibleNumbers do: [ :num |
		aStream nextPutAll: num asString].

	^aStream contents 
			

]

{ #category : #converting }
SudokuCell >> asString [

	| aStream elem |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'rowIndex: '; nextPutAll: rowIndex asString; space;
			nextPutAll: 'colIndex: '; nextPutAll: colIndex asString; space.
	elem := element.
	element class = Character ifTrue: [ elem := '$', element asString ].
	aStream nextPutAll: 'element:  '; nextPutAll: elem asString.
	aStream nextPutAll: ' possibleNumbers:( '.
	possibleNumbers do: [ :num |  aStream  nextPutAll: num asString; space].	
	aStream nextPutAll: ')'.
	^ aStream contents
]

{ #category : #accessing }
SudokuCell >> blockNumber [

	| number |
	number := 0.
	rowIndex < 4
		ifTrue: [
			number := 1.
			(colIndex between: 4 and: 6)
				ifTrue: [ number := 2 ]
				ifFalse: [ (colIndex between: 7 and: 9) ifTrue: [ number := 3 ] ] ]
		ifFalse: [
			(rowIndex between: 4 and: 6)
				ifTrue: [
					number := 4.
					(colIndex between: 4 and: 6)
						ifTrue: [ number := 5 ]
						ifFalse: [ (colIndex between: 7 and: 9) ifTrue: [ number := 6 ] ] ]
				ifFalse: [
					number := 7.
					(colIndex between: 4 and: 6)
						ifTrue: [ number := 8 ]
						ifFalse: [ (colIndex between: 7 and: 9) ifTrue: [ number := 9 ] ] ] ].
	^ number
]

{ #category : #'as yet unclassified' }
SudokuCell >> clearPossibleNumbers [	

	self possibleNumbers: OrderedCollection new.
]

{ #category : #accessing }
SudokuCell >> colIndex [ 

	^colIndex 
]

{ #category : #accessing }
SudokuCell >> colIndex: index [

	colIndex  := index 
]

{ #category : #accessing }
SudokuCell >> direction: anotherCell [

	self colIndex = anotherCell colIndex ifTrue: [ ^CellDirection vertical ].
	self rowIndex = anotherCell rowIndex ifTrue: [ ^CellDirection horizontal ].
	^CellDirection diagonal 
]

{ #category : #accessing }
SudokuCell >> element [

	^element 
]

{ #category : #accessing }
SudokuCell >> element: elem [

	element := elem
]

{ #category : #comparing }
SudokuCell >> hash [ 

	^ ((( rowIndex hash bitXor: colIndex hash)
			bitXor:  element hash))
]

{ #category : #accessing }
SudokuCell >> possibleNumbers [

	^possibleNumbers 
]

{ #category : #accessing }
SudokuCell >> possibleNumbers: anOrderedCollection [

	possibleNumbers := anOrderedCollection 
]

{ #category : #printing }
SudokuCell >> printOn: aStream [

	aStream nextPutAll: self asString; cr.
]

{ #category : #accessing }
SudokuCell >> rowIndex [

	^rowIndex 
]

{ #category : #accessing }
SudokuCell >> rowIndex: index [

	rowIndex := index
]

{ #category : #comparing }
SudokuCell >> sameCoordinates: aSudokuCell [

	^self x = aSudokuCell x and: [ self y = aSudokuCell y ]
]

{ #category : #'accessing - structure variables' }
SudokuCell >> x [

^colIndex 
]

{ #category : #'accessing - structure variables' }
SudokuCell >> x: index [

	colIndex := index
]

{ #category : #'accessing - structure variables' }
SudokuCell >> y [

	^rowIndex 
]

{ #category : #'accessing - structure variables' }
SudokuCell >> y: index [

	rowIndex := index
]
