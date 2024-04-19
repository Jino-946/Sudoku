"
数独ボードの行を表現するクラス

    Instance Variables
	row			<Array>				行の9つのセルの配列
	rowIndex	<SmallInteger>		ボード上の行インデックス


  
"
Class {
	#name : #SudokuRow,
	#superclass : #Object,
	#instVars : [
		'rowIndex',
		'row'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'instance creation' }
SudokuRow class >> new: index row: anArray [

	|sudokuRow|
	sudokuRow := self new.
	sudokuRow rowIndex: index.
	sudokuRow row: anArray.
	
	^sudokuRow

]

{ #category : #comparing }
SudokuRow >> hash [ 

	^ (rowIndex hash bitXor: row hash)
]

{ #category : #accessing }
SudokuRow >> row [

	^row
]

{ #category : #accessing }
SudokuRow >> row: anArray [

	row := anArray 
]

{ #category : #accessing }
SudokuRow >> rowIndex [

	^rowIndex 
]

{ #category : #accessing }
SudokuRow >> rowIndex: aNumber [

	rowIndex := aNumber.
]

{ #category : #logic }
SudokuRow >> tenpai [ 
	"
	行にブランクセル１つだけの時はブランクセルの位置をボード座標に変換して返す。
	でなければ0を返す。
	"
	| result |
	result := 0.
	((row select: [ :val | val = 0 ]) size) = 1
	ifTrue: [ result := SudokuCell row: rowIndex  column: (row indexOf: 0)  element: 0 ].
	
	^ result
	
]
