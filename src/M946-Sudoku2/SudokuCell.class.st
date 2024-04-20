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

	^ sudokuCell class == self class
		and: [ sudokuCell rowIndex = self rowIndex 
			and: [ sudokuCell colIndex  = self colIndex 
				and: [ sudokuCell element = self element  ] ] ]
]

{ #category : #converting }
SudokuCell >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'rowIndex: '; nextPutAll: rowIndex asString; cr;
			nextPutAll: 'colIndex: '; nextPutAll: colIndex asString; cr;
			nextPutAll: 'element:  '; nextPutAll: element asString.
			
	^ aStream contents
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
