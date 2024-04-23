Class {
	#name : #LetsmeWayTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
LetsmeWayTest >> testLetsme [

	| task board block letsmeWay|
"
	task := '
0	4	0		0	8	1		0	7	3	
7	0	0		0	0	0		8	4	2	
0	0	8		4	0	7		0	0	5	


0	7	0		8	4	0		3	0	0	
4	8	5		0	6	0		7	0	1	
0	9	0		7	1	0		4	0	8	


8	3	7		0	0	0		0	0	0	
6	0	0		5	3	0		0	8	7	
0	0	0		1	7	8		0	3	0	
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	block := SudokuBlock2 sudokuBoard: board blockNumber: 8 verifyNumber: 5.

	letsmeWay := LetsmeWay new: board .
	letsmeWay letsme: block.
	
.
	self assert: (board boardA2D  at: 2 at: 5) equals: 5.	
"

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
block := SudokuBlock2 sudokuBoard: board blockNumber: 2 verifyNumber: 7.
letsmeWay := LetsmeWay new: board .
letsmeWay letsme: block.

self assert: (board boardA2D at: 8 at: 4) equals: 7.


]
