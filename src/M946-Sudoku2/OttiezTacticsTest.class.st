Class {
	#name : #OttiezTacticsTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
OttiezTacticsTest >> testFindNextBlockPairCell [

	| logger task board solver block pairCell1 nextBlock |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.
	
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
	solver := OttiezTactics new: board.
	block := board getBlock: 6 verifyNumber: 1.
	pairCell1 :=  solver setAllianceForTest: block.
	logger info: block.	
	nextBlock := solver findNextBlock: block pairCells: pairCell1.
	logger info: nextBlock.
	 
	
	
]

{ #category : #tests }
OttiezTacticsTest >> testGetAllianceCellsAfterMark [

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
	solver := OttiezTactics new: board.
	block := board getBlock: 1 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 0.

	block := board getBlock: 2 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 0.

	block := board getBlock: 3 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 0.

	block := board getBlock: 4 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 0.

	block := board getBlock: 5 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.
	self assert: blankCells size equals: 0.

	block := board getBlock: 6 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 2.

	block := board getBlock: 7 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 0.

	block := board getBlock: 8 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 0.

	block := board getBlock: 9 verifyNumber: 1.
	blankCells := solver getAllianceCellsAfterMark: block.	
	logger debug: block.	
	self assert: blankCells size equals: 0.


]

{ #category : #tests }
OttiezTacticsTest >> testSetAlliance [

	| logger task board solver block |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.
	
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
	solver := OttiezTactics new: board.
	block := board getBlock: 6 verifyNumber: 1.
	solver setAlliance: block.
	logger info: block.
	logger info: board.


	block := board getBlock: 2 verifyNumber: 2.
	solver setAlliance: block.
	logger info: board.
	
	

	block := board getBlock: 7 verifyNumber: 3.
	solver setAlliance: block.
	logger info: board.
	block := board getBlock: 9 verifyNumber: 4.
	solver setAlliance: block.
	logger info: board.
	
	block := board getBlock: 4 verifyNumber: 4.
	solver setAlliance: block.
	logger info: board.

	block := board getBlock: 4 verifyNumber: 5.
	solver setAlliance: block.

	block := board getBlock: 3 verifyNumber: 6.
	solver setAlliance: block.


	board serializeToFileNamed: 'fuel/number6done.fuel'.
	


















]

{ #category : #tests }
OttiezTacticsTest >> testSetAlliancePartOfWay [

	| logger  board solver block |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/number6done.fuel';
        materializeRoot .
	logger info: board .
	
	solver := OttiezTactics new: board.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver setAlliance: block.

		
	logger info: board.
]
