"
タテ３列「2コ2コチェック」テクニックを実装する。
"
Class {
	#name : #TateNicoCheckMethod,
	#superclass : #DaddyNumPreMethod,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'private - logics' }
TateNicoCheckMethod >> nicoCells: targetBlockNumber number: anInteger [
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
TateNicoCheckMethod >> nicoCheck: targetBlockNumber [
	"
	検証するブロックに垂直方向に関連する2つのブロックで重複する数字の配列を返す。
	返された配列の数字を[nicoCells:number:]numberの引数として使用する
	"
	| values block1 block2 |
	values := self relatedVertBlocks  at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (values at: 1).
	block2 := sudokuBoard atBlock: (values at: 2).
	
	^(block1 asArray select: [ :n | n > 0] ) intersection: (block2 asArray select: [ :n | n > 0])
]

{ #category : #logic }
TateNicoCheckMethod >> targetBlock: blockNumber [

	| nicoNumbers |
	nicoNumbers := self nicoCheck: blockNumber.
	nicoNumbers do: [ :n | | block tenpaiCell |
		block := self sudokuBoard atBlock: blockNumber.
		(self nicoCells: blockNumber  number: n) do: [ :cell |
			block markByVerticalCell: cell ].
		block markByNumberToMark: n.
		
		tenpaiCell := block tenpai.	
		(tenpaiCell class = SudokuCell) ifTrue: [ | tsumoCell |
			tsumoCell := block allGreen.
			(tsumoCell class = SudokuCell) 
				ifTrue: [ sudokuBoard map: tsumoCell ]
				ifFalse: [  
					tenpaiCell element: n.
					sudokuBoard map: tenpaiCell.] ]]
	
]
