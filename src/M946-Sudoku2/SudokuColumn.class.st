"
数独ボードの列を表現するクラス

    Instance Variables
	column		<Array>			列の9つのセルの配列
	colIndex	<SmallInteger>	ボード上の列インデックス



"
Class {
	#name : #SudokuColumn,
	#superclass : #Object,
	#instVars : [
		'colIndex',
		'column'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'instance creation' }
SudokuColumn class >> new: index column: anArray [

	| sudokuColumn |
	sudokuColumn := self new.
	sudokuColumn colIndex: index.
	sudokuColumn column: anArray.
	
	^sudokuColumn 
]

{ #category : #accessing }
SudokuColumn >> colIndex [

	^colIndex 
]

{ #category : #accessing }
SudokuColumn >> colIndex: aNumber [

	colIndex := aNumber 
]

{ #category : #accessing }
SudokuColumn >> column [

	^column 
]

{ #category : #accessing }
SudokuColumn >> column: anArray [


	column := anArray 
]

{ #category : #comparing }
SudokuColumn >> hash [ 

	^ (colIndex hash bitXor:  column hash)
]

{ #category : #logic }
SudokuColumn >> tenpai [ 
	"
	列にブランクセル１つだけの時はブランクセルの位置をボード座標に変換して返す。
	でなければ0を返す。
	"
	| result |
	result := 0.
	((column select: [ :val | val = 0 ]) size) = 1
	ifTrue: [ result := SudokuCell row: (column indexOf: 0) column: colIndex element: 0 ].
	
	^ result
	
]
