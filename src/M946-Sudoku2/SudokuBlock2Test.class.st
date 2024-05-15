Class {
	#name : #SudokuBlock2Test,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
SudokuBlock2Test >> testAllGreen [

	| task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
0	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	3	7		4	0	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	"ブロック4のツモを確認する"
	block := board atBlock: 4.
	cell := block allGreen.
	self assert: cell equals: (SudokuCell row: 5 column: 1 element: 7).
	
	"ブロック8のツモを確認する"
	block := board atBlock: 8.
	cell := block allGreen.
	self assert: cell equals: (SudokuCell row: 7 column: 5 element: 9)
	
]

{ #category : #tests }
SudokuBlock2Test >> testBlankCellsAsArray [
	|task board block cells|
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
	board loadFromString: task.
	block := board atBlock: 9.
	
	cells := Array new: 2.
	cells at: 1 put: (SudokuCell row: 7 column: 8 element: 0).
	cells at: 2 put: (SudokuCell row: 8 column: 7 element: 0).
	
	self assert: block blankCellsAsArray  equals: cells.
	
]

{ #category : #tests }
SudokuBlock2Test >> testCellOf [

	|task board block cell|
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
	board loadFromString: task.
	block := board atBlock: 5.
	
	cell := SudokuCell row: 4 column: 6 element: 9.
	
	self assert: (block cellOf: 9) equals:  cell.
]

{ #category : #tests }
SudokuBlock2Test >> testColIndexOnBoard [

	| board block task  |
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	
	block := board atBlock: 1.
	self assert: (block colIndexOnBoard: 2) equals: 2.
	
	block := board atBlock: 5.
	self assert: (block colIndexOnBoard: 2) equals: 5.
	
	block := board atBlock: 9.
	self assert: (block rowIndexOnBoard: 3) equals: 9.
]

{ #category : #tests }
SudokuBlock2Test >> testColsOnBoard [

	| board block cols task column |
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 3.
	cols := block colsOnBoard .
	
	column := SudokuColumn new.
	column colIndex: 7;
			column: #(3 0 2 7 8 0 0 0 0).			
	self assert: (cols at: 1) equals: column.
 
	column colIndex: 9;
			column: #(0 6 7 0 3 0 0 5 9).			
	self assert: (cols at: 3) equals: column.
	
	

]

{ #category : #tests }
SudokuBlock2Test >> testEishanteng [
	" イーシャンテン(一向聴)
	
	ブロックにブランクセル2つ時(一向聴)はブランクセルのボード座標をSudokuCellにマッピングして配列にして返す。
	でなければ0を返す。
	"
	| task board  block result expected cell |
	task := '
	9	4	7		6	5	3		2	1	8	
	8	6	1		9	2	7		3	5	4	
	2	3	5		0	0	4		7	9	6	

	0	0	0		0	0	2		0	4	9	
	4	2	9		0	0	1		0	0	0	
	0	0	6		4	0	9		0	0	2	

	0	9	2		7	4	0		0	6	0	
	6	0	4		0	0	0		9	2	7	
	5	7	0		2	9	6		4	$X	$X	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.

	expected := Array new: 2.
	cell := SudokuCell row: 7 column: 7 element: 5 asCharacterDigit . 
	expected at: 1 put: cell.
	cell := SudokuCell row: 7 column: 9 element: 5 asCharacterDigit .
	
	block := board atBlock: 9.
	block verifyNumber: 5.
	result := block eishanteng .
	

]

{ #category : #tests }
SudokuBlock2Test >> testRowIndexOf [
	"
	rowIndexOf: number
	ブロックにおけるnumberの行インデックスを返す
	"
	| task board block group |
	task := '
	9	4	7		6	5	3		2	1	8	
	8	6	1		9	2	7		3	5	4	
	2	3	5		0	0	4		7	9	6	


	0	0	0		0	0	2		0	4	9	
	4	2	9		0	0	1		0	0	0	
	0	0	6		4	0	9		0	0	2	


	0	9	2		7	4	0		0	6	0	
	6	0	4		0	0	0		9	2	7	
	5	7	0		2	9	6		4	0	0	

	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	group := board atHorGroup: 3.
	block := group atBlock: 1.
	
	self assert: (block rowIndexOf:5) equals: 3.
	self assert: (block rowIndexOf:9) equals: 1.
	
	block := group atBlock: 3.
	self assert: (block rowIndexOf:6) equals: 1.
	self assert: (block rowIndexOf:9) equals: 2.

]

{ #category : #tests }
SudokuBlock2Test >> testRowIndexOnBoard [

	| board block task  |
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	
	block := board atBlock: 1.
	self assert: (block rowIndexOnBoard: 2) equals: 2.
	
	block := board atBlock: 5.
	self assert: (block rowIndexOnBoard: 2) equals: 5.
	
	block := board atBlock: 9.
	self assert: (block rowIndexOnBoard: 2) equals: 8.
]

{ #category : #tests }
SudokuBlock2Test >> testRowsOnBoard [

	| board block rows row task|
	
	task := '
9	0	6		8	2	4		3	5	0	
0	1	2		0	3	0		0	0	6	
5	0	3		9	6	0		2	8	7	


2	9	1		3	0	0		7	6	0	
0	0	0		0	4	9		8	0	3	
3	8	0		0	0	0		0	0	0	


1	0	0		4	9	0		0	0	0	
6	2	0		1	0	0		0	0	5	
0	5	8		0	0	0		0	0	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	block := board atBlock: 7.
	rows := block rowsOnBoard .
	
	row := SudokuRow new.
	row rowIndex: 8;
			row: #(6 2 0 1 0 0 0 0 5).	
						
	self assert: (rows at: 2) equals: row.
 
]

{ #category : #tests }
SudokuBlock2Test >> testTenpai [ 

	| board block expected data|
	data := '

1	2	3		4	5	6		7	8	9	
2	3	4		5	6	7		8	9	1	
3	4	5		6	7	8		9	1	2	


4	5	6		7	8	9		1	2	3	
5	6	7		8	9	1		2	3	4	
6	7	8		9	0	2		3	4	5	


7	8	9		1	2	3		4	5	6	
8	9	1		2	3	4		5	6	0	
9	1	2		3	4	5		6	7	8		
	
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: data.

	"ブロック5のテンパイを確認する"
	block := board atBlock: 5.
	expected := SudokuCell row: 6 column: 5 element: 0.
	self assert: block tenpai equals: expected.

    "ブロック9のテンパイを確認する"
	block := board atBlock: 9.
	expected := SudokuCell row: 8 column: 9  element: 0.
	self assert: block tenpai equals: expected .

]

{ #category : #tests }
SudokuBlock2Test >> testTsumo [ 

	| task board block cell |
	task := '
9	7	6		8	2	4		3	5	1	
8	1	2		5	3	7		9	4	6	
5	4	3		9	6	1		2	8	7	


2	9	1		3	5	8		7	6	4	
0	6	5		2	4	9		8	1	3	
3	8	4		7	1	6		5	9	2	


1	3	7		4	0	5		6	2	8	
6	2	9		1	8	3		4	7	5	
4	5	8		6	7	2		1	3	9		
	'.
	
	board := SudokuBoard2 new.
	board loadFromString: task.
	"ブロック4のツモを確認する"
	block := board atBlock: 4.
	cell := block tsumo.
	self assert: cell equals: (SudokuCell row: 5 column: 1 element: 7).
	
	"ブロック8のツモを確認する"
	block := board atBlock: 8.
	cell := block tsumo.
	self assert: cell equals: (SudokuCell row: 7 column: 5 element: 9)
	
]
