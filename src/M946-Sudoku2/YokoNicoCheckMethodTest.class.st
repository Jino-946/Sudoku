Class {
	#name : #YokoNicoCheckMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
YokoNicoCheckMethodTest >> testNicoCellsNumber [


	| board solver task cells sudokuCell blockNumber elem|
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := YokoNicoCheckMethod new: board.
	
	"test block1 element8"
	blockNumber := 1.
	elem := 8.
	cells := solver nicoCells: blockNumber  number: elem.
	self assert: 2 equals: cells size.
	
	sudokuCell := SudokuCell row: 1 column: 4 element: elem.
	self assert: sudokuCell equals: (cells at: 1).	
		
	sudokuCell := SudokuCell row: 3 column: 9 element: elem.
	self assert: sudokuCell equals: (cells at: 2).
	
	"test block1 element5"	
	elem := 5.
	cells := solver nicoCells: blockNumber  number: elem .
	self assert: 2 equals: cells size.
	
	sudokuCell := SudokuCell row: 2 column: 4 element: elem .
	self assert: sudokuCell equals: (cells at: 1).	
		
	sudokuCell := SudokuCell row: 1 column: 7 element: elem .
	self assert: sudokuCell equals: (cells at: 2).

	
	
	
]

{ #category : #tests }
YokoNicoCheckMethodTest >> testNicoCheck [

	| board solver task |
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := YokoNicoCheckMethod new: board.
	
	self assert: #(5 8) sorted 	equals:  (solver nicoCheck: 1) sorted.
	self assert: #() 				equals:  (solver nicoCheck: 2).
	self assert: #(6)				equals:  (solver nicoCheck: 3).
	
	self assert: #(1 8 2) 	sorted equals:  (solver nicoCheck: 4) sorted.		
	self assert: #(7 8) 	sorted	equals:  (solver nicoCheck: 5) sorted.	
	self assert: #(6 8 9) 	sorted	equals:  (solver nicoCheck: 6) sorted.	
		
	self assert: #(8 5 2) 	sorted equals:  (solver nicoCheck: 7) sorted.		
	self assert: #(9)				equals:  (solver nicoCheck: 8).	
	self assert: #() 				equals:  (solver nicoCheck: 9).	
]
