"
ヨコ３列「2コ2コチェック」テクニックを実装する。

[初級問題の解き方](http://daddy-number-place.blog.jp/syokyu1.pdf)

"
Class {
	#name : #YokoNicoMethod,
	#superclass : #DaddyNumPreMethod,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'private - logics' }
YokoNicoMethod >> nicoCells: targetBlockNumber number: anInteger [
	"
	検証するブロックに水平方向に関連する2つのブロックで重複する数字のセルをSudokuCellに変換し配列にして返す。
	予め[nicoCheck:]を利用し同じ数字(anInteger)が2コあるものを見つけておく。
	"
	| blockNumbers block1 block2 cells |
	cells := Array new: 2.
	blockNumbers := self relatedHorBlocks at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (blockNumbers at: 1).
	block2 := sudokuBoard atBlock: (blockNumbers at: 2).
	
	cells at: 1 put: (block1 cellOf: anInteger).
	cells at: 2 put: (block2 cellOf: anInteger).
	^cells

]

{ #category : #'private - logics' }
YokoNicoMethod >> nicoCheck: targetBlockNumber [
	"
	検証するブロックに水平方向に関連する2つのブロックのどちらにもある数字を配列にして返す。
	返された数字を YokoNicoMethod>>nicoCells:number: の引数として使用する。
	水平方向に関連するブロックとは 1->(2 3), 2->(1 3), 3->(1 2) など9通りあり、
    SudokuSolver>>initializeの中でrelatedHorBlocks<Dictionary>として初期化されている。    
	"
	| values block1 block2  |
	values := self relatedHorBlocks at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (values at: 1).
	block2 := sudokuBoard atBlock: (values at: 2).
	
	^(block1 asArray select: [ :n | n > 0] ) intersection: (block2 asArray select: [ :n | n > 0]).

]

{ #category : #logic }
YokoNicoMethod >> solve [

	1 to: 9 do: [ :blockNumber | self targetBlock: blockNumber  ]
]

{ #category : #logic }
YokoNicoMethod >> targetBlock: blockNumber [

	(self nicoCheck: blockNumber) do: [ :n | | block |
		block := self sudokuBoard atBlock: blockNumber.
		(self nicoCells: blockNumber  number: n) do: [ :cell |
			block markByHorizontalCell: cell ].

		block markByNumberToMark: n.
		
		(block blankCellsAsArray size = 1) ifTrue: [ 
			self finishBlock: block number: n ].
			^self ].
		
		" todo: ブランクセルが2つの時『2国同盟』の処理を追加する
		^block はどうだろう?
		"
]
