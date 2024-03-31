Class {
	#name : #SudokuBoardTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku-Tests'
}

{ #category : #tests }
SudokuBoardTest >> testRowColumn [

	| sb |
	sb := SudokuBoard new.
	sb setDummy .
	
	self assert: (sb row: 3 column: 6) equals: 8.
	self assert: (sb row: 7 column: 5) equals: 2.
]

{ #category : #tests }
SudokuBoardTest >> testRowColumnPut [ 

	| sb |
	sb := SudokuBoard new.
	sb row: 3 column: 5 put: 7.
	
	self assert: (sb row: 3 column: 5) equals: 7
]
