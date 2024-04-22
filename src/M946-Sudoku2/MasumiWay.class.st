"
マスミ方式を用い数独問題を解決する。

MasumiWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方③」の実装です。

"
Class {
	#name : #MasumiWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Core'
}

{ #category : #logic }
MasumiWay >> solve [

	| block |
	1 to: 9 do: [ :n| | blankCells blockNumbers rowNumbers colNumbers set |
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
]
