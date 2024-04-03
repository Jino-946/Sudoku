Class {
	#name : #SudokuBoardTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku-Tests'
}

{ #category : #'private utilities' }
SudokuBoardTest >> privateSkeweredCellsAt: colIndex from: anArray [
	"
	配列のセルを串刺しを要素とした配列を返す
	"
	| result |
	result := Array new: 9 withAll: 0.
	
	1 to: 9 do: [ :rowIndex | result at: rowIndex put: ((anArray at: rowIndex) at: colIndex)].
	
	^result
]

{ #category : #tests }
SudokuBoardTest >> testBlockAt [

	| board result expected |
	expected := SudokuBlock new.
	"Test ブロック5"
	expected
		row: 1 column: 1 put: 0;
		row: 1 column: 2 put: 3;
		row: 1 column: 3 put: 0;
		row: 2 column: 1 put: 4;
		row: 2 column: 2 put: 0;
		row: 2 column: 3 put: 6;
		row: 3 column: 1 put: 0;
		row: 3 column: 2 put: 1;
		row: 3 column: 3 put: 0.

	expected boardRows
		at: 1 put: 4;
		at: 2 put: 5;
		at: 3 put: 6.

	expected boardCols
		at: 1 put: 4;
		at: 2 put: 5;
		at: 3 put: 6.
	expected blockNumber: 5.

	board := SudokuBoard new.
	board setExample1.
	result := board blockAt: 5.
	self assert: result equals: expected.

	"Test ブロック9"
	expected
		row: 1 column: 1 put: 0;
		row: 1 column: 2 put: 5;
		row: 1 column: 3 put: 0;
		row: 2 column: 1 put: 4;
		row: 2 column: 2 put: 0;
		row: 2 column: 3 put: 0;
		row: 3 column: 1 put: 0;
		row: 3 column: 2 put: 0;
		row: 3 column: 3 put: 1.


	expected boardRows
		at: 1 put: 7;
		at: 2 put: 8;
		at: 3 put: 9.

	expected boardCols
		at: 1 put: 7;
		at: 2 put: 8;
		at: 3 put: 9.
	expected blockNumber: 9.

	result := board blockAt: 9.
	self assert: result equals: expected
]

{ #category : #tests }
SudokuBoardTest >> testColsAt [

	| example sb expected index|
	example := #(#(1 9 7   0 0 4   2 0 5) 
				  #(6 8 0   5 3 0   9 0 0) 
				  #(5 0 3   0 7 2   1 6 8)
	
				  #(0 6 0   4 0 9   7 0 2) 
				  #(0 7 5   0 1 0   6 8 0) 
				  #(2 0 9   8 0 7   0 4 0) 
	
				  #(7 5 6   3 2 0   4 0 1) 
				  #(0 0 1   0 4 5   0 2 6) 
				  #(8 0 4   1 0 0   3 5 7)).

	
	sb := SudokuBoard new.
	sb loadExample: example .
	index := 2.
	expected := self privateSkeweredCellsAt: index from: example .
	self assert: (sb colsAt: index) equals: expected.
	
	index := 8.
	expected := self privateSkeweredCellsAt: index from: example .
	self assert: (sb colsAt: index) equals: expected.
	
]

{ #category : #tests }
SudokuBoardTest >> testPrivateBlockAtAt [ 
	"
	SudokuBoard >> privateBlockAt:at: のテスト
	"
	"
	ダミーボード
	1 2 3  4 5 6  7 8 9
	2 3 4  5 6 7  8 9 1 
	3 4 5  6 7 8  9 1 2
	
	4 5 6  7 8 9  1 2 3
	5 6 7  8 9 1  2 3 4
	6 7 8  9 1 2  3 4 5
	
	7 8 9  1 2 3  4 5 6
	8 9 1  2 3 4  5 6 7 
	9 1 2  3 4 5  6 7 8	
	"

	| board expected |
	expected := SudokuBlock new.

	expected
		row: 1 column: 1 put: 7;
		row: 1 column: 2 put: 8;
		row: 1 column: 3 put: 9;
		row: 2 column: 1 put: 8;
		row: 2 column: 2 put: 9;
		row: 2 column: 3 put: 1;
		row: 3 column: 1 put: 9;
		row: 3 column: 2 put: 1;
		row: 3 column: 3 put: 2.
	expected boardRows
		at: 1 put: 7;
		at: 2 put: 8;
		at: 3 put: 9.

	expected boardCols
		at: 1 put: 1;
		at: 2 put: 2;
		at: 3 put: 3.

	board := SudokuBoard new.
	board setDummy.

	self assert: (board privateBlockAt: 7 at: 1) equals: expected
]

{ #category : #tests }
SudokuBoardTest >> testPrivateSkeweredCellsAtFrom [
	"private SudokuBoardTest >>  privateSkeweredCellsAt:from:のテスト
	セルを串刺しを要素とした配列を返したかテストする
	"
	| example result expected index|
	example := #(#(1 9 7   0 0 4   2 0 5) 
				  #(6 8 0   5 3 0   9 0 0) 
				  #(5 0 3   0 7 2   1 6 8)
	
				  #(0 6 0   4 0 9   7 0 2) 
				  #(0 7 5   0 1 0   6 8 0) 
				  #(2 0 9   8 0 7   0 4 0) 
	
				  #(7 5 6   3 2 0   4 0 1) 
				  #(0 0 1   0 4 5   0 2 6) 
				  #(8 0 4   1 0 0   3 5 7)).

	
	index := 7.
	expected := #(2 9 1 7 6 0 4 0 3).
	result := self privateSkeweredCellsAt: index from: example .
	self assert: result equals: expected.
	
	index := 4.
	expected := #(0 5 0 4 0 8 3 0 1).
	result := self privateSkeweredCellsAt: index from: example .
	self assert: result equals: expected.
	

]

{ #category : #tests }
SudokuBoardTest >> testRowColumn [

	| sb |
	sb := SudokuBoard new.
	sb setDummy .
	
	self assert: (sb row: 3 column: 6) equals: 8.
	self assert: (sb row: 7 column: 5) equals: 2.
]

{ #category : #tests }
SudokuBoardTest >> testRowColumnPut [ 

	| sb |
	sb := SudokuBoard new.
	sb row: 3 column: 5 put: 7.
	
	self assert: (sb row: 3 column: 5) equals: 7
]

{ #category : #tests }
SudokuBoardTest >> testRowsAt [

	| example sb expected index|
	example := #(#(1 9 7   0 0 4   2 0 5) 
				  #(6 8 0   5 3 0   9 0 0) 
				  #(5 0 3   0 7 2   1 6 8)
	
				  #(0 6 0   4 0 9   7 0 2) 
				  #(0 7 5   0 1 0   6 8 0) 
				  #(2 0 9   8 0 7   0 4 0) 
	
				  #(7 5 6   3 2 0   4 0 1) 
				  #(0 0 1   0 4 5   0 2 6) 
				  #(8 0 4   1 0 0   3 5 7)).

	
	sb := SudokuBoard new.
	sb loadExample: example .
	index := 2.
	expected := example at: index.
	self assert: (sb rowsAt: index) equals: expected.
	
	index := 8.
	expected := example at: index .
	self assert: (sb rowsAt: index) equals: expected.
	
	
	
]
