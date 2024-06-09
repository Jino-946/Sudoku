"
タテ３列「2コ2コチェック」テクニックを実装する。

[初級問題の解き方](http://daddy-number-place.blog.jp/syokyu1.pdf)
"
Class {
	#name : #TateNicoMethod,
	#superclass : #DaddyNumPreMethod,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'private - logics' }
TateNicoMethod >> nicoCells: targetBlockNumber number: anInteger [
	"
	検証するブロックに垂直方向に関連する2つのブロックで重複する数字のセルをSudokuCellに変換し配列にして返す。
	予め[nicoCheck:]を利用し同じ数字(anInteger)が2コあるものを見つけておく。
	"
	| blockNumbers block1 block2 cells |
	cells := Array new: 2.
	blockNumbers := self relatedVertBlocks  at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (blockNumbers at: 1).
	block2 := sudokuBoard atBlock: (blockNumbers at: 2).
	
	cells at: 1 put: (block1 cellOf: anInteger).
	cells at: 2 put: (block2 cellOf: anInteger).
	^cells

]

{ #category : #'private - logics' }
TateNicoMethod >> nicoCheck: targetBlockNumber [
	"
	検証するブロックに垂直方向に関連する2つのブロックのどちらにもある数字を配列にして返す。
	返された数字を TateNicoMethod>>nicoCells:number: の引数として使用する。
	垂直方向に関連するブロックとは 1->(4 7), 4->(1 7), 7->(1 4) など9通りあり、
    SudokuSolver>>initializeの中でrelatedVertBlocks<Dictionary>として初期化されている。    
	"
	| values block1 block2 |
	values := self relatedVertBlocks  at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (values at: 1).
	block2 := sudokuBoard atBlock: (values at: 2).
	
	^(block1 asArray select: [ :n | n > 0] ) intersection: (block2 asArray select: [ :n | n > 0])
]

{ #category : #logic }
TateNicoMethod >> solve [

	1 to: 9 do: [ :blockNumber |
		self targetBlock: blockNumber ]
]

{ #category : #logic }
TateNicoMethod >> targetBlock: blockNumber [

	(self nicoCheck: blockNumber) do: [ :n | | block |
		block := self sudokuBoard atBlock: blockNumber.
		(self nicoCells: blockNumber  number: n) do: [ :cell |
			block markByVerticalCell: cell ].

		block markByNumberToMark: n.
		
		(block blankCellsAsArray size = 1) ifTrue: [ 
			self finishBlock: block number: n ]]	
		
		" todo: ブランクセルが2つの時『2国同盟』の処理を追加する"
]
