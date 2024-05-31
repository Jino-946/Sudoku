Class {
	#name : #YokoNicoCheckMethod,
	#superclass : #DaddyNumPreMethod,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'as yet unclassified' }
YokoNicoCheckMethod >> nicoCells: targetBlockNumber number: anInteger [

	| blockNumbers block1 block2 cells |
	cells := Array new: 2.
	blockNumbers := relatedHorBlocks at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (blockNumbers at: 1).
	block2 := sudokuBoard atBlock: (blockNumbers at: 2).
	
	cells at: 1 put: (block1 cellOf: anInteger).
	cells at: 2 put: (block2 cellOf: anInteger).
	^cells

]

{ #category : #'as yet unclassified' }
YokoNicoCheckMethod >> nicoCheck: targetBlockNumber [

	| values block1 block2 |
	values := relatedHorBlocks at: targetBlockNumber .
	block1 := sudokuBoard atBlock: (values at: 1).
	block2 := sudokuBoard atBlock: (values at: 2).
	
	^(block1 asArray select: [ :n | n > 0] ) intersection: (block2 asArray select: [ :n | n > 0])
]

{ #category : #'as yet unclassified' }
YokoNicoCheckMethod >> targetBlock: blockNumber [

	| targetBlock |
	targetBlock := sudokuBoard atBlock: blockNumber.
	
]
