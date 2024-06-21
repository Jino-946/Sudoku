Class {
	#name : #AlmostMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
AlmostMethodTest >> performTest [ 

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
AlmostMethodTest >> testFindBlocks [

	| blocks solver board task|
	
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
	solver := AlmostMethod new: board.	
	blocks := solver findBlocks .
	('{1}
	{2}' format:{ thisContext . board }) record.
	
	self assert: 1 equals: blocks size.

	


]

{ #category : #tests }
AlmostMethodTest >> testFindColumns [

	| columns solver board task|
	
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   4 8 7   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AlmostMethod new: board.	
	columns := solver findColumns .
	
	self assert: 2 equals: columns size.
	self assert: (board getSudokuColumn: 4) equals: (columns at: 1)

]

{ #category : #tests }
AlmostMethodTest >> testFindRows [

	| rows solver board task|
	
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
	solver := AlmostMethod new: board.	
	rows := solver findRows .
	
	self assert: 2 equals: rows size.

]

{ #category : #tests }
AlmostMethodTest >> testFinishBlocks [

	| task board solver|

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
	solver := AlmostMethod new: board.
	solver finishBlocks .
	
	self assert: 4 equals: (board boardA2D at: 5 at: 4).
	self assert: 7 equals: (board boardA2D at: 5 at: 6).
	

]

{ #category : #tests }
AlmostMethodTest >> testFinishColumns [

	| solver board task|
	
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   4 8 7   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AlmostMethod new: board.	
	solver finishColumns .
	
	('{1}
	{2}' format:{ thisContext . board }) record.
	
	self assert: (board boardA2D at: 3 at: 4) equals: 0.
	self assert: (board boardA2D at: 7 at: 4) equals: 0.

	self assert: (board boardA2D at: 7 at: 6) equals: 3.
	self assert: (board boardA2D at: 3 at: 6) equals: 9

]

{ #category : #tests }
AlmostMethodTest >> testFinishRows [

	| task board solver|

	task := '
2	0	0		8	5	3		6	4	9	
9	8	4		7	6	2		1	3	5	
5	0	6		1	9	4		7	8	2	


6	2	8		0	0	7		0	1	0	
3	4	9		2	1	8		0	7	6	
7	0	0		0	0	6		0	2	0	


1	9	0		4	8	5		2	6	0	
8	0	2		6	7	1		4	9	0	
4	6	0		3	2	9		8	5	0	
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AlmostMethod new: board.
	solver finishRows .

	self assert: (board boardA2D at: 8 at: 2) equals: 5.
	self assert: (board boardA2D at: 8 at: 9) equals: 3.

]

{ #category : #tests }
AlmostMethodTest >> testSolve [

	| task board array1 array2 |

	task := '
0 0 0    0 5 0    0 0 0
0 0 0    7 0 2    1 3 0
5 0 6    0 0 4    0 0 0

0 0 8    0 0 0    0 1 0
3 4 9    0 0 0    0 7 0
7 0 0    0 0 6    0 2 0

0 0 0    0 8 0    2 0 0
8 0 2    0 0 0    4 0 0
0 0 0    3 0 0    0 5 0
'.

	board := SudokuBoard2 new.
	board loadFromString: task.

	('{1}
Initial state of SudokuBoard
	{2}' format: {thisContext . board}) record.
	
	5 timesRepeat: [ 
		(YokoNicoMethod new: board) solve.
		(TateNicoMethod new: board) solve.
		(LetsmeWay new: board) solve.
		(GyomeWay new: board) solve.
		(MasumiWay new: board) solve.
	 ].
	('{1}
Performed elementary processing
	{2}' format: {thisContext . board}) record.

	(AlmostMethod new: board) finishBlocks.
	array1 := board boardA2D copy.
	('{1}
Aplly AlmostMethod>>finishBlocks
	{2}' format: {thisContext . board}) record.

	"block 2"
	self assert: (board boardA2D at: 3 at: 4)  equals: 1.
	"block 3"
	self assert: (board boardA2D at: 1 at: 7)  equals: 6.
	self assert: (board boardA2D at: 1 at: 9)  equals: 9.
	"block 8"
	self assert: (board boardA2D at: 8 at: 6)  equals: 1.
	
	
	(AlmostMethod new: board) finishColumns .
	array2 := board boardA2D copy.
	('{1}
Aplly AlmostMethod>>finishColumns
	{2}' format: {thisContext . board}) record.	
	self assert: array1  equals: array2.

		
	(AlmostMethod new: board) finishRows  .
	('{1}
Aplly AlmostMethod>>finishRows
	{2}' format: {thisContext . board}) record.		
	"Row 3"
	self assert: (board boardA2D at: 3 at: 2)  equals: 3.
	"Row 5"
	self assert: (board boardA2D at: 5 at: 7)  equals: 5.
		
	
		
		
		
		
		
		
		
	
]
