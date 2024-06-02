Class {
	#name : #SudokuColumnTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
SudokuColumnTest >> performTest [ 

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
SudokuColumnTest >> testAllGreen [

	|task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
7	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	0	7		4	9	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	
	self assert: (block colsOnBoard at: 2) column equals: #(7 1 4   9 6 8   0 2 5).
	
	cell := SudokuCell row: 7 column: 2  element: 3.
	self assert: (block colsOnBoard at: 2) allGreen  equals: cell.
]

{ #category : #tests }
SudokuColumnTest >> testCellOf [ 

	| task board column cell |
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
	column := board atSudokuColumn: 4.
	
	cell := SudokuCell row: 9 column: 4  element: 7.
	self assert: cell equals: (column cellOf: 7)
]

{ #category : #tests }
SudokuColumnTest >> testTenpai [

	|task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
7	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	0	7		4	9	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	
	self assert: (block colsOnBoard at: 2) column equals: #(7 1 4   9 6 8   0 2 5).
	
	cell := SudokuCell row: 7 column: 2  element: 0.
	self assert: (block colsOnBoard at: 2) tenpai  equals: cell.
	
]

{ #category : #tests }
SudokuColumnTest >> testTsumo [ 

	|task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
7	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	0	7		4	9	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	
	self assert: (block colsOnBoard at: 2) column equals: #(7 1 4   9 6 8   0 2 5).
	
	cell := SudokuCell row: 7 column: 2  element: 3.
	self assert: (block colsOnBoard at: 2) tsumo  equals: cell.
]
