Class {
	#name : #SudokuBlock2Test,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
SudokuBlock2Test >> performTest [ 

    | logger |
    logger := TinyLogger new addTranscriptLogger ; yourself .
    logger  timestampFormatBlock: [ :aStream :timestamp |
            timestamp asDate yyyymmdd printOn: aStream.
            aStream << ' '.
            timestamp asTime print24: true on: aStream ].
    logger clearLog.
    
    TinyCurrentLogger value: logger during: [ super performTest ]
]

{ #category : #running }
SudokuBlock2Test >> setUp [
	super setUp.

	TinyLogger default ensureFileLoggerNamed: 'sudoku.log'; clearLog.
    TinyLogger default 
        timestampFormatBlock: [ :aStream :timestamp |
            timestamp asDate yyyymmdd printOn: aStream.
            aStream << ' '.
            timestamp asTime print24: true on: aStream ].
]

{ #category : #tests }
SudokuBlock2Test >> testAllGreen [

	| task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
0	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	3	7		4	0	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	"ブロック4のツモを確認する"
	block := board atBlock: 4.
	cell := block allGreen.
	self assert: cell equals: (SudokuCell row: 5 column: 1 element: 7).
	
	"ブロック8のツモを確認する"
	block := board atBlock: 8.
	cell := block allGreen.
	self assert: cell equals: (SudokuCell row: 7 column: 5 element: 9)
	
]

{ #category : #tests }
SudokuBlock2Test >> testBlankCellsAsArray [
	|task board block cells|
	task := '
1 9 7  0 0 4  2 0 5
6 8 0  5 3 0  9 0 0 
5 0 3  0 7 2  1 6 8
	
0 6 0  4 0 9  7 0 2
0 7 5  0 1 0  6 8 0 
2 0 9  8 0 7  0 4 0
	
7 5 6  3 2 0  4 0 1
0 0 1  0 4 5  0 2 6
8 0 4  1 0 0  3 5 7	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 9.
	
	cells := Array new: 2.
	cells at: 1 put: (SudokuCell row: 7 column: 8 element: 0).
	cells at: 2 put: (SudokuCell row: 8 column: 7 element: 0).
	
	self assert: block blankCellsAsArray  equals: cells.
	
]

{ #category : #tests }
SudokuBlock2Test >> testCellOf [

	|task board block cell|
	task := '
1 9 7  0 0 4  2 0 5
6 8 0  5 3 0  9 0 0 
5 0 3  0 7 2  1 6 8
	
0 6 0  4 0 9  7 0 2
0 7 5  0 1 0  6 8 0 
2 0 9  8 0 7  0 4 0
	
7 5 6  3 2 0  4 0 1
0 0 1  0 4 5  0 2 6
8 0 4  1 0 0  3 5 7	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 5.
	
	cell := SudokuCell row: 4 column: 6 element: 9.
	
	self assert: (block cellOf: 9) equals:  cell.
]

{ #category : #tests }
SudokuBlock2Test >> testColIndexOnBoard [

	| board block task  |
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	
	block := board atBlock: 1.
	self assert: (block colIndexOnBoard: 2) equals: 2.
	
	block := board atBlock: 5.
	self assert: (block colIndexOnBoard: 2) equals: 5.
	
	block := board atBlock: 9.
	self assert: (block rowIndexOnBoard: 3) equals: 9.
]

{ #category : #tests }
SudokuBlock2Test >> testColsOnBoard [

	| board block cols task column |
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 3.
	cols := block colsOnBoard .
	
	column := SudokuColumn new.
	column colIndex: 7;
			column: #(3 0 2 7 8 0 0 0 0).			
	self assert: (cols at: 1) equals: column.
 
	column colIndex: 9;
			column: #(0 6 7 0 3 0 0 5 9).			
	self assert: (cols at: 3) equals: column.
	
	

]

{ #category : #tests }
SudokuBlock2Test >> testLocalX [

	| board block |

	board := SudokuBoard2 new.
	
	block := board atBlock: 2.
	self assert: 1 equals: (block localX: 4).
	self assert: 2 equals: (block localX: 5).
	self assert: 3 equals: (block localX: 6).
	
	block := board atBlock: 4.
	self assert: 1 equals: (block localX: 1).
	self assert: 2 equals: (block localX: 2).
	self assert: 3 equals: (block localX: 3).
	
	block := board atBlock: 9.
	self assert: 1 equals: (block localX: 7).
	self assert: 2 equals: (block localX: 8).
	self assert: 3 equals: (block localX: 9).
]

{ #category : #tests }
SudokuBlock2Test >> testLocalY [

	| board block |

	board := SudokuBoard2 new.
	
	block := board atBlock: 2.
	self assert: 1 equals: (block localY: 1).
	self assert: 2 equals: (block localY: 2).
	self assert: 3 equals: (block localY: 3).
	
	block := board atBlock: 4.
	self assert: 1 equals: (block localY: 4).
	self assert: 2 equals: (block localY: 5).
	self assert: 3 equals: (block localY: 6).
	
	block := board atBlock: 9.
	self assert: 1 equals: (block localY: 7).
	self assert: 2 equals: (block localY: 8).
	self assert: 3 equals: (block localY: 9).
]

{ #category : #tests }
SudokuBlock2Test >> testMarkByHorizontalCell [
	| board solver task cells blockNumber sudokuNumber block |
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := YokoNicoMethod new: board.
	
	"test 1"
	blockNumber := 1.
	sudokuNumber  := 8.
	cells := solver nicoCells: blockNumber  number: sudokuNumber .
	block := board atBlock: blockNumber.
	
	self assert: 5 equals: (block blankCellsAsArray size).
	
	block markByHorizontalCell: (cells at: 1).
	block markByHorizontalCell: (cells at: 2).

	('{1}' format: {thisContext}) record.
	('test 1 {1}' format: {block}) record.
	
	self assert: 2 equals: (block blankCellsAsArray size).
	self assert: $X equals: (block row: 3 column: 1).
	self assert: $X equals: (block row: 3 column: 2).	
	self assert: $X equals: (block row: 3 column: 3).	


	"test 2"
	sudokuNumber := 5.
	cells := solver nicoCells: blockNumber  number: sudokuNumber .
	block := board atBlock: blockNumber.
	
	block markByHorizontalCell: (cells at: 1).
	block markByHorizontalCell: (cells at: 2).

	('{1}' format: {thisContext}) record.
	('test 2 {1}' format: {block}) record.

	self assert: 3 equals: (block blankCellsAsArray size).
	self assert: $X equals: (block row: 2 column: 1).
	self assert: $X equals: (block row: 2 column: 3).	


]

{ #category : #tests }
SudokuBlock2Test >> testMarkByNumberNumberToMark2 [

	| task board block |
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 1.
	
	self assert: 5 equals: (block blankCellsAsArray size).
	block markByNumberToMark: 8.
	
	('{1}' format: {thisContext}) record.
	('{1}' format: {block}) record.	
	
	self assert: 1 equals: (block blankCellsAsArray size).
	self assert: 0 equals: (block row: 2 column: 1).
	

]

{ #category : #tests }
SudokuBlock2Test >> testRowIndexOnBoard [

	| board block task  |
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	
	block := board atBlock: 1.
	self assert: (block rowIndexOnBoard: 2) equals: 2.
	
	block := board atBlock: 5.
	self assert: (block rowIndexOnBoard: 2) equals: 5.
	
	block := board atBlock: 9.
	self assert: (block rowIndexOnBoard: 2) equals: 8.
]

{ #category : #tests }
SudokuBlock2Test >> testRowsOnBoard [

	| board block rows row task|
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	rows := block rowsOnBoard .
	
	row := SudokuRow new.
	row rowIndex: 8;
			row: #(6 2 0 1 0 0 0 0 5).	
						
	self assert: (rows at: 2) equals: row.
 
]

{ #category : #tests }
SudokuBlock2Test >> testTenpai [ 

	| board block expected data|
	data := '

1	2	3		4	5	6		7	8	9	
2	3	4		5	6	7		8	9	1	
3	4	5		6	7	8		9	1	2	


4	5	6		7	8	9		1	2	3	
5	6	7		8	9	1		2	3	4	
6	7	8		9	0	2		3	4	5	


7	8	9		1	2	3		4	5	6	
8	9	1		2	3	4		5	6	0	
9	1	2		3	4	5		6	7	8		
	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: data.

	"ブロック5のテンパイを確認する"
	block := board atBlock: 5.
	expected := SudokuCell row: 6 column: 5 element: 0.
	self assert: block tenpai equals: expected.

    "ブロック9のテンパイを確認する"
	block := board atBlock: 9.
	expected := SudokuCell row: 8 column: 9  element: 0.
	self assert: block tenpai equals: expected .

]

{ #category : #tests }
SudokuBlock2Test >> testTsumo [ 

	| task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
0	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	3	7		4	0	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	"ブロック4のツモを確認する"
	block := board atBlock: 4.
	cell := block tsumo.
	self assert: cell equals: (SudokuCell row: 5 column: 1 element: 7).
	
	"ブロック8のツモを確認する"
	block := board atBlock: 8.
	cell := block tsumo.
	self assert: cell equals: (SudokuCell row: 7 column: 5 element: 9)
	
]
