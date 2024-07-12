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
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/forRemovePossibleNumbers.fuel';
        materializeRoot .

	logger info: board.
	
	self assert: (board getSudokuCell: 4@3) asSimpleString  equals: '$2'.
	self assert: (board getSudokuCell: 6@5) asSimpleString  equals: '$2'.
	
	"セルに入る数字が確定したと仮定する"
	cell := SudokuCell row: 3 column: 6 element: 2.
	board map: cell.
	
	logger info: board.
	
	self assert: (board boardA2D at: 3 at: 4)  equals: 0.
	self assert: (board boardA2D at: 5 at: 6)  equals: 0.

	
]
