Class {
	#name : #OttiezTacticsTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
OttiezTacticsTest >> test2PairTenpai [
	| logger  board solver block  tsumoCell |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/2pairTenpai.fuel';
        materializeRoot .
	logger info: board .
	solver := OttiezTactics new: board.
	block := board getBlock: 7.
	logger info: block.
	
	tsumoCell := block twoPairsTenpai .
	logger info: tsumoCell.
	
]

{ #category : #tests }
OttiezTacticsTest >> testCheckForTwoPairs [

	| logger  board solver block  newBlankCells expected |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/checkForTwoPairsBlankCells.fuel';
        materializeRoot .
	logger info: board .
	solver := OttiezTactics new: board.
	
	block := board getBlock: 6 verifyNumber: 3.
	solver getAllianceCellsAfterMark: block.
	newBlankCells := solver checkForTwoPairs: block .
	logger info: newBlankCells .
	
	expected := Array new: 2.
	expected at: 1 put: (SudokuCell row: 5 column: 7 element: 0).
	expected at: 2 put: (SudokuCell row: 5 column: 8 element: 0).
	
	
	self assert: newBlankCells  equals: expected .
	
]

{ #category : #tests }
OttiezTacticsTest >> testFillTwoBlankCellsOfColumn [
	"
	ブロック7検証番号7でformBilateralAlliance 実行後の
	第1列の２つのブランクセルを埋める
	"
	| logger  board solver block sudokuColumn column |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/number6done.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver formBilateralAlliance: block.
	logger info: board.
	
	sudokuColumn := board getSudokuColumn: 1.
	solver fillTwoBlankCellsOfColumn: sudokuColumn .
	column := board getSudokuColumn: 1.
	self assert: (column column at: 4) equals: 6.
	self assert: (column column at: 6) equals: 3.
	logger info: board.
]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance [

	| logger task board solver block |

	logger := M946FileLogger new: LogLevel info.
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
	logger info: board.
	logger info: (board getSudokuCell: 7@4).
	

	block := board getBlock: 2 verifyNumber: 2.
	solver formBilateralAlliance: block.
	logger info: board.
	
	"

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
	board serializeToFileNamed: 'fuel/number5done.fuel'.

	block := board getBlock: 3 verifyNumber: 6.
	solver formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/number6done.fuel'.
	
	block := board getBlock: 7 verifyNumber: 7.
	solver formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/number7done.fuel'.
	
	"


















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
OttiezTacticsTest >> testGetAlliedCellForMappingCell [
	| logger  solver board cell1 cell2 cell3  block candidates |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	logger info: board .
	solver := OttiezTactics new: board.
	cell1  := SudokuCell row: 4 column: 5 element: 3.
	cell1 possibleNumbers add: 1.
	cell1 possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: cell1 copy.
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2 copy.
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3 copy.
	logger info: board.
	
	block := board getBlock: 5 verifyNumber: 3.
	candidates := solver getAlliedCellForMapping: block cell: cell1.
	logger info: candidates .
	self assert: candidates size equals: 2.
	self assert: (candidates at: 1) equals: cell3.
	self assert: (candidates at: 2) equals: cell2.
	
	
	
]

{ #category : #tests }
OttiezTacticsTest >> testGetNextBlockOfAsymmetricPairCells [
	"
	BilateralAllianceTest>>testDetermineTheNumberBlock5Col2に対応する結合テスト
	"
	| logger solver board block blankCells thisCell |
	logger := M946FileLogger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.
	
	board := FLMaterializer new 
        filePath: 'fuel/testGetNextBlockOfAsymmetricPairCells.fuel';
        materializeRoot .
	logger info: board.
	solver := OttiezTactics new: board .
	thisCell  := SudokuCell row: 4 column: 5 element: 3.
	thisCell possibleNumbers add: 1.
	thisCell possibleNumbers add: 3. 
	
	block := board getBlock: 5 verifyNumber: 3.
	blankCells := solver getAlliedCellForMapping: block cell: thisCell.
	solver getNextBlockOfAsymmetricPair: block thisCell: thisCell  cells: blankCells .
	logger info: board.
	
	self assert: (board boardA2D at: 5 at: 5 ) equals: 0.
	self assert: (board boardA2D at: 5 at: 5 ) equals: 0.
	self assert: (board boardA2D at: 6 at: 5 ) equals: 1.

]

{ #category : #tests }
OttiezTacticsTest >> testGetNextBlockOfPairBlankCellsCells [

	| logger task board solver block blankCells nextBlock|
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
	blankCells := solver getAllianceCellsAfterMark: block.	
	self assert: blankCells size equals: 2.
	logger info: (blankCells at: 1) asString.
	logger info: (blankCells at: 2) asString.
	
	nextBlock := solver getNextBlockOfPairBlankCells: block cells: blankCells.
	logger info: board .

	logger info: (board getSudokuCell: 7@4) asString.

]

{ #category : #tests }
OttiezTacticsTest >> testLetsRetsme [

	| logger  board solver  |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/number7done.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	
	logger info: board.
	logger info: (board getSudokuCell: 4@3).
	
	solver letsRetsme: 1  .
	solver letsRetsme: 2.
	solver letsRetsme: 3.
	logger info: board.
	"SudokuBoard>>removePossibleNumbersOfRowAndCol: のテスト用にboardをシリアライズ"
	board serializeToFileNamed: 'fuel/forRemovePossibleNumbers.fuel'.
	solver letsRetsme: 4.
	solver letsRetsme: 5.
	solver letsRetsme: 6.
	solver letsRetsme: 7.
	solver letsRetsme: 8.
	solver letsRetsme: 9.	
	logger info: board.
]

{ #category : #tests }
OttiezTacticsTest >> testN3Block1AutoFillPair5 [

	| logger  board solver block |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/forRemovePossibleNumbers.fuel';
        materializeRoot .
	logger info: board .
	
	solver := OttiezTactics new: board.
	
	block := board getBlock: 1 verifyNumber: 3.
	solver formBilateralAlliance: block.
	
	self assert: (board boardA2D at: 3 at: 2 ) equals: 3. 
	self assert: (board boardA2D at: 2 at: 2 ) equals: 5. 
	logger info: board.
	
	board serializeToFileNamed: 'fuel/n3Block1AutoFillPair5.fuel'.
	
]

{ #category : #tests }
OttiezTacticsTest >> testN3Block5OnePair3 [
	"
	6分26秒から
	"
	| logger  board solver block |
	M946FileLogger clearLog.
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.
	(M946FileLogger new) clearLog.
	board := FLMaterializer new 
        filePath: 'fuel/n3Block1AutoFillPair5.fuel';
        materializeRoot .
	logger info: board .
	solver := OttiezTactics new: board.
	
	block := board getBlock: 5 verifyNumber: 3.
	solver formBilateralAlliance: block.
	
	block := board getBlock: 7 verifyNumber: 6.
	solver formBilateralAlliance: block.

	
	block := board getBlock: 5 verifyNumber: 6.
	solver formBilateralAlliance: block.
	logger info: board.

	block := board getBlock: 6 verifyNumber: 3.
	solver formBilateralAlliance: block.
	logger info: board.

	
	
	block := board getBlock: 5 verifyNumber: 6.
	solver formBilateralAlliance: block.
	logger info: board.


	block := board getBlock: 6 verifyNumber: 8.
	solver formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/checkForTwoPairsBlankCells.fuel'.
	
	block := board getBlock: 6 verifyNumber: 3.
	solver formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/N3Block5_OnePair3_OnePair1.fuel'.		
"	
	block := board getBlock: 5 verifyNumber: 3.
	solver formBilateralAlliance: block.
	logger info: board.
"
	
]
