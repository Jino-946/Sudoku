Class {
	#name : 'SudokuBoard2Test',
	#superclass : 'TestCase',
	#category : 'M946-Sudoku2-Tests',
	#package : 'M946-Sudoku2',
	#tag : 'Tests'
}

{ #category : 'private' }
SudokuBoard2Test >> performTest [ 

    | logger |
    logger := TinyLogger new addTranscriptLogger ; yourself .
    logger  timestampFormatBlock: [ :aStream :timestamp |
            timestamp asDate yyyymmdd printOn: aStream.
            aStream << ' '.
            timestamp asTime print24: true on: aStream ].
    logger clearLog.
    
    TinyCurrentLogger value: logger during: [ super performTest ]
]

{ #category : 'tests' }
SudokuBoard2Test >> testAllianceProcessingBuddyCellInTheBlock2 [
	"
	セルに入る数字が確定したあと,関連するブロックの確定数字を予約数字に持つペアセル
	の動作をテストする。
	非対称ペアのテスト
	"
	| logger  board  pairCells thisCell bag |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := MDeserialize fileNamed: 'fuel/testFormBilateralAllianceA7.fuel'.

	logger info: board.

	"
	6block<7@6>1が確定することで5block<5@6>の予約数字1が無くなったと仮定する
	"	
	thisCell := board getSudokuCell: 5@6.
	pairCells := board allianceProcessingBuddyCellInTheBlock: thisCell confirmNumber: 1.
	pairCells do: [ :cell | cell clearPossibleNumbers  ].
	logger info: ('actual => 
{1}' format: {pairCells}).	
	self assert: pairCells class equals: Array.
	bag := Bag new.
	bag add: (SudokuCell row: 4 column: 5  element: 1) .
	bag add: (SudokuCell row: 5 column: 5 element: 3).
	bag add: (SudokuCell row: 6 column: 5 element: 0).
	logger info: ('expected => 
{1}' format: {bag}).	
	self assert: pairCells asBag  equals: bag.


	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	"
	8block<5@7>8が確定することで7block<3@7>の予約数字8が無くなったと仮定する	
	"
	thisCell := board getSudokuCell: 3@7.
	pairCells := board allianceProcessingBuddyCellInTheBlock: thisCell confirmNumber: 8.
	bag := Bag new.
	bag add: ((SudokuCell row: 7 column: 3 element: 0) addPossibleNumber: 3).
	bag add: (SudokuCell row: 8 column: 3  element: 8) .
	bag add: ((SudokuCell row: 9 column: 3 element: 0) addPossibleNumber: 3).
	
	logger info: ('pairCells => 
{1}' format: {pairCells}).
	logger info: ('bag => 
{1}' format: {bag}).

	self assert: pairCells asBag equals: bag.
	

	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .

	"
	9block<7@9>3が確定し, 7block<3@9>のワンペアが解除されたと仮定する
	"
	thisCell := board getSudokuCell: 3@9.
	pairCells := board allianceProcessingBuddyCellInTheBlock: thisCell confirmNumber: 3.
	logger info: ('actual => 
{1}' format: {pairCells}).	
	self assert: pairCells class equals: Array.
	bag := Bag new.
	bag add: (SudokuCell row: 9 column: 3 element: 0).
	bag add: (SudokuCell row: 7 column: 3  element: 3).
	bag add: (SudokuCell row: 8 column: 3 element: 8).
	logger info: ('expected => 
{1}' format: {bag}).
	self assert: pairCells asBag equals: bag.
	

]

{ #category : 'tests' }
SudokuBoard2Test >> testAllianceProcessingOfCol [
	"
	block3の<7@3>4が確定したと仮定した時、block9の4のワンペアが解決することをテストする。 
	"
	| logger  board  cells confirmedCell bag |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := MDeserialize fileNamed: 'fuel/testFormBilateralAllianceA7.fuel'.

	logger info: board.
	confirmedCell  := (board getSudokuCell: 7@3) deepCopy.
	confirmedCell  element: 4.
	confirmedCell  clearPossibleNumbers .
	

	cells := board allianceProcessingOfCol: confirmedCell .
	logger info: cells.
	
	bag := Bag new.
	bag add: (SudokuCell row: 3 column: 7  element: 4).
	bag add: (SudokuCell row: 7 column: 7  element: 0).
	bag add: (SudokuCell row: 7 column: 9  element: 4).
	
	

]

{ #category : 'tests' }
SudokuBoard2Test >> testAllianceProcessingOfRow [

	| logger  board  cells confirmedCell bag cell1 cell2 cell3|
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	
	" テスト1
	block5の<5@6>1が確定したと仮定した時、block6の18ツーペアが解決することをテストする。 
	#(?18 0 ?8)  =>  #(1 0 8)
	"	
	board := MDeserialize fileNamed: 'fuel/testFormBilateralAllianceA7.fuel'.

	logger info: board.
	confirmedCell  := board getSudokuCell: 5@6.
	confirmedCell  element: 1.
	confirmedCell  clearPossibleNumbers .
	
	cells := board allianceProcessingOfRow: confirmedCell  .
	bag := Bag new.
	bag add:(SudokuCell row: 4 column: 7  element: 1 ).
	bag add:(SudokuCell row: 6 column: 7  element: 8 ).
	self assert: cells asBag equals: bag.

	"テスト2
	block5の<5@5>4が確定したと仮定した時、block4<3@4>の予約数字4が消え
	非対称ペアが解消することをテストする。 
	#(?5 ?4 ?45) => #(5 0 4)
	"	
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	confirmedCell  := board getSudokuCell: 5@5.
	confirmedCell  element: 4.
	confirmedCell  clearPossibleNumbers .
	
	cells := board allianceProcessingOfRow: confirmedCell  .
	bag := Bag new.
	
	cell1 := SudokuCell row: 5 column: 3 element: 0.
	cell2 := SudokuCell row: 4 column: 3 element: 5.
	cell3 := SudokuCell row: 6 column: 3 element: 4.
	bag add: cell1; add: cell2; add: cell3.
	self assert: cells asBag equals: bag.

	
	" テスト3
	block8の<5@7>8が確定したと仮定した時、block7<3@7>の予約数8が消え
	非対称ペアが解消することをテストする。 
	#(?38 ?8 ?3) => #(?3 8 ?3)
	"	
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	confirmedCell  := board getSudokuCell: 5@7.
	confirmedCell  element: 8.
	confirmedCell  clearPossibleNumbers .
	
	cells := board allianceProcessingOfRow: confirmedCell  .
	self assert: (board boardA2D at: 7 at: 3) equals: ((SudokuCell row: 7 column: 3 element: 0) addPossibleNumber: 3).
	self assert: cells class equals: Array.
	bag := Bag new.
	cell1 := SudokuCell row: 8 column: 3 element: 8.
	cell2 := (SudokuCell row: 9 column: 3 element: 0) addPossibleNumber: 3.
	cell3 := (SudokuCell row: 7 column: 3 element: 0) addPossibleNumber: 3.
	bag add: cell1; add: cell2; add: cell3.
	self assert: cells asBag equals: bag.



]

{ #category : 'tests' }
SudokuBoard2Test >> testMap [
	"
	ブロックのマッピングは別にtestMapSudokuBlock2で行う
	"
	| task board  cell row column |
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
	
	cell := SudokuCell row: 4 column: 5 element: $X.
	board map: cell.	
	self assert: (board boardA2D at: 4 at: 5) equals: $X.
	
	row := board getSudokuRow: 7.
	row at: 7 put: $X.
	row at: 9 put: $X.

	board map: row.
	self assert: (board getSudokuRow: 7) equals: row.
	
	column := board getSudokuColumn: 4.
	column at: 3 put: $X.
	column at: 4 put: $X.
	column at: 5 put: $X.
	board map: column.
	self assert: (board getSudokuColumn: 4) equals: column.
	
	
	
	 
]

{ #category : 'tests' }
SudokuBoard2Test >> testMap2 [

	| board comfirmedCell logger |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := MDeserialize fileNamed: 'fuel/testFormBilateralAllianceA7.fuel'.

	logger info: board.
	
	comfirmedCell := board getSudokuCell: 5@6.
	comfirmedCell element: 1.
	comfirmedCell clearPossibleNumbers .
	board map: comfirmedCell .
	logger info: board.
]

{ #category : 'tests' }
SudokuBoard2Test >> testMapSudokuBlock2 [

	| board block task |
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
	block := board getBlock: 7.
	
	block row: 1 column: 1 put: $X.
	block row: 2 column: 2 put: $X.
	block row: 3 column: 3 put: $X.
	
	board mapSudokuBlock2: block.
	
	self assert: (board getBlock: 7) blockA2D equals: block blockA2D.

]
