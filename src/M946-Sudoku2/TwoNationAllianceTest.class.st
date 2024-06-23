Class {
	#name : #TwoNationAllianceTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
TwoNationAllianceTest >> testGetBlankCellsAfterMark [

	| logger task board solver block blankCells |
	logger := M946Logger new: LogLevel debug.
	logger clearLog .
	logger debug: thisContext.
	
	task := '
8 9 0   0 6 0   0 2 3
4 0 0   1 0 3   0 0 8
0 0 0   0 0 0   0 0 0

0 2 0   0 0 0   0 4 0
1 0 0   0 0 0   0 0 5
0 7 0   0 0 0   0 6 0

0 0 0   0 0 0   0 0 0
5 0 0   3 0 4   0 0 1
9 4 0   0 2 0   0 8 6	
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := TwoNationAlliance new: board.
	block := board getBlock: 1 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 3.

	block := board getBlock: 2 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 6.

	block := board getBlock: 3 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 3.

	block := board getBlock: 4 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 6.

	block := board getBlock: 5 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 4.

	block := board getBlock: 6 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 2.

	block := board getBlock: 7 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 3.

	block := board getBlock: 8 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 3.

	block := board getBlock: 9 verifyNumber: 1.
	blankCells := solver getBlankCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 6.


]

{ #category : #tests }
TwoNationAllianceTest >> testSetAlliance [

	| logger task board solver block blankCells |
	logger := M946Logger new: LogLevel debug.
	logger clearLog .
	logger debug: thisContext.
	
	task := '
8 9 0   0 6 0   0 2 3
4 0 0   1 0 3   0 0 8
0 0 0   0 0 0   0 0 0

0 2 0   0 0 0   0 4 0
1 0 0   0 0 0   0 0 5
0 7 0   0 0 0   0 6 0

0 0 0   0 0 0   0 0 0
5 0 0   3 0 4   0 0 1
9 4 0   0 2 0   0 8 6	
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := TwoNationAlliance new: board.
	block := board getBlock: 6 verifyNumber: 1.
	blankCells := solver setAlliance: block.	
	logger debug: block.
	logger debug: board

]
