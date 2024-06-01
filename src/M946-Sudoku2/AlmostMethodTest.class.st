Class {
	#name : #AlmostMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #running }
AlmostMethodTest >> setUp [
	super setUp.
    TinyLogger default ensureFileLoggerNamed: 'sudoku.log'; clearLog.
    TinyLogger default 
        timestampFormatBlock: [ :aStream :timestamp |
            timestamp asDate yyyymmdd printOn: aStream.
            aStream << ' '.
            timestamp asTime print24: true on: aStream ].
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
	self assert: (board atSudokuColumn: 4) equals: (columns at: 1)

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
AlmostMethodTest >> testFinishBlocks2 [

	| task board solver|

	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 0 2   0 1 7
0 0 0   4 8 7   0 0 0
6 7 0   9 0 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AlmostMethod new: board.
	solver finishBlocks .
	
	self assert: 3 equals: (board boardA2D at: 4 at: 5).
	self assert: 1 equals: (board boardA2D at: 6 at: 5).
	

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
	
	self assert: 0 equals: (board boardA2D at: 3 at: 4).
	self assert: 0 equals: (board boardA2D at: 7 at: 4).

	self assert: 3 equals: (board boardA2D at: 7 at: 6).
	self assert: 9 equals: (board boardA2D at: 3 at: 6)

]

{ #category : #tests }
AlmostMethodTest >> testFinishRows [

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
	solver finishRows .
	
	self assert: 5 equals: (board boardA2D at: 4 at: 1).
	self assert: 4 equals: (board boardA2D at: 4 at: 7).
	

]
