Class {
	#name : #YokoNicoCheckMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #running }
YokoNicoCheckMethodTest >> setUp [
	super setUp.

    TinyLogger default ensureFileLoggerNamed: 'sudoku.log'; clearLog.
    TinyLogger default 
        timestampFormatBlock: [ :aStream :timestamp |
            timestamp asDate yyyymmdd printOn: aStream.
            aStream << ' '.
            timestamp asTime print24: true on: aStream ].
]

{ #category : #tests }
YokoNicoCheckMethodTest >> testNicoCellsNumber [


	| board solver task cells sudokuCell blockNumber elem|
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
	solver := YokoNicoCheckMethod new: board.
	
	"test block1 element8"
	blockNumber := 1.
	elem := 8.
	cells := solver nicoCells: blockNumber  number: elem.
	self assert: 2 equals: cells size.
	
	sudokuCell := SudokuCell row: 1 column: 4 element: elem.
	self assert: sudokuCell equals: (cells at: 1).	
		
	sudokuCell := SudokuCell row: 3 column: 9 element: elem.
	self assert: sudokuCell equals: (cells at: 2).
	
	"test block1 element5"	
	elem := 5.
	cells := solver nicoCells: blockNumber  number: elem .
	self assert: 2 equals: cells size.
	
	sudokuCell := SudokuCell row: 2 column: 4 element: elem .
	self assert: sudokuCell equals: (cells at: 1).	
		
	sudokuCell := SudokuCell row: 1 column: 7 element: elem .
	self assert: sudokuCell equals: (cells at: 2).

	
	
	
]

{ #category : #tests }
YokoNicoCheckMethodTest >> testNicoCheck [

	| board solver task |
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
	solver := YokoNicoCheckMethod new: board.
	
	self assert: #(5 8) sorted 	equals:  (solver nicoCheck: 1) sorted.
	self assert: #() 				equals:  (solver nicoCheck: 2).
	self assert: #(6)				equals:  (solver nicoCheck: 3).
	
	self assert: #(1 8 2) 	sorted equals:  (solver nicoCheck: 4) sorted.		
	self assert: #(7 8) 	sorted	equals:  (solver nicoCheck: 5) sorted.	
	self assert: #(6 8 9) 	sorted	equals:  (solver nicoCheck: 6) sorted.	
		
	self assert: #(8 5 2) 	sorted equals:  (solver nicoCheck: 7) sorted.		
	self assert: #(9)				equals:  (solver nicoCheck: 8).	
	self assert: #() 				equals:  (solver nicoCheck: 9).	
]

{ #category : #tests }
YokoNicoCheckMethodTest >> testTargetBlock [

	| board solver task blockNumber |
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

	blockNumber := 1.		
	solver := YokoNicoCheckMethod new: board.
	solver targetBlock: blockNumber.
	self assert: (board atBlock: blockNumber) blankCellsAsArray size  equals: 4.
	self assert: (board boardA2D at: 2 at: 1) equals:  8.
	
	
	blockNumber := 2.
	solver := YokoNicoCheckMethod new: board.	
	self assert:  (board atBlock: blockNumber) blankCellsAsArray size  equals: 4.
	solver targetBlock: blockNumber.
	self assert:  (board atBlock: blockNumber ) blankCellsAsArray size equals: 4.	

	blockNumber := 3.
	solver := YokoNicoCheckMethod new: board.	
	self assert:  (board atBlock: blockNumber ) blankCellsAsArray size equals:  7.
	solver targetBlock: blockNumber .
	self assert:  (board atBlock: blockNumber ) blankCellsAsArray size equals:  7.

	blockNumber := 4.
	solver := YokoNicoCheckMethod new: board.	
	self assert: (board atBlock: blockNumber ) blankCellsAsArray size equals:  5.
	solver targetBlock: 4.
	self assert: (board atBlock: blockNumber ) blankCellsAsArray size equals:  5.

	blockNumber := 5.
	solver := YokoNicoCheckMethod new: board.		
	self assert: (board atBlock: blockNumber ) blankCellsAsArray  size equals: 2.
	solver targetBlock: blockNumber.
	self assert:  (board atBlock: blockNumber) blankCellsAsArray  size  equals: 0.	

	blockNumber := 6.
	solver := YokoNicoCheckMethod new: board.			
	self assert: (board atBlock: blockNumber) blankCellsAsArray  size equals: 5.
	solver targetBlock: blockNumber.
	self assert:  (board atBlock: blockNumber) blankCellsAsArray  size  equals: 5.	

	blockNumber := 7.
	solver := YokoNicoCheckMethod new: board.		
	self assert: (board atBlock: blockNumber) blankCellsAsArray  size equals: 7.
	solver targetBlock: blockNumber.
	self assert:  (board atBlock: blockNumber) blankCellsAsArray  size  equals: 5.
	self assert: (board boardA2D at: 7 at: 2) equals: 8.
	self assert: (board boardA2D at: 7 at: 3) equals: 2.
	
	blockNumber := 8.
	solver := YokoNicoCheckMethod new: board.		
	self assert: (board atBlock: blockNumber) blankCellsAsArray  size equals: 4.
	solver targetBlock: blockNumber.
	self assert:  (board atBlock: blockNumber) blankCellsAsArray  size  equals: 3.
	self assert: (board boardA2D at: 8 at: 5) equals: 9.

	blockNumber := 9.
	solver := YokoNicoCheckMethod new: board.		
	self assert: (board atBlock: blockNumber) blankCellsAsArray  size equals: 5.
	solver targetBlock: blockNumber.
	self assert:  (board atBlock: blockNumber) blankCellsAsArray  size  equals: 5.

	solver := YokoNicoCheckMethod new: board.		
	1 to: 9 do: [ :num | solver targetBlock: num ].
	('{1}' format: {board}) record.
]
