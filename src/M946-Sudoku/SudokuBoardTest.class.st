Class {
	#name : #SudokuBoardTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku-Tests'
}

{ #category : #tests }
SudokuBoardTest >> testBlockkenAt [

	|board result expected |
	expected := SudokuBlockken new.
	"Test ブロック5"
	expected row: 1 column: 1 put:0;
			row:1 column: 2 put: 3;
			row:1 column: 3 put: 0;
			row:2 column: 1 put: 4;
			row:2 column: 2 put: 0;
			row:2 column: 3 put: 6;
			row:3 column: 1 put: 0;
			row:3 column: 2 put: 1;
			row:3 column: 3 put: 0.
			
			
	expected boardRows at: 1 put: 4;
						at: 2 put: 5;
						at: 3 put: 6.
						
	expected boardCols  at: 1 put: 4;
						at: 2 put: 5;
						at: 3 put: 6.
						
	board  := SudokuBoard new.
	board  setExample1.
	result := board blockkenAt: 5.	
	self assert: result equals: expected.
	
	"Test ブロック9"
	expected row: 1 column: 1 put: 0;
			row:1 column: 2 put: 5;
			row:1 column: 3 put: 0;
			row:2 column: 1 put: 4;
			row:2 column: 2 put: 0;
			row:2 column: 3 put: 0;
			row:3 column: 1 put: 0;
			row:3 column: 2 put: 0;
			row:3 column: 3 put: 1.
			
			
	expected boardRows at: 1 put: 7;
						at: 2 put: 8;
						at: 3 put: 9.
						
	expected boardCols  at: 1 put: 7;
						at: 2 put: 8;
						at: 3 put: 9.
	result := board blockkenAt: 9.	
	self assert: result equals: expected.
	
	
]

{ #category : #tests }
SudokuBoardTest >> testBlockkenAtAt [

	|board  expected |
	expected := SudokuBlockken new.
	
	expected row: 1 column: 1 put:7;
			row:1 column: 2 put: 8;
			row:1 column: 3 put: 9;
			row:2 column: 1 put: 8;
			row:2 column: 2 put: 9;
			row:2 column: 3 put: 1;
			row:3 column: 1 put: 9;
			row:3 column: 2 put: 1;
			row:3 column: 3 put: 2.
	expected boardRows at: 1 put: 7;
						at: 2 put: 8;
						at: 3 put: 9.
						
	expected boardCols  at: 1 put: 1;
						at: 2 put: 2;
						at: 3 put: 3.			
	board := SudokuBoard new.
	board setDummy.
	
	self assert: (board blockkenAt: 7 at: 1) equals: expected 
			
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
