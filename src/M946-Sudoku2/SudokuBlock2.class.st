Class {
	#name : #SudokuBlock2,
	#superclass : #Object,
	#instVars : [
		'blockA2D',
		'rowsOnBoard',
		'colsOnBoard',
		'blockNumber',
		'verifyNumber'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #accessing }
SudokuBlock2 >> blockA2D [

	^ blockA2D 
]

{ #category : #accessing }
SudokuBlock2 >> blockNumber [ 
	"
	ブロック番号を返す
	"
	^blockNumber 
]

{ #category : #accessing }
SudokuBlock2 >> colsOnBoard [
	"
	ブロックの列に対応するボードの列を返す
	"
	^colsOnBoard 
]

{ #category : #initialization }
SudokuBlock2 >> initialize [ 

	super initialize .
	blockA2D := Array2D new:  3 element: 0.
	verifyNumber := 0.
	
]

{ #category : #accessing }
SudokuBlock2 >> rowsOnBoard [
	"
	ブロックの行に対応するボードの行を返す
	"
	^rowsOnBoard 
]

{ #category : #accessing }
SudokuBlock2 >> verifyNumber [
	"
	検証数字を返す
	"
	^verifyNumber 
]
