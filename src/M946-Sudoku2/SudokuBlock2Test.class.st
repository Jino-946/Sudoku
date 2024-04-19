Class {
	#name : #SudokuBlock2Test,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
SudokuBlock2Test >> testTenpai [ 

	| board block expected data|
	data := '

1	2	3		4	5	6		7	8	9	
2	3	4		5	6	7		8	9	1	
3	4	5		6	7	8		9	1	2	


4	5	6		7	8	9		1	2	3	
5	6	7		8	9	1		2	3	4	
6	7	8		9	0	2		3	4	5	


7	8	9		1	2	3		4	5	6	
8	9	1		2	3	4		5	6	0	
9	1	2		3	4	5		6	7	8		
	
	'.
	
board := SudokuBoard2 new.
board loadFromString: data.
block := board atBlock: 5.

expected := SudokuCell row: 6 column: 5 element: 0.
self assert: block tenpai equals: expected.

block := board atBlock: 9.
expected := SudokuCell row: 8 column: 9  element: 0.
self assert: block tenpai equals: expected .
]
