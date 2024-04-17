Class {
	#name : #SudokuBoard2,
	#superclass : #Object,
	#instVars : [
		'boardA2D'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #accessing }
SudokuBoard2 >> atColumn: colIndex [

	^(boardA2D atColumn: colIndex) copy
]

{ #category : #accessing }
SudokuBoard2 >> atRow: rowIndex [
	"
	boardよりrowIndex指定した行(列配列)を返す。
	"

	^ (boardA2D  atRow: rowIndex) copy
]

{ #category : #accessing }
SudokuBoard2 >> boardA2D [

	^ boardA2D 
]

{ #category : #initialization }
SudokuBoard2 >> initialize [ 

	super initialize .
	boardA2D  := Array2D new:9 element: 0.
]
