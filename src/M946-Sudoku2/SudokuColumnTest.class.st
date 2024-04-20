Class {
	#name : #SudokuColumnTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
SudokuColumnTest >> testTenpai [

	|task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
7	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	0	7		4	9	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	
	self assert: (block colsOnBoard at: 2) column equals: #(7 1 4   9 6 8   0 2 5).
	
	cell := SudokuCell row: 7 column: 2  element: 0.
	self assert: (block colsOnBoard at: 2) tenpai  equals: cell.
	
]

{ #category : #tests }
SudokuColumnTest >> testTsumo [ 

	|task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
7	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	0	7		4	9	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	
	self assert: (block colsOnBoard at: 2) column equals: #(7 1 4   9 6 8   0 2 5).
	
	cell := SudokuCell row: 7 column: 2  element: 3.
	self assert: (block colsOnBoard at: 2) tsumo  equals: cell.
]
