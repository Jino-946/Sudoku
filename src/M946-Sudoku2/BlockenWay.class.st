Class {
	#name : #BlockenWay,
	#superclass : #BasicWay,
	#category : #'M946-Sudoku2-Core'
}

{ #category : #logic }
BlockenWay >> columnSuji: block [

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

{ #category : #logic }
BlockenWay >> rowSuji: block [

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
BlockenWay >> sujiYomi: block [
	"
 	対象となる他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印にしている。
 	rowSuji:とcolumnSuji:を利用して検証数値が重複するブロックのセルにXを配置する。
 	ブロックにブランクセルが一つだけの時は、ボードのセルに検証数値を配置する。
  	(麻雀用語:スジ)	
	"
	| cell |
	(block blockA2D asArray includes: block verifyNumber)
	ifTrue: [ ^self ].
	
	self rowSuji: block.
	self columnSuji: block.
	cell := block tenpai.
	cell class = SudokuCell 
	ifFalse: [ ^self ].
	
	cell element: block verifyNumber .
	sudokuBoard map: cell.
	
	
	

]
