Class {
	#name : #OttiezTacticsTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
OttiezTacticsTest >> test2PairTenpai [
	| logger  board solver block  tsumoCell |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
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
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
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
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
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
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
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
	logger info: ('1st block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	

	block := board getBlock: 2 verifyNumber: 2.
	logger info: ('2nd block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	
	

	block := board getBlock: 7 verifyNumber: 3.
	logger info: ('3rd block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	
	block := board getBlock: 9 verifyNumber: 4.
	logger info: ('4rh block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/formBilateralAllianceB4N4.fuel'.


	block := board getBlock: 4 verifyNumber: 4.
	logger info: ('5th block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.

	block := board getBlock: 4 verifyNumber: 5.
	logger info: ('6th block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/number5done.fuel'.

	block := board getBlock: 3 verifyNumber: 6.
	logger info: ('7th block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/number6done.fuel'.
	
	block := board getBlock: 7 verifyNumber: 7.
	logger info: ('8th block => {1}' format: { block  }).
	solver formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/number7done.fuel'.
	


















]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceB4N4 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	
	board := FLMaterializer new 
        filePath: 'fuel/formBilateralAllianceB4N4.fuel' ;
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	
	block := board getBlock: 4 verifyNumber: 4.
	ottie formBilateralAlliance: block.
	logger info: board.
	
	
	block := board getBlock: 4 verifyNumber: 5.
	ottie formBilateralAlliance: block.
	logger info: board.
	
]

{ #category : #tests }
OttiezTacticsTest >> testGetAllianceCellsAfterMark [

	| logger task board solver block blankCells |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
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
	"ブロック4列3における非対称ペアのテスト"
	| logger  solver board thisCell cell1 cell2  block candidates |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.


	board := FLMaterializer new 
        filePath: 'fuel/testGetNextBlockOfAsymmetricPairCells.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	logger info: board.
	
	cell1 := nil.
	cell2 := nil.
	
	logger info: 'テスト1 セル3@4 => 5 '.
	thisCell := board getCellRow: 4 cellColumn: 3.
	thisCell element: 5.
	
	block := board getBlock: 4 verifyNumber: 5.
	candidates := solver getAlliedCellForMapping: block cell: thisCell.
	logger info: candidates .
	self assert: candidates size equals: 1.
	cell1 := board getCellRow: 6 cellColumn: 3.
	self assert: (candidates at: 1) equals: cell1.
	
	logger info: 'テスト2 セル3@5 => 4 '.	
	thisCell := board getCellRow: 5 cellColumn: 3.
	thisCell element: 4.
	
	block := board getBlock: 4 verifyNumber: 4.
	candidates := solver getAlliedCellForMapping: block cell: thisCell.
	logger info: candidates .
	self assert: candidates size equals: 1.
	cell1 := board getCellRow: 6 cellColumn: 3.
	self assert: (candidates at: 1) equals: cell1.
		
	logger info: 'テスト3 セル3@6 => 4 '.
	" テスト3 セル 3@6 => 4  "
	thisCell := board getCellRow: 6 cellColumn: 3.
	thisCell element: 4.
	
	block := board getBlock: 4 verifyNumber: 4.
	candidates := solver getAlliedCellForMapping: block cell: thisCell.
	logger info: candidates .
	self assert: candidates size equals: 2.

	cell1 := board getCellRow: 4 cellColumn: 3. 
	self assert: (candidates at: 1) equals: cell1.	
	cell2 := board getCellRow: 5 cellColumn: 3. 
	self assert: (candidates at: 2) equals: cell2.	

	logger info: 'テスト4 セル3@6 => 5 '.	 
	thisCell := board getCellRow: 6 cellColumn: 3.
	thisCell element: 5.
	
	block := board getBlock: 4 verifyNumber: 4.
	candidates := solver getAlliedCellForMapping: block cell: thisCell.
	logger info: candidates .
	self assert: candidates size equals: 2.

	cell1 := board getCellRow: 4 cellColumn: 3. 
	self assert: (candidates at: 1) equals: cell1.	
	cell2 := board getCellRow: 5 cellColumn: 3. 
	self assert: (candidates at: 2) equals: cell2.	

	logger info: 'テスト5 セル3@4 => 9'.	 
	thisCell := board getCellRow: 4 cellColumn: 3.
	thisCell element: 9.
	
	block := board getBlock: 4 verifyNumber: 9.
	candidates := solver getAlliedCellForMapping: block cell: thisCell.
	logger info: candidates .
	self assert: candidates size equals: 2.

	cell1 := board getCellRow: 5 cellColumn: 3. 
	self assert: (candidates at: 1) equals: cell1.	
	cell2 := board getCellRow: 6 cellColumn: 3. 
	self assert: (candidates at: 2) equals: cell2.	
	 						
	

]

{ #category : #tests }
OttiezTacticsTest >> testGetAlliedCellForMappingNoPairNumberCell [
	| logger  ottie board thisCell  block |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.


	board := FLMaterializer new 
        filePath: 'fuel/testGetNextBlockOfAsymmetricPairCells.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	
	block := board getBlock: 4 verifyNumber: 9.
	logger info: block .
	thisCell := (board getCellRow: 5 cellColumn: 3) copy.
	thisCell element: 9.
	ottie getAlliedCellForMappingNoPairNumber: block cell: thisCell.
	thisCell clearPossibleNumbers .
	board map: thisCell.
	self assert: (board boardA2D at: 4 at: 3 ) equals: 5.
	self assert: (board boardA2D at: 6 at: 3) equals: 4.
	logger info: board.
	
	board := FLMaterializer new 
        filePath: 'fuel/testGetNextBlockOfAsymmetricPairCells.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	block := board getBlock: 4 verifyNumber: 9.
	logger info: block .	
	thisCell := (board getCellRow: 6 cellColumn: 3) copy.
	thisCell element: 9.
	ottie getAlliedCellForMappingNoPairNumber: block cell: thisCell.
	thisCell clearPossibleNumbers .
	board map: thisCell.
	self assert: (board boardA2D at: 4 at: 3 ) equals: 5.
	self assert: (board boardA2D at: 5 at: 3) equals: 4.
	logger info: board.


]

{ #category : #tests }
OttiezTacticsTest >> testGetNextBlockOfAsymmetricPairCells [
	"
	BilateralAllianceTest>>testDetermineTheNumberBlock5Col2に対応する結合テスト
	"
	| logger solver board block blankCells thisCell |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
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
	
	self assert: (board boardA2D at: 4 at: 5 ) equals: 3.
	self assert: (board boardA2D at: 5 at: 5 ) equals: 0.
	self assert: (board boardA2D at: 6 at: 5 ) equals: 1.

]

{ #category : #tests }
OttiezTacticsTest >> testGetNextBlockOfPairBlankCellsCells [

	| logger task board solver block blankCells nextBlock|
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
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
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
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
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
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
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
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
