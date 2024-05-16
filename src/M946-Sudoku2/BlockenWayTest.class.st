Class {
	#name : #BlockenWayTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
BlockenWayTest >> testColumnSuji [ 

	|task board block blockenWay  exBlock|
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
	board loadFromString: task .
	blockenWay := BlockenWay new: board .	
	"Test 1"
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 2.
	blockenWay  columnSuji: block.	
	exBlock := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 2.
	exBlock row: 1 column: 2 put: $X.
	exBlock  row: 3 column: 2 put: $X.
	exBlock  row: 2 column: 3 put: $X.

	self assert: block equals: exBlock .
	
	"Test 2"	
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 3.
	blockenWay  columnSuji: block.
	exBlock  := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 3.
	exBlock  row: 2 column: 1 put: $X.
	exBlock  row: 1 column: 2 put: $X.
	exBlock  row: 3 column: 2 put: $X.

	self assert: block equals: exBlock .

	"Test 3"
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 8 verifyNumber: 6.
	blockenWay  columnSuji: block.
	exBlock  := SudokuBlock2 sudokuBoard: board  blockNumber: 8 verifyNumber: 6.
	self assert: block equals: exBlock .

]

{ #category : #tests }
BlockenWayTest >> testRowSuji [ 

	|task board block blockenWay  exBlock|
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
	board loadFromString: task .
	blockenWay := BlockenWay new: board.
	
	"Test 1"
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 2.
	blockenWay  rowSuji: block.	
	exBlock := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 2.
	exBlock row: 1 column: 2 put: $X.
	exBlock  row: 3 column: 2 put: $X.

	self assert: block equals: exBlock .
	
	"Test 2"	
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 3.
	blockenWay  rowSuji: block.
	exBlock  := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 3.
	
	self assert: block equals: exBlock .

	"Test 3"
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 8 verifyNumber: 6.
	blockenWay  rowSuji: block.
	exBlock  := SudokuBlock2 sudokuBoard: board  blockNumber: 8 verifyNumber: 6.
	exBlock row: 1 column: 3 put: $X.
	exBlock  row: 2 column: 1 put: $X.
	
	self assert: block equals: exBlock .

]

{ #category : #tests }
BlockenWayTest >> testSujiYomi [ 

	|task board block blockenWay cell exBoard|
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
	board loadFromString: task .
	blockenWay := BlockenWay new: board .
	
	"Test 1"
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 2.
	cell := blockenWay sujiYomi: block.
	board map: cell.
		
	exBoard := SudokuBoard2 new.
	exBoard loadFromString: task.
	exBoard boardA2D  at: 5 at: 4 put: block verifyNumber.

	self assert: board  equals: exBoard .
	
	"Test 2"
	
	block := SudokuBlock2 sudokuBoard: board  blockNumber: 5 verifyNumber: 3.
	cell := blockenWay  sujiYomi: block.
	board map: cell.
	
	exBoard boardA2D at: 5 at: 6 put: block verifyNumber.
	
	self assert: board equals: exBoard.
	
]
