"
マスミ方式を用い数独問題を解決する。

MasumiWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方③」の実装です。

"
Class {
	#name : #MasumiWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #examples }
MasumiWay >> example [
	"
	一度のsolveの実行ではtaskを解決できないが二度実行することで解決できた
	"
	| task board masumiWay |
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



	masumiWay := self class new: board.
	masumiWay solve; solve.

	board completed .  "=> true"

]

{ #category : #logic }
MasumiWay >> solve [
	"
	ブロックのブランクセルの一つに注目する。

	ブロックの0以外の数の配列を作る。
	注目したブランクセルに直交する行と列の0以外の数の配列を作る。
	3つの配列を連結し、重複を取り除く。
	配列のサイズが8の時はブランクセルに配置する数は決定するので
	対応するボードのセルにマップする。
	
	一時変数
	block: 			検証するブロック
	blankCells:		ブロックのブランクセルの配列(SudokuCell)
	blockNumbers:	ブロックの数の配列(SmallInteger)
	rowNumbers:		ブランクセルに直交する行における数の配列(SmallInteger)
	colNumbers:		ブランクセルに直交する列における数の配列(SmallInteger)
	set: 			重複を取り除くためのSet
	
	rowOnBoard:		ブランクセルに直交するボード行(SurokuRow)
	rowOnBoard:		ブランクセルに直交するボード列(SurokuColumn)
	"
	| block blankCells blockNumbers rowNumbers colNumbers set |
	1 to: 9 do: [ :n| 
		block := sudokuBoard atBlock: n.
		blankCells := block blankCellsAsArray .
		blockNumbers := block blockA2D asArray select: [ :num| num > 0 ].
		blankCells do: [ :bCell | | rowOnBoard colOnBoard |
			rowOnBoard := (block rowsOnBoard select: [ :row| row rowIndex = bCell rowIndex ]) at: 1.
			rowNumbers := rowOnBoard row select: [ :num | num > 0 ]	.
				
			colOnBoard := (block colsOnBoard select: [ :col| col colIndex = bCell colIndex ]) at: 1.
			colNumbers := colOnBoard column select: [ :num | num > 0 ].
			
			set := ((blockNumbers copyWithAll: rowNumbers ) copyWithAll: colNumbers ) asSet.
			set size = 8
			ifTrue: [ 
				bCell element: 45 - set sum.
				sudokuBoard map: bCell.
			]	
		]		
	]

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

	masumiWay := MasumiWay new: board.
	masumiWay solve; solve.

	board completed .  

"
]
