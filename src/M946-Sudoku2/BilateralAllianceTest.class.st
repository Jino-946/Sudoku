Class {
	#name : #BilateralAllianceTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock2Row3 [
	"ワンペアで片方のセルに入る数字が決まったケース"
	"ブロック2 列3#($2  0  $2) -> #(2  0  0)"
	| logger  solver board thisCell cell1 cell2 cell3 allies block candidates expected |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	cell1  := SudokuCell row: 4 column: 5 element: 3.
	cell1 possibleNumbers add: 1.
	cell1 possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: cell1 .
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.
	logger info: board .
	
	"ブロック2 列3#($2  0  $2) -> #(2  0  0)"
	thisCell := board boardA2D at: 3 at: 4.
	thisCell element: 2.
	block := board getBlock: 2 verifyNumber: 2.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 1.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	expected := SudokuCell row: 3 column: 6 element: 0.
	self assert: allies equals: expected  .
	board map: allies.

	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.
	
]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock4Col3 [
	"非対称ペアで設置可能数字が1つのセルに入る数字(検証数字)が決まったケース"
	"ブロック4 列3#($5 $4 $45) -> #($5 4 $5)"
	| logger  solver board thisCell cell1 cell2 cell3 allies block candidates expected |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化   他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	cell1  := SudokuCell row: 4 column: 5 element: 3.
	cell1 possibleNumbers add: 1.
	cell1 possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: cell1 .
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.
	logger info: board .
	
	"ブロック4 列3#($5 $4 $45) -> #($5 4 $5)"
	thisCell := board boardA2D at: 5 at: 3.
	thisCell element: 4.
	block := board getBlock: 4 verifyNumber: 4.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 1.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	expected := SudokuCell row: 6 column: 3 element: 0.
	expected possibleNumbers add: 5.
	self assert: allies equals: expected  .
	board map: allies.

	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.
	
]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock4Col3_2 [
	"非対称ペアで設置可能数字が1つのセルに入る数字(検証数字)が決まったケース"
	"ブロック4 列3#($5 $4 $45) -> #(5  $4  $4)"
	| logger  solver board thisCell cell1 cell2 cell3 allies block candidates expected |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化  他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	cell1  := SudokuCell row: 4 column: 5 element: 3.
	cell1 possibleNumbers add: 1.
	cell1 possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: cell1 .
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.
	logger info: board .

	"ブロック4 列3#($5 $4 $45) -> #(5  $4  $4)"
	thisCell := board boardA2D at: 4 at: 3.
	thisCell element: 5.
	block := board getBlock: 4 verifyNumber: 5.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 1.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	expected := SudokuCell row: 6 column: 3 element: 0.
	expected possibleNumbers add: 4.
	self assert: allies equals: expected  .
	board map: allies.

	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.
	
]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock4Col3_3 [
	"非対称ペアで設置可能数字が1つのセルに入る数字(ペア数字以外)が決まったケース"
	"ブロック4でセル3@1に9が入ったと仮定   #($5 $4 $45) -> #(9  4  5)"
	| logger  solver board thisCell cell1 cell2 cell3  block candidates |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化  他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	cell1  := SudokuCell row: 4 column: 5 element: 3.
	cell1 possibleNumbers add: 1.
	cell1 possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: cell1 .
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.

	"ブロック4 列3#($5 $4 $45) -> #(9  4  5)"
	thisCell := board boardA2D at: 4 at: 3.
	thisCell element: 9.
	logger info: board .	
	
	block := board getBlock: 4 verifyNumber: 9.
	candidates :=  solver getAllianceCellsAfterMark: block.
	
	logger info: candidates.
	
	self error: 'not completed!!'
]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock5Col2 [
	"非対称ペアで設置可能数字が2つのセルに入る数字(検証数字)が決まったケース"
	"ブロック5 列2#($13 $3 $1) -> #(3 0 1)"
	| logger  solver board thisCell cell2 cell3 allies block candidates |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化 他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	thisCell  := SudokuCell row: 4 column: 5 element: 3.
	thisCell possibleNumbers add: 1.
	thisCell possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: thisCell .
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.
	logger info: board .
	
	"ブロック5 列2  検証数字3  #($13 $3 $1) -> #(3 0 1)"
	block := board getBlock: 5 verifyNumber: 3.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 2.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	self assert: allies equals: (SudokuCell row: 5 column: 5 element: 0).
	board map: allies.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 2)) determineTheNumber .
	self assert: allies equals: (SudokuCell row: 6 column: 5 element: 1).
	board map: allies .
	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.
	

]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock5Col2_2 [
	"非対称ペアで設置可能数字が2つのセルに入る数字(検証数字)が決まったケース"
	"ブロック5 列2  検証数字1  #($13 $3 $1) -> #(1 3 0)"
	| logger  solver board thisCell cell2 cell3 allies block candidates |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化 他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.

	
	"ブロック5 列2  検証数字1  #($13 $3 $1) -> #(1 3 0)"
	thisCell  := SudokuCell row: 4 column: 5 element: 1	.
	thisCell possibleNumbers add: 1.
	thisCell possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: thisCell .
	logger info: board .
	

	
	block := board getBlock: 5 verifyNumber: 1.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 2.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	self assert: allies equals: (SudokuCell row: 5 column: 5 element: 3).
	board map: allies.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 2)) determineTheNumber .
	self assert: allies equals: (SudokuCell row: 6 column: 5 element: 0).
	board map: allies .
	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.


]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock5Row2 [
	"ツーペアで1つのセルに入る数字が決まったケース"
	"ブロック5 行2#($26 $3 $26) -> #(6 $3 2)"
	| logger  solver board thisCell cell2 cell3 allies block candidates |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化  他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	thisCell  := SudokuCell row: 4 column: 5 element: 3.
	thisCell possibleNumbers add: 1.
	thisCell possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: thisCell .
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.
	logger info: board .
	
	
	"ブロック5 行2#($26 0 $26) -> #(6 0 2)"
	thisCell := board boardA2D at: 5 at: 6.
	thisCell element: 2.
	block := board getBlock: 5 verifyNumber: 2.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 1.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	self assert: allies equals: (SudokuCell row: 5 column: 4 element: 6).
	board map: allies.
	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.
	
		
	
]

{ #category : #tests }
BilateralAllianceTest >> testDetermineTheNumberBlock9Row1 [
	"ワンペアで1つのセルに入る数字が決まったケース
	 行1は4のワンペアだが3@1セルに9が入ったと仮定すると
    1@1セルは4が入ることが確定する。
	ブロック9 行1#($4  0  $4) -> #(4  0  9)"
	| logger  solver board thisCell cell1 cell2 cell3 allies block candidates |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	"ボードの初期化  他のテストと盤面を統一するためブロック5を修正"
	board := FLMaterializer new 
        filePath: 'fuel/N3Block5_OnePair3_OnePair1.fuel';
        materializeRoot .
	solver := OttiezTactics new: board.
	cell1   := SudokuCell row: 4 column: 5 element: 3.
	cell1 possibleNumbers add: 1.
	cell1 possibleNumbers add: 3. 
	board boardA2D at: 4 at: 5 put: cell1.
	
	cell2 := SudokuCell row: 6 column: 5 element: 0.
	cell2 possibleNumbers add: 1.
	board boardA2D at: 6 at: 5 put: cell2.
	
	cell3 := SudokuCell row: 5 column: 5 element: 0.
	cell3 possibleNumbers add: 3.
	board boardA2D at: 5 at: 5 put: cell3.
	logger info: board .
	
	
	"ブロック9 行1#($4  0  $4) -> #(4  0  9)"
	thisCell := board boardA2D at: 7 at: 9.
	thisCell element: 9.
	block := board getBlock: 9 verifyNumber: 4.
	candidates :=  solver getAlliedCellForMapping: block cell: thisCell.
	self assert: candidates size equals: 1.
	allies := (BilateralAlliance thisCell: thisCell otherCell: (candidates at: 1)) determineTheNumber .
	self assert: allies equals: (SudokuCell row: 7column: 7 element: 4).
	board map: allies.
	thisCell clearPossibleNumbers .
	board map: thisCell.
	logger info: board.
	
		
]
