Class {
	#name : #SudokuHorGroupTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
SudokuHorGroupTest >> testAtBlock [

	| task board group expectedBlock |
	task := '
	9	4	7		6	5	3		2	1	8	
	8	6	1		9	2	7		3	5	4	
	2	3	5		0	0	4		7	9	6	

	0	0	0		0	0	2		0	4	9	
	4	2	9		0	0	1		0	0	0	
	0	0	6		4	0	9		0	0	2	

	0	9	2		7	4	0		0	6	0	
	6	0	4		0	0	0		9	2	7	
	5	7	0		2	9	6		4	0	0	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	
	group := board atHorGroup: 3.
	
	expectedBlock := board atBlock: 9.
	
	self assert: (group atBlock: 3) asString equals: expectedBlock asString
	
	

	
]

{ #category : #tests }
SudokuHorGroupTest >> testAtSudokuColumn [


	| task board group |
	task := '
	9	4	7		6	5	3		2	1	8	
	8	6	1		9	2	7		3	5	4	
	2	3	5		0	0	4		7	9	6	

	0	0	0		0	0	2		0	4	9	
	4	2	9		0	0	1		0	0	0	
	0	0	6		4	0	9		0	0	2	

	0	9	2		7	4	0		0	6	0	
	6	0	4		0	0	0		9	2	7	
	5	7	0		2	9	6		4	0	0	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	
	group := board atHorGroup: 2.
	self assert: (group atSudokuColumn: 3) equals: (board atSudokuColumn: 3).
	self assert: (group atSudokuColumn: 7) equals: (board atSudokuColumn: 7).
	
	
	group := board atHorGroup: 3.
	self assert: (group atSudokuColumn: 3) equals: (board atSudokuColumn: 3).
	self assert: (group atSudokuColumn: 9) equals: (board atSudokuColumn: 9)

	
 
]

{ #category : #tests }
SudokuHorGroupTest >> testAtSudokuRow [

	| task board group |
	task := '
	9	4	7		6	5	3		2	1	8	
	8	6	1		9	2	7		3	5	4	
	2	3	5		0	0	4		7	9	6	

	0	0	0		0	0	2		0	4	9	
	4	2	9		0	0	1		0	0	0	
	0	0	6		4	0	9		0	0	2	

	0	9	2		7	4	0		0	6	0	
	6	0	4		0	0	0		9	2	7	
	5	7	0		2	9	6		4	0	0	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.

	group := board atHorGroup: 1.	
	self assert: (group atSudokuRow: 3) equals: (board atSudokuRow: 3).
	
	group := board atHorGroup: 3.	
	self assert: (group atSudokuRow: 3) equals: (board atSudokuRow: 9).
	

]
