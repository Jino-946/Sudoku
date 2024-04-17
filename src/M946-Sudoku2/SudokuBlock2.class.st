Class {
	#name : #SudokuBlock2,
	#superclass : #Object,
	#instVars : [
		'blockA2D',
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

	^blockNumber 
]

{ #category : #initialization }
SudokuBlock2 >> initialize [ 

	super initialize .
	blockA2D := Array2D new:  3 element: 0.
	verifyNumber := 0.
	
]

{ #category : #accessing }
SudokuBlock2 >> verifyNumber [

	^verifyNumber 
]
