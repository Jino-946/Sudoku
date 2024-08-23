Class {
	#name : #SudokuBoard2Test,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
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

{ #category : #tests }
SudokuBoard2Test >> testAllianceProcessingBuddyCellInTheBlock [
	"
	セルに入る数字が確定したあと,関連するブロックの確定数字を予約数字に持つペアセル
	の動作をテストする。
	ワンペアとツーペアのテスト
	"
	| logger  board  pairCell thisCell |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	
	"
	5block<5@6>の1が確定することで6block<7@6>の8が確定したあとのツーペアの状態
	"
	thisCell := board getSudokuCell: 7@6.
	thisCell element: 8.
	pairCell := board allianceProcessingBuddyCellInTheBlock: thisCell.
	self assert: pairCell class equals: SudokuCell.
	self assert: pairCell equals: (SudokuCell row: 4 column: 7 element: 1).
	
	"
	6block<7@6>の1が確定したと想定したツーペアの状態
	"
	thisCell := board getSudokuCell: 7@6.
	thisCell element: 1.
	pairCell := board allianceProcessingBuddyCellInTheBlock: thisCell.
	self assert: pairCell class equals: SudokuCell.
	self assert: pairCell equals: (SudokuCell row: 4 column: 7 element: 8).

	" ボードのリロード"
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	
	"
	ワンペアの予約数が確定したと想定したワンペアの状態
	"
	thisCell := board getSudokuCell: 9@7.
	thisCell element: 4.
	logger info: thisCell.
	pairCell := board allianceProcessingBuddyCellInTheBlock: thisCell.
	self assert: pairCell class equals: SudokuCell.
	self assert: pairCell equals: (SudokuCell row: 7 column: 7 element: 0).
	
	
	"
	ワンペアの予約数以外の数が確定したと想定したワンペアの状態
	"
	thisCell := board getSudokuCell: 9@7.
	thisCell element: 7.
	logger info: thisCell.
	pairCell := board allianceProcessingBuddyCellInTheBlock: thisCell.
	self assert: pairCell class equals: SudokuCell.
	self assert: pairCell equals: (SudokuCell row: 7 column: 7 element: 4).
	
	"
	ワンペアの解除を想定したワンペアの状態
	"
	thisCell := board getSudokuCell: 9@7.
	thisCell element: 0.
	logger info: thisCell.
	pairCell := board allianceProcessingBuddyCellInTheBlock: thisCell.
	self assert: pairCell class equals: SudokuCell.
	self assert: pairCell equals: (SudokuCell row: 7 column: 7 element: 4).


]

{ #category : #tests }
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
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	
	"
	7block<3@7>8が確定した
	"
	"
	thisCell := board getSudokuCell: 3@7.
	thisCell element: 8.
	pairCells := board allianceProcessingBuddyCellInTheBlock: thisCell.
	self assert: pairCells class equals: Array.
	bag := Bag new.
	bag add: (SudokuCell row: 8 column: 3  element: 0).
	bag add: (SudokuCell row: 9 column: 3 element: 3).
	self assert: pairCells asBag equals: bag.
	"
	
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	"
	7block<3@9>3が確定した
	"
	"
	thisCell := board getSudokuCell: 3@9.
	thisCell element: 3.
	pairCells := board allianceProcessingBuddyCellInTheBlock: thisCell.
	logger info: ('actual => 
{1}' format: {pairCells}).	
	self assert: pairCells class equals: Array.
	bag := Bag new.
	bag add: ((SudokuCell row: 7 column: 3  element: 0) addPossibleNumber: 8 ).
	bag add: ((SudokuCell row: 8 column: 3 element: 0) addPossibleNumber: 8).
	logger info: ('expected => 
{1}' format: {bag}).
	self assert: pairCells asBag equals: bag.
	"


	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	"
	5block<5@6>1が確定した
	"
	thisCell := board getSudokuCell: 5@6.
	thisCell element: 1.
	pairCells := board allianceProcessingBuddyCellInTheBlock: thisCell.
	logger info: ('actual => 
{1}' format: {pairCells}).	
	self assert: pairCells class equals: Array.
	bag := Bag new.
	bag add: ((SudokuCell row: 4 column: 5  element: 0) addPossibleNumber: 3 ).
	bag add: ((SudokuCell row: 5 column: 5 element: 0) addPossibleNumber: 3).
	logger info: ('expected => 
{1}' format: {bag}).
	logger info: bag.
	self assert: pairCells asBag equals: bag.
	





]

{ #category : #tests }
SudokuBoard2Test >> testAllianceProcessingOfCol [
	"
	block3の<7@3>4が確定したと仮定した時、block9の4のワンペアが解決することをテストする。 
	"
	| logger  board  cells confirmedCell |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	confirmedCell  := (board getSudokuCell: 7@3) deepCopy.
	confirmedCell  element: 4.
	confirmedCell  clearPossibleNumbers .
	

	cells := board allianceProcessingOfCol: confirmedCell .
	board boardA2D  at: confirmedCell y at: confirmedCell x put: confirmedCell element.
	cells class = SudokuCell ifTrue: [ 
		board boardA2D  at: cells y at: cells x put: cells element].
	self assert: (board boardA2D  at: 3 at: 7) equals: 4.
	self assert: (board boardA2D  at: 7 at: 7) equals: 0.
	self assert: (board boardA2D  at: 7 at: 9) equals: 4.
	
	logger info: board.

]

{ #category : #tests }
SudokuBoard2Test >> testAllianceProcessingOfRow [
	"
	block5の<5@6>1が確定したと仮定した時、block6の18ツーペアが解決することをテストする。 
	"
	| logger  board  cells confirmedCell |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	confirmedCell  := board getSudokuCell: 5@6.
	confirmedCell  element: 1.
	confirmedCell  clearPossibleNumbers .
	
	cells := board allianceProcessingOfRow: confirmedCell  .
	board boardA2D  at: confirmedCell y at: confirmedCell x put: confirmedCell element.
	cells class = SudokuCell ifTrue: [ 
		board boardA2D  at: cells y at: cells x put: cells element].	
	self assert: (board boardA2D  at: 6 at: 5) equals: 1.
	self assert: (board boardA2D  at: 6 at: 7) equals: 8.
	self assert: (board boardA2D  at: 4 at: 7) equals: 1.
	
	logger info: board.
]

{ #category : #tests }
SudokuBoard2Test >> testAllianceProcessingOfRow2 [
	"
	block6の<7@6>1が確定したと仮定した時、block5の非対称ペアが解決することをテストする。 
	"
	| logger  board  cells confirmedCell |
	M946FileLogger logLevel: LogLevel debug.

	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.
	board := FLMaterializer new 
        filePath: 'fuel/testFormBilateralAllianceA7.fuel';
        materializeRoot .
	logger info: board.
	confirmedCell  := board getSudokuCell: 7@6.
	confirmedCell  element: 1.
	confirmedCell clearPossibleNumbers .
	
	cells := board allianceProcessingOfRow: confirmedCell  .
	logger info: cells.	
	logger info: board.
]

{ #category : #tests }
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

{ #category : #tests }
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

{ #category : #tests }
SudokuBoard2Test >> testRemovePossibleNumbersOfRowAndCol [
	"
	セルに入る数字が確定したとき,セルに交差する行と列の予約セルの内容を更新する
	"
	| logger  board  cell |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath:  'fuel/testFormBilateralAlliance2.fuel';
        materializeRoot .

	logger info: board.
	logger info: (board getSudokuCell: 7@4) .
	self assert: (board getSudokuCell: 7@4) asSimpleString  equals: '?1'.
	self assert: (board getSudokuCell: 7@6) asSimpleString  equals: '?1'.
	
	"セルに入る数字が確定したと仮定する"
	cell := SudokuCell row: 4 column: 7 element: 1.
	board map: cell.
	
	logger info: board.
	self assert: (board boardA2D at: 5 at: 5)  equals: 0.	
	self assert: (board boardA2D at: 6 at: 5)  equals: 1.	
	self assert: (board boardA2D at: 6 at: 7)  equals: 0.
	
]
