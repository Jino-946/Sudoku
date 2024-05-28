"
『いずれにしても理論』を用い数独問題を解決します。
EitherWayは数独のルールと解き方で紹介されている「考え方④」の実装です。
  
[EitherWay について] 
ブロッケン方式、レッツミー方式、マスミ方式のように特定のブロックや列を順番に注目して数字を埋めるのではなく、
ボード全体を見渡し、検証数字が入らないセルをマークする方法から始めます。
そして、ブランクセルが2つあるブロックを探し出すことが重要です。
ブロックにブランクセルが2つしかない場合、検証数字は必ずそのどちらかのセルに入ることになります。

さらに、2つのブランクセルが同じ行または列上にある場合、その行または列の他のセルには検証数字は入らないため、
他のブロックのブランクセルをマークできます。
この際、他のブロックのブランクセルが2つだった場合、マークされなかったセルに検証数字が入ることが確定します。

[【ニコリ公式】数独の解き方　上級編　その2 ]  の例題

```
task :=
'
 0 9 0   0 5 0   0 3 0
 0 0 5   6 0 0   0 0 8
 3 0 0   0 0 7   6 0 0

 0 7 0   0 0 4   3 0 0
 8 0 0   0 9 0   0 0 1
 0 0 2   3 0 0   0 8 0

 0 0 1   5 0 0   0 0 6
 5 0 0   0 0 6   9 0 0
 0 4 0   0 2 0   5 7 0
'.

vNumber := 5.

board := SudokuBoard2 new.
board loadFromString: task.
eitherWay := EitherWay  new: board.
eitherWay markBlankCellsOnBlocks: vNumber.
eitherWay markBlankCellsOnColumns: vNumber.
eitherWay markBlankCellsOnRows: vNumber.
eitherWay findCandidatesForEitherCells: vNumber.
Transcript clear; show: board .
eitherWay finish: vNumber.
Transcript cr; show: '==============================================='.
Transcript cr; show: board .
```
"
Class {
	#name : #EitherWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'private - logics' }
EitherWay >> findCandidatesForEitherCells: verifyNumber [
	"
	検証番号を含まずブランクセルが２つのブロックを探し
	あった時はマークする
	"
	| block |
	1 to: 9 do: [ :n |
		block := sudokuBoard atBlock: n verifyNumber: verifyNumber.
		(block includesVerifyNumber) not and: [  
			block countOfReservedBlankCells = 2
				ifTrue: [ self markEitherCellsOn: block ]]]
	
]

{ #category : #'sudoku - solution' }
EitherWay >> finish: verifyNumber [

	1 to: 9 do: [ :n | | block eitherCells |
		block := sudokuBoard atBlock: n verifyNumber: verifyNumber.
		eitherCells := block eitherCells .
		eitherCells isNotEmpty ifTrue: [ 
			eitherCells colIndex > 0 ifTrue: [ self verticalProcessing: block colIndex: eitherCells colIndex ].	
			eitherCells rowIndex > 0 ifTrue: [ self horizontalProcessing: block rowIndex: eitherCells rowIndex ]]]
	
"
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

vNumber := 2.

board := SudokuBoard2 new.
board loadFromString: task.
eitherWay := EitherWay  new: board.
eitherWay markBlankCellsOnBlocks: vNumber.
eitherWay markBlankCellsOnColumns: vNumber.
eitherWay markBlankCellsOnRows: vNumber.
eitherWay findCandidatesForEitherCells: vNumber.
Transcript clear; show: board .
eitherWay finish: vNumber.
Transcript cr; show: '==============================================='.
Transcript cr; show: board .
"
]

{ #category : #'private - logics' }
EitherWay >> horizontalProcessing: block rowIndex: rowIndex [
	
	| relatedBlockNumbers |
	relatedBlockNumbers := relatedHorBlocks at: block blockNumber .
	relatedBlockNumbers do: [ :num | | relatedBlock eitherCells |
		relatedBlock := sudokuBoard atBlock: num verifyNumber: block verifyNumber .
		eitherCells := relatedBlock eitherCells .
		eitherCells isNotEmpty ifTrue: [ | cell1 cell2 |			
			cell1 := eitherCells at: 1.
			cell2 := eitherCells at: 2.
			cell1 rowIndex = rowIndex ifTrue: [ 
				cell1 element: $X.
				cell2 element: block verifyNumber.
			].
			cell2 rowIndex = rowIndex ifTrue: [ 
				cell2 element: $X.
				cell1 element: block verifyNumber.
			].
			sudokuBoard map: cell1.
			sudokuBoard map: cell2.]]
]

{ #category : #'private - logics' }
EitherWay >> markBlankCellsOnBlocks: verifyNumber [
	"
	ブロックに検証数字があるときは全てのブランクセルを$Xでマークする
	"
	||
	1 to: 9 do: [ :n | | block |
		block := sudokuBoard atBlock: n verifyNumber: verifyNumber .
		block includesVerifyNumber 
			ifTrue: [  
				block markBlankCells .
				sudokuBoard map: block .]]
	
]

{ #category : #'private - logics' }
EitherWay >> markBlankCellsOnColumns: verifyNumber [
	"
	検証数字のある列の全てのブランクセルを$Xでマークする
	"
	1 to: 9 do: [ :i | | columnCells |
		columnCells := sudokuBoard atSudokuColumn: i.
		(columnCells includes: verifyNumber )
			ifTrue: [ 
				columnCells markBlankCells.
				sudokuBoard map: columnCells ]]

]

{ #category : #'private - logics' }
EitherWay >> markBlankCellsOnRows: verifyNumber [
	"
	検証数字のある行の全てのブランクセルを$Xでマークする
	"
	1 to: 9 do: [ :i | | rowCells |
		rowCells := sudokuBoard atSudokuRow: i.
		(rowCells includes: verifyNumber )
			ifTrue: [ 
				rowCells markBlankCells.
				sudokuBoard map: rowCells ]]

]

{ #category : #'private - logics' }
EitherWay >> markEitherCellsOn: block [
	"
	２つのブランクセルを検証番号のcharacterDigitでマークし、ボードにマップする。

	備考)
	EitherWay >> findCandidatesForEitherCells: の中からメッセージが送られるので
	blockにはブランクセルが必ず２つあることは保証されている。
	"
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j |
			(block row: i column: j) = self blankCell ifTrue: [
				| rIdx cIdx charDigit |
				rIdx := block rowIndexOnBoard: i.
				cIdx := block colIndexOnBoard: j.
				charDigit := block verifyNumber asCharacterDigit.
				block row: i column: j put: charDigit]]].
	sudokuBoard map: block.

	
]

{ #category : #logic }
EitherWay >> solve [

	1 to: 9 do: [ :vNumber| 
		self markBlankCellsOnBlocks: vNumber .
		self markBlankCellsOnColumns: vNumber.
		self markBlankCellsOnRows: vNumber .
		self findCandidatesForEitherCells: vNumber .
		self finish: vNumber.
		sudokuBoard clearMarks 
	]

" 
EitherWayを併用することで下記のExampleは解決することができた。
検証番号1の時ブロック7の1@1セルが1に確定することができる。
"

" == Example==

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

vNumber := 1.

board := SudokuBoard2 new.
board loadFromString: task.
eitherWay := EitherWay  new: board.
eitherWay markBlankCellsOnBlocks: vNumber.
eitherWay markBlankCellsOnColumns: vNumber.
eitherWay markBlankCellsOnRows: vNumber.
eitherWay findCandidatesForEitherCells: vNumber.
Transcript clear; show: board .
eitherWay finish: vNumber.
Transcript cr; show: '==============================================='.
Transcript cr; show: board .

"
]

{ #category : #'private - logics' }
EitherWay >> verticalProcessing: block colIndex: colIndex [
	
	| relatedBlockNumbers |
	relatedBlockNumbers := relatedVertBlocks  at: block blockNumber .
	relatedBlockNumbers do: [ :num | | relatedBlock eitherCells |
		relatedBlock := sudokuBoard atBlock: num verifyNumber: block verifyNumber .
		eitherCells := relatedBlock eitherCells .
		eitherCells isNotEmpty ifTrue: [ | cell1 cell2 |
	
			cell1 := eitherCells at: 1.
			cell2 := eitherCells at: 2.
			cell1 colIndex = colIndex ifTrue: [ 
				cell1 element: $X.
				cell2 element: block verifyNumber.
			].
			cell2 colIndex = colIndex ifTrue: [ 
				cell2 element: $X.
				cell1 element: block verifyNumber.
			].
			sudokuBoard map: cell1.
			sudokuBoard map: cell2.]]
]
