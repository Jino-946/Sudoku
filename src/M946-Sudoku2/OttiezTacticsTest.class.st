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

	| logger task board ottie block |
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
	ottie := OttiezTactics new: board.
	logger info: board.
	block := board getBlock: 6 verifyNumber: 1.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance2.fuel'.
	

"

	block := board getBlock: 7 verifyNumber: 2.
	logger info: ('3rd block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	block := board getBlock: 9 verifyNumber: 4.
	logger info: ('4th block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/formBilateralAllianceB4N4.fuel'.


	block := board getBlock: 4 verifyNumber: 4.
	logger info: ('5th block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.

	block := board getBlock: 4 verifyNumber: 5.
	logger info: ('6th block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/number5done.fuel'.

	block := board getBlock: 3 verifyNumber: 6.
	logger info: ('7th block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	board serializeToFileNamed: 'fuel/number6done.fuel'.
	
	block := board getBlock: 7 verifyNumber: 7.
	logger info: ('8th block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/number7done.fuel'.
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance2.fuel'.


"














]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance2 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance2.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	
	block := board getBlock: 2 verifyNumber: 2.
	logger info: ('2nd block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAlliance3.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance3 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel trace.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance3.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 7 verifyNumber: 2.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance4.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance4 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance4.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 7 verifyNumber: 3.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance5.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance5 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance5.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 9 verifyNumber: 4.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance6.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance6 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new: thisContext.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance6.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger debug: board.

	block := board getBlock: 4 verifyNumber: 4.
	logger debug: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger debug: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance7.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance7 [
	"再帰無限ループ発生 テスト注意"
	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance7.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 4 verifyNumber: 5.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance8.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance8 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance8.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 3 verifyNumber: 6.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAlliance9.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAlliance9 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAlliance9.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 7 verifyNumber: 7.
	logger info: ('1st block => {1}' format: { block  }).
	ottie formBilateralAlliance: block.
	logger info: board.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA1.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA1 [
	"
	
	"
	| logger  board ottie |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA1.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	self assert: (board boardA2D at: 4 at: 1) equals: 0.
	self assert: (board boardA2D at: 6 at: 1) equals: 0.
	ottie letsRetsme.
	logger info: board.
	self assert: (board boardA2D at: 4 at: 1) equals: 6.
	self assert: (board boardA2D at: 6 at: 1) equals: 3.
	
	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA2.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA2 [
	"
	
	"
	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA2.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 5 verifyNumber: 3.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA3.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA3 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA3.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 7 verifyNumber: 6.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA4.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA4 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA4.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 5 verifyNumber: 6.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA5.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA5 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA5.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 7 verifyNumber: 8.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA6.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA6 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA6.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 6 verifyNumber: 8.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA7.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA7 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 6 verifyNumber: 3.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA8.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA8 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA8.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 3 verifyNumber: 5.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceA9.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceA9 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA9.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 5 verifyNumber: 5.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceB1.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceB1 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceB1.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 3 verifyNumber: 7.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceB2.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceB2 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceB2.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.

	block := board getBlock: 2 verifyNumber: 8.
	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceB3.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceB3 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceB3.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	
	"
	block := board getBlock: 5 verifyNumber: 8.
	"
	block := board getBlock: 2 verifyNumber: 9.

	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceB4.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceB4 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceB4.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	
	
	block := board getBlock: 8 verifyNumber: 9.

	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceB5.fuel'.
	

]

{ #category : #tests }
OttiezTacticsTest >> testFormBilateralAllianceB5 [

	| logger  board ottie block |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceB5.fuel';
        materializeRoot .
	ottie := OttiezTactics new: board.
	logger info: board.
	
	
	block := board getBlock: 8 verifyNumber: 7.

	ottie formBilateralAlliance: block.
	logger info: board.

	board serializeToFileNamed: 'fuel/testFormBilateralAllianceB6.fuel'.
	

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
