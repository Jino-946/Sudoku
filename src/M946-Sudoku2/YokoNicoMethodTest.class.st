Class {
	#name : #YokoNicoMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
YokoNicoMethodTest >> performTest [ 

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
YokoNicoMethodTest >> testNicoCellsNumber [


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
	solver := YokoNicoMethod new: board.
	
	"solver nicoCheck: 1  => #(5 8)"
	"test block1 element8"
	blockNumber := 1.
	elem := 8.
	cells := solver nicoCells: blockNumber  number: elem.
	sudokuCell := SudokuCell row: 1 column: 4 element: elem.
	self assert: (cells at: 1) equals: sudokuCell.	
		
	sudokuCell := SudokuCell row: 3 column: 9 element: elem.
	self assert: (cells at: 2) equals: sudokuCell.	


	"test block1 element5"	
	elem := 5.
	cells := solver nicoCells: blockNumber  number: elem .
	sudokuCell := SudokuCell row: 2 column: 4 element: elem .
	self assert: (cells at: 1) equals: sudokuCell.	

	sudokuCell := SudokuCell row: 1 column: 7 element: elem .
	self assert: (cells at: 2) equals: sudokuCell.	


	
	
	
]

{ #category : #tests }
YokoNicoMethodTest >> testNicoCheck [

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
		('{1}
	 hi, there!!'	format: { thisContext }) record.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := YokoNicoMethod new: board.
	
	self assert: (solver nicoCheck: 1) sorted equals: #(5 8)  .
	self assert: (solver nicoCheck: 2) 		 equals: #().
	self assert: (solver nicoCheck: 3)	 	 equals: #(6) .
	
	self assert: (solver nicoCheck: 4) sorted equals: #(1 2 8) 	.		
	self assert: (solver nicoCheck: 5) sorted equals: #(7 8) .	
	self assert: (solver nicoCheck: 6) sorted equals: #(6 8 9) .	

	self assert: (solver nicoCheck: 7) sorted equals: #(2 5 8).		
	self assert: (solver nicoCheck: 8)  		 equals: #(9).	
	self assert: (solver nicoCheck: 9)		 equals: #().	
			
		
	

]

{ #category : #tests }
YokoNicoMethodTest >> testTargetBlock [

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
	solver := YokoNicoMethod new: board.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 4.
	self assert: (board boardA2D at: 2 at: 1) equals:  8.
	
	
	blockNumber := 2.
	solver := YokoNicoMethod new: board.	
	self assert:  (board getBlock: blockNumber) blankCellsAsArray size  equals: 4.
	solver targetBlock: blockNumber.
	self assert:  (board getBlock: blockNumber ) blankCellsAsArray size equals: 4.	

	blockNumber := 3.
	solver := YokoNicoMethod new: board.	
	self assert:  (board getBlock: blockNumber ) blankCellsAsArray size equals:  7.
	solver targetBlock: blockNumber .
	self assert:  (board getBlock: blockNumber ) blankCellsAsArray size equals:  7.

	blockNumber := 4.
	solver := YokoNicoMethod new: board.	
	self assert: (board getBlock: blockNumber ) blankCellsAsArray size equals:  5.
	solver targetBlock: 4.
	self assert: (board getBlock: blockNumber ) blankCellsAsArray size equals:  5.

	blockNumber := 5.
	solver := YokoNicoMethod new: board.		
	self assert: (board getBlock: blockNumber ) blankCellsAsArray  size equals: 2.
	solver targetBlock: blockNumber.
	self assert:  (board getBlock: blockNumber) blankCellsAsArray  size  equals: 0.	

	blockNumber := 6.
	solver := YokoNicoMethod new: board.			
	self assert: (board getBlock: blockNumber) blankCellsAsArray  size equals: 5.
	solver targetBlock: blockNumber.
	self assert:  (board getBlock: blockNumber) blankCellsAsArray  size  equals: 5.	

	blockNumber := 7.
	solver := YokoNicoMethod new: board.		
	self assert: (board getBlock: blockNumber) blankCellsAsArray  size equals: 7.
	solver targetBlock: blockNumber.
	self assert:  (board getBlock: blockNumber) blankCellsAsArray  size  equals: 5.
	self assert: (board boardA2D at: 7 at: 2) equals: 8.
	self assert: (board boardA2D at: 7 at: 3) equals: 2.
	
	blockNumber := 8.
	solver := YokoNicoMethod new: board.		
	self assert: (board getBlock: blockNumber) blankCellsAsArray  size equals: 4.
	solver targetBlock: blockNumber.
	self assert:  (board getBlock: blockNumber) blankCellsAsArray  size  equals: 3.
	self assert: (board boardA2D at: 8 at: 5) equals: 9.

	blockNumber := 9.
	solver := YokoNicoMethod new: board.		
	self assert: (board getBlock: blockNumber) blankCellsAsArray  size equals: 5.
	solver targetBlock: blockNumber.
	self assert:  (board getBlock: blockNumber) blankCellsAsArray  size  equals: 5.

	solver := YokoNicoMethod new: board.		
	1 to: 9 do: [ :num | solver targetBlock: num ].
	('{1}
	{2}' format: {thisContext . board}) record.
]
