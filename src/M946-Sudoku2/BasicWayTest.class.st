Class {
	#name : #BasicWayTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
BasicWayTest >> testSudokuColumnAt [

		| task board  basicWay sudokuColumn array |
	task := '
1 9 7  0 0 4  2 0 5
6 8 0  5 3 0  9 0 0 
5 0 3  0 7 2  1 6 8
	
0 6 0  4 0 9  7 0 2
0 7 5  0 1 0  6 8 0 
2 0 9  8 0 7  0 4 0
	
7 5 6  3 2 0  4 0 1
0 0 1  0 4 5  0 2 6
8 0 4  1 0 0  3 5 7
'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	basicWay := NikoliWay new: board .
	
	sudokuColumn := basicWay sudokuColumnAt: 8.
	array := #(0 0 6  0 8 4  0 2 5).
	
	self assert: sudokuColumn column equals: array.
	
	
]

{ #category : #tests }
BasicWayTest >> testSudokuRowAt [

	| task board  basicWay sudokuRow array |
	task := '
1 9 7  0 0 4  2 0 5
6 8 0  5 3 0  9 0 0 
5 0 3  0 7 2  1 6 8
	
0 6 0  4 0 9  7 0 2
0 7 5  0 1 0  6 8 0 
2 0 9  8 0 7  0 4 0
	
7 5 6  3 2 0  4 0 1
0 0 1  0 4 5  0 2 6
8 0 4  1 0 0  3 5 7
'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	basicWay := NikoliWay new: board .
	
	sudokuRow := basicWay sudokuRowAt: 5.
	array := #(0 7 5  0 1 0  6 8 0).
	
	self assert: sudokuRow row equals: array.
	

]
