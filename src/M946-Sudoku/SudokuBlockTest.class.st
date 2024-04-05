Class {
	#name : #SudokuBlockTest,
	#superclass : #TestCase,
	#instVars : [
		'example0'
	],
	#category : #'M946-Sudoku-Tests'
}

{ #category : #initialization }
SudokuBlockTest >> initialize [ 

	super initialize .
	example0 := 
#(  #(1 9 7  0 0 4  2 0 5) 
	#(6 8 0  5 3 0  9 0 0) 
	#(5 0 3  0 7 2  1 6 8)
	
	#(0 6 0  4 0 9  7 0 2) 
	#(0 7 5  0 1 0  6 8 0) 
	#(2 0 9  8 0 7  0 4 0) 
	
	#(7 5 6  3 2 0  4 0 1) 
	#(0 0 1  0 4 5  0 2 6) 
	#(8 0 4  1 0 0  3 5 7)).
]

{ #category : #tests }
SudokuBlockTest >> testBingo [ 
	"
	bingo
      #1)blockkenTenpaiの時に検証数値をブランクセルに入れその座標を返す。
      #2)ブロック上のXを0にリセットする。	
	"
	| board block coordinates expected |
	board := SudokuBoard new.
	board loadExample: example0 .
	block := SudokuBlock sudokuBoard: board  blockNumber: 9 verifyNumber: 8.
	block row: 1 column: 2 put: $X.
	coordinates := nil.
	
	block blockkenTenpai 
	ifTrue: [ coordinates := block bingo ].
	
	self assert: (block row: 2 column: 1) equals: 8.
	self assert: (block row: 1 column: 2) equals: block blankCell .
	
	expected  := block toBoardCoordinatesRow: 2 column: 1.
	self assert: coordinates  equals: expected 

]

{ #category : #tests }
SudokuBlockTest >> testBlockkenTenpai [
	
	| board block |
	board := SudokuBoard new.
	board loadExample: example0 .
	block := board blockAt: 8.
	
	self assert: block countBlank  equals: 4.
	self assert: block blockkenTenpai equals: false.
	
	block 	row: 2 column: 1 put: $X;
			row: 3 column: 2 put: $X;
			row: 3 column: 3 put: $X.
			
	self assert: block blockkenTenpai equals: true.
	
]

{ #category : #tests }
SudokuBlockTest >> testCountBlank [

	| board block|
	board := SudokuBoard new.
	board loadExample: example0.
	
	block := board blockAt: 3.	
	self assert: block countBlank equals: 3.
	
	block := board blockAt: 8.
	self assert: block countBlank equals: 4.
	

	
]

{ #category : #tests }
SudokuBlockTest >> testFromArray [

	|board block  expected array|
	
	array := #(0 6 0
				0 7 5
				2 0 9).
	
	expected := SudokuBlock fromArray: array.
	
	board := SudokuBoard new.
	board loadExample: example0 .
	block := board blockAt: 4.
	
	self assert:  block blockA2D equals: expected blockA2D
]

{ #category : #tests }
SudokuBlockTest >> testSudokuBoardBlockNumberVerifyNumber [
	| board actual expected bNum vNum|
	
	bNum := 5.
	vNum := 7.
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
	expected blockNumber: bNum.
	expected verifyNumber: vNum.

	board := SudokuBoard new.
	board setExample1.
	actual := SudokuBlock sudokuBoard: board blockNumber: bNum verifyNumber: vNum.
	self assert: actual equals: expected.

	

	
]

{ #category : #tests }
SudokuBlockTest >> testTenpai [

	| board block |
	board := SudokuBoard new.
	board loadExample: example0 .
	block := board blockAt: 1.
	
	self assert: block countBlank  equals: 2.
	self assert: block tenpai equals: false.
	
	block 	row: 2 column: 3 put: 4.
			
	self assert: block tenpai equals: true.
		
]

{ #category : #tests }
SudokuBlockTest >> testToBoardCoordinatesRowColumn [

	|sBoard sBlock actual expected|
	sBoard := SudokuBoard new.
	sBoard setExample0 .
	
	"Test Block1"
	sBlock := sBoard blockAt: 1.
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  1 column: 1.
	
	expected := SBCoordinates new.
	"SudokuBoard座標"
	expected row: 1 column: 1.
	self assert: actual equals: expected.
	
	"Test Block5"
	sBlock := sBoard blockAt: 5.
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  2 column: 3.
	"SudokuBoard座標"
	expected row: 5 column: 6.
	self assert: actual equals: expected.
	
	actual := sBlock toBoardCoordinatesRow:  3 column: 2.
	expected row: 6 column: 5.
	self assert: actual equals: expected.
	
	"Test Block6"
	sBlock := sBoard blockAt: 6.
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  2 column: 3.
	"SudokuBoard座標"
	expected row: 5 column: 9.
	self assert: actual equals: expected.
	
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  3 column: 2.
	"SudokuBoard座標"
	expected row: 6 column: 8.
	self assert: actual equals: expected.
	
	
	"Test Block8"
	sBlock := sBoard blockAt: 8.
	actual := sBlock toBoardCoordinatesRow:  2 column: 3.
	expected row: 8 column: 6.
	self assert: actual equals: expected.
	
	actual := sBlock toBoardCoordinatesRow:  3 column: 2.
	expected row: 9 column: 5.
	self assert: actual equals: expected.

]

{ #category : #tests }
SudokuBlockTest >> testTsumo [

	| board block coordinates expected |
	board := SudokuBoard new.
	board loadExample: example0 .
	block := SudokuBlock sudokuBoard: board  blockNumber: 9 verifyNumber: 8.
	block row: 1 column: 2 put: 9.

	coordinates := nil. "coordinates初期化"
	block tenpai
	ifTrue: [ coordinates := block tsumo ].	
	self assert: (block row: 2 column: 1) equals: 8.
	
	expected := block toBoardCoordinatesRow: 2 column: 1.
	self assert: coordinates  equals: expected 
	
	
	
	
]
