Class {
	#name : #OttiezTacticsTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
OttiezTacticsTest >> testFillTwoBlankCellsOfColumn [

	| logger  board solver block sudokuColumn |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/number6done.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver formBilateralAlliance: block.

	sudokuColumn := board getSudokuColumn: 1.
	logger info: board.
	solver fillTwoBlankCellsOfColumn: sudokuColumn .
	
	logger info: board.
]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance [

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
	solver formBilateralAlliance: block.
	logger info: block.
	logger info: board.


	block := board getBlock: 2 verifyNumber: 2.
	solver formBilateralAlliance: block.
	logger info: board.
	
	

	block := board getBlock: 7 verifyNumber: 3.
	solver formBilateralAlliance: block.
	logger info: board.
	block := board getBlock: 9 verifyNumber: 4.
	solver formBilateralAlliance: block.
	logger info: board.
	
	block := board getBlock: 4 verifyNumber: 4.
	solver formBilateralAlliance: block.
	logger info: board.

	block := board getBlock: 4 verifyNumber: 5.
	solver formBilateralAlliance: block.
	logger info: board.
	
	block := board getBlock: 3 verifyNumber: 6.
	solver formBilateralAlliance: block.
	logger info: board.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/number7done.fuel'.
	


















]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliancePartOfWay [

	| logger  board solver block sudokuRow |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/number6done.fuel';
        materializeRoot .
	logger info: board .
	
	solver := OttiezTactics new: board.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver formBilateralAlliance: block.

	logger info: board.
	
	sudokuRow := board getSudokuRow: 6.
	
	logger info: ( #(3 6) difference: (sudokuRow  row intersection: #(3 6))) 
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
OttiezTacticsTest >> testLetsRetsme [

	| logger  board solver block sudokuColumn |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/number6done.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver formBilateralAlliance: block.
	
	solver letsRetsme  .
	
	logger info: board.
]
