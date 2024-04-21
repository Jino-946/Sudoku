"
ブロッケン方式を用い数独問題を解決する。

ブロッケン方式とは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方①」の実装です。

[使い方]
BlockenWay >> example を参照してください。

"
Class {
	#name : #BlockenWay,
	#superclass : #BasicWay,
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'private - logics' }
BlockenWay >> columnSuji: block [
	"
	当該ブロックに影響を与える他のブロックに検証数値がある時ブランクセルにXを置き目印とする。
		
	#1)ボード列をスキャンし検証数値を探す。
	#2)スキャンしたボード列に検証数値があった時、
	#3)ブロック列のブランクセルにXを配置する。

 	(麻雀用語:スジ)
	"
	block colsOnBoard doWithIndex: [ :col :ci |
		(col includes: block verifyNumber) 
		ifTrue: [ 
			1 to: 3 do: [ :ri|
				(block row: ri column: ci ) = self blankCell
				ifTrue: [ block row: ri column: ci put: $X ]
		 	]
		]
	]
	

]

{ #category : #examples }
BlockenWay >> example [

	| task board blockenWay |
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
	blockenWay := self class new: board.
	blockenWay solve.
	Transcript show: board
]

{ #category : #'private - logics' }
BlockenWay >> rowSuji: block [
	"
	当該ブロックに影響を与える他のブロックに検証数値がある時ブランクセルにXを置き目印とする。
		
	#1)ボード行をスキャンし検証数値を探す。
	#2)スキャンしたボード行に検証数値があった時、
	#3)ブロック行のブランクセルにXを配置する。

 	(麻雀用語:スジ)
	"
	block rowsOnBoard doWithIndex: [ :row :ri|
		(row includes: block verifyNumber) 
		ifTrue: [ 
			1 to: 3 do: [ :ci|
				(block row: ri column: ci ) = self blankCell
				ifTrue: [ block row: ri column: ci put: $X ]
		 	]
		]
	]
]

{ #category : #logic }
BlockenWay >> solve [
	"
	BlockenWay (ブロッ見方式)で解決する。

	ボード上の全てのブロックをブロッケン方式を用いブランクセルを埋める。
    ブロックにブランクセルが一つで残りのセルが数字で埋まっている場合は
    入るべき数字が決まるのでボード上の対応するセルにその数字をセットする。
	"
	| block cell |
	block := nil.
	1 to: 9 do: [ :bNum |
		1 to: 9 do: [ :vNum |
			block := SudokuBlock2 sudokuBoard: sudokuBoard blockNumber: bNum verifyNumber: vNum.
			block includesVerifyNumber 
			ifFalse: [  
				cell := self sujiYomi: block.
				block completed ifFalse: [ 
               	cell class = SudokuCell
                	ifTrue: [sudokuBoard map: cell]
             	] 
			]
        ] .
		"ブロッケン方式実行した結果を反映したsudokuBoardより新なblockを生成する"
		block := SudokuBlock2 sudokuBoard: sudokuBoard  blockNumber: bNum verifyNumber: 0.
		cell := block tsumo.
		cell class = SudokuCell 
		ifTrue: [ sudokuBoard map: cell ]
    ].


]

{ #category : #'private - logics' }
BlockenWay >> sujiYomi: block [
	"
 	対象となる他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印にしている。
 	rowSuji:とcolumnSuji:を利用して検証数値が重複するブロックのセルにXを配置する。
 	ブロックにブランクセルが一つだけの時は、ブランクセルのボード座標と検証数値をSudokuCellにマップし返す。
  	(麻雀用語:スジ)	
	"
	| cell |
	
	self rowSuji: block.
	self columnSuji: block.
	cell := block tenpai.
	cell class = SudokuCell 
	ifFalse: [ ^self ].
	
	cell element: block verifyNumber .
	^ cell.
	
	
	

]
