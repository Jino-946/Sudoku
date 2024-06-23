"
数独ボードの一つのセルを表現するクラス

    Instance Variables
	rowIndex	<SmallInteger>	ボードの行インデックス
	colIndex	<SmallInteger>	ボードの列インデックス
	element		<Object>		セルの要素
				
				
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
		'element'
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
	
	^ cell 
	

	
]

{ #category : #comparing }
SudokuCell >> = sudokuCell [

	^ sudokuCell class = self class
		and: [ sudokuCell rowIndex = self rowIndex 
			and: [ sudokuCell colIndex  = self colIndex 
				and: [ sudokuCell element = self element  ] ] ]
]

{ #category : #converting }
SudokuCell >> asString [

	| aStream elem |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'rowIndex: '; nextPutAll: rowIndex asString; space; space;
			nextPutAll: 'colIndex: '; nextPutAll: colIndex asString; space; space.
	elem := element.
	element class = Character ifTrue: [ elem := '$', element asString ].
	aStream nextPutAll: 'element:  '; nextPutAll: elem asString.
			
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

{ #category : #accessing }
SudokuCell >> colIndex [ 

	^colIndex 
]

{ #category : #accessing }
SudokuCell >> colIndex: index [

	colIndex  := index 
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
