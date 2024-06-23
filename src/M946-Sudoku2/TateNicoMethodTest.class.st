Class {
	#name : #TateNicoMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
TateNicoMethodTest >> performTest [ 

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
TateNicoMethodTest >> testNicoCellsNumber [


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
	solver := TateNicoMethod new: board.
	
	"solver nicoCheck: 5  => #(5 7 8)"
	"test block 5 element 5"
	blockNumber := 5.
	elem := 5.
	cells := solver nicoCells: blockNumber  number: elem.
	sudokuCell := SudokuCell row: 2 column: 4 element: elem.
	self assert: (cells at: 1) equals: sudokuCell.	
		
	sudokuCell := SudokuCell row: 7 column: 5 element: elem.
	self assert: (cells at: 2) equals: sudokuCell.	


	"test block 5 element 7"	
	elem := 7.
	cells := solver nicoCells: blockNumber  number: elem .
	sudokuCell := SudokuCell row: 3 column: 5 element: elem .
	self assert: (cells at: 1) equals: sudokuCell.	

	sudokuCell := SudokuCell row: 9 column: 4 element: elem .
	self assert: (cells at: 2) equals: sudokuCell.	

	"test block 5 element 8"	
	elem := 8.
	cells := solver nicoCells: blockNumber  number: elem .
	sudokuCell := SudokuCell row: 1 column: 4 element: elem .
	self assert: (cells at: 1) equals: sudokuCell.	

	sudokuCell := SudokuCell row: 9 column: 6 element: elem .
	self assert: (cells at: 2) equals: sudokuCell.	


	
	
	
]

{ #category : #tests }
TateNicoMethodTest >> testNicoCheck [

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
	solver := TateNicoMethod new: board.
	
	self assert: (solver nicoCheck: 1) sorted equals: #(9)  .
	self assert: (solver nicoCheck: 2) sorted equals: #(2 5 8).
	self assert: (solver nicoCheck: 3) sorted equals: #(2 8) .
	
	self assert: (solver nicoCheck: 4) 		 equals: #(9).		
	self assert: (solver nicoCheck: 5) sorted equals: #(5 7 8) .	
	self assert: (solver nicoCheck: 6) sorted equals: #(5 8) .	
		
	self assert: (solver nicoCheck: 7) sorted equals: #(6 9).		
	self assert: (solver nicoCheck: 8) sorted equals: #(1 5 6 8).	
	self assert: (solver nicoCheck: 9)		 equals: #(8).	
			
		


]

{ #category : #tests }
TateNicoMethodTest >> testTargetBlock [

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
	('{1}
	 hi, there!!'	format: { thisContext }) record.
	board := SudokuBoard2 new.
	board loadFromString: task.

	blockNumber := 1.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.

	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.

	blockNumber := 2.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 4.
	('{1}' format: {(board getBlock: blockNumber) asString}) record.
	solver targetBlock: blockNumber.
	('{1}' format: {(board getBlock: blockNumber) asString}) record.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 3.	
	self assert: (board boardA2D at: 1 at: 5)  equals: 2.
	

	blockNumber := 3.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 7.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 6.	
	self assert: (board boardA2D at: 3 at: 7)  equals: 2.
	
	blockNumber := 4.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.	

	blockNumber := 5.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 2.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 0.	
	self assert: (board boardA2D at: 5 at: 6)  equals: 7.
	self assert: (board boardA2D at: 5 at: 4)  equals: 4.

	blockNumber := 6.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 4.	
	self assert: (board boardA2D at: 5 at: 9)  equals: 5.

	blockNumber := 7.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 7.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 7.	

	blockNumber := 8.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 4.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 3.	
	self assert: (board boardA2D at: 7 at: 4)  equals: 1.

	blockNumber := 9.		
	solver := TateNicoMethod new: board.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.
	solver targetBlock: blockNumber.
	self assert: (board getBlock: blockNumber) blankCellsAsArray size  equals: 5.	



	




	
]
