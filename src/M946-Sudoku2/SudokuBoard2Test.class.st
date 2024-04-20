Class {
	#name : #SudokuBoard2Test,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
SudokuBoard2Test >> testMap [
	| task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
7	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	3	7		4	0	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.

	"ブロック8のツモを確認する"
	block := board atBlock: 8.
	cell := block tsumo.

	board map: cell.	
	self assert: (board boardA2D at: 7 at: 5) equals: 9
	 
]
