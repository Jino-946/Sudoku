"
レツミ(列見)方式を用い数独問題を解決する。

LetsmeWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方②」の実装です。

"
Class {
	#name : #LetsmeWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #examples }
LetsmeWay >> example [
	"
	一度のsolveの実行ではtaskを解決できないが二度実行することで解決できた
	"

	| task board letsmeWay |
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



	letsmeWay := self class new: board.
	letsmeWay
		solve;
		solve.

	^ board completed "=> true"
]

{ #category : #logic }
LetsmeWay >> letsme: block [
	"
	verifyNumberが含まれているブロックを処理の対象としている。
	ブロックのセルが含まれるSudokuColumnを検査し、verifyNumberを
	置くことが出来る時はSudokuBoardにマップする。	
	"

	| column row cell |
	1 to: 3 do: [ :ci |
		column := block colsOnBoard at: ci. "<- aSudokuColumn"
		(column includes: block verifyNumber) ifFalse: [ 		
			"verifyNumberが含まれるブロックを検証の対象としているので
			 ブロック内の列についてはブランクセルを全てマークすることができる"
			1 to: 3 do: [ :i |
				(column at: (block rowIndexOnBoard: i)) = self blankCell ifTrue: [
					column at: (block rowIndexOnBoard: i) put: $X ] ].

			"ブロック内の列もスキャンしているがブロック内はマーク済みのため影響はない"
			1 to: 9 do: [ :i |
				row := sudokuBoard atRow: i. "<- anArray(SmallInteger)"
				(row includes: block verifyNumber) ifTrue: [
					(column at: i) = self blankCell ifTrue: [ column at: i put: $X ] ] ].

			cell := column tenpai.
			cell class = SudokuCell ifTrue: [
				cell element: block verifyNumber.
				self tsumo: cell ] ] ]
]

{ #category : #logic }
LetsmeWay >> solve [
	"
	レッツミー(列見)方式

	ブロックのセルが含まれるボード列(colsOnBoard)に注目する。
    ボード列のブランクセルで重複のため検証数字を配置できないセルは$Xでマークする。
	配列のブランクセルが一つになったなら配備される数字は自動的に決定する。	
	"

	| block cell |
	cell := 0.
	block := 0.
	1 to: 9 do: [ :n |
		1 to: 9 do: [ :vNum |
			block := sudokuBoard atBlock: n.
			block verifyNumber: vNum.
			block includesVerifyNumber ifTrue: [ self letsme: block. ] ].
		block := sudokuBoard atBlock: n.
		block verifyNumber: 0.
		cell := block allGreen.
		cell class = SudokuCell ifTrue: [ self tsumo: cell ]] 
	
"
一度のsolveの実行ではtaskを解決できないが二度実行することで解決できた
---------------------------------------------------------------------

task := '
1	9	7		0	0	4		2	0	5	
6	8	0		5	3	0		9	0	0	
5	0	3		0	7	2		1	6	8	


0	6	0		4	0	9		7	0	2	
0	7	5		0	1	0		6	8	0	
2	0	9		8	0	7		0	4	0	


7	5	6		3	2	0		4	0	1	
0	0	1		0	4	5		0	2	6	
8	0	4		1	0	0		3	5	7	
'.

	board := SudokuBoard2 new.
	board loadFromString: task.

	letsmeWay := LetsmeWay  new: board.
	letsmeWay
		solve;
		solve.

	board completed.

"
]
