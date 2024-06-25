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
SudokuBoard2Test >> testMapSudokuCell [

	| task board block logger cell solver |
	logger := M946Logger new: LogLevel debug.
	logger clearLog.
	logger debug: thisContext.
	
	task := '
8	9	0	   0	6	0	   0	2	3	
4	0	0	   1	0	3	   0	0	8	
0	0	0	   0	0	0	   0	0	0	

0	2	0	   0	0	0	   0	4	0	
1	0	0	   0	0	0	   0	0	5	
0	7	0	   0	0	0	   0	6	0	

0	0	0	   0	0	0	   0	0	0	
5	0	0	   3	0	4	   0	0	1	
9	4	0	   0	2	0	   0	8	6		
'.
	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := TwoNationAlliance new: board.	
	block := board getBlock: 6 verifyNumber: 1.
	logger debug: board.
	solver setAlliance: block.
	cell := SudokuCell row: 4 column: 7 element: 2.
	board mapSudokuCell: cell.
	logger debug: board.
	self assert: (board boardA2D at: 6 at: 7) equals: 1.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := TwoNationAlliance new: board.	
	block := board getBlock: 6 verifyNumber: 1.
	logger debug: board.
	solver setAlliance: block.
	cell := SudokuCell row: 6 column: 7 element: 2.
	board mapSudokuCell: cell.
	logger debug: board.
	self assert: (board boardA2D at: 4 at: 7) equals: 1.
	
]
