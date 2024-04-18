"
数独ボードの一つのセルを表現するクラス

    Instance Variables
	row:		<SmallInteger>	ボードの行インデックス
	column:		<SmallInteger>	ボードの列インデックス
	element:	<Object>		セルの要素(1-9)
				
				
想定する使いみち
- ボードの指定座標に要素をセットする

- 上級課題を解決する時に作業用ボードにSBoardCellを配置する


"
Class {
	#name : #SBoardCell,
	#superclass : #Object,
	#instVars : [
		'row',
		'column',
		'element'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'as yet unclassified' }
SBoardCell class >> row: rowIndex column: colIndex element: elem [

	| cell |
	cell := self new.
	cell row: rowIndex .
	cell column: colIndex .
	cell element: elem.
	
	^ cell 
	

	
]

{ #category : #accessing }
SBoardCell >> column: colIndex [

	column := colIndex 
]

{ #category : #accessing }
SBoardCell >> element [

	^element 
]

{ #category : #accessing }
SBoardCell >> element: elem [

	element := elem
]

{ #category : #accessing }
SBoardCell >> row: rowIndex [

	row := rowIndex
]
