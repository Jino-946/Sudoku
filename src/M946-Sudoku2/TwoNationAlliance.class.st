"
おってぃチャンネルで紹介されている数独解法2国同盟を実装するクラス。

[BOXの２ペアを探す2国同盟で数独なんて簡単さ！]( https://www.youtube.com/watch?v=H1aZ7jiz6Yo )
"
Class {
	#name : #TwoNationAlliance,
	#superclass : #SudokuSolver,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'as yet unclassified' }
TwoNationAlliance >> columnMarking: aBlock [

	aBlock colsOnBoard do: [ :sudokuColumn |
		(sudokuColumn includes: aBlock verifyNumber) ifTrue: [ 
			| x y cell |
			x := sudokuColumn colIndex .
			y := sudokuColumn indexOf: aBlock verifyNumber.
			cell := sudokuBoard getCellRow: y cellColumn: x.
			aBlock markByVerticalCell: cell.]].
]

{ #category : #'as yet unclassified' }
TwoNationAlliance >> getBlankCellsAfterMark: aBlock [
	"
	aBlockの中での2国同盟を探す
	"
	self rowMarking: aBlock.
	self columnMarking: aBlock.
	
	^aBlock blankCellsAsArray .



	
	
	
]

{ #category : #'as yet unclassified' }
TwoNationAlliance >> rowMarking: aBlock [

	aBlock rowsOnBoard do: [ :sudokuRow |
		(sudokuRow includes: aBlock verifyNumber) ifTrue: [ 
			| x y cell |
			x := sudokuRow indexOf: aBlock verifyNumber.
			y := sudokuRow rowIndex .
			cell := sudokuBoard getCellRow: y cellColumn: x.
			aBlock markByHorizontalCell: cell.]].
]

{ #category : #initialization }
TwoNationAlliance >> setAlliance: aBlock [

	| blankCells x1 y1 x2 y2 pairCell1 pairCell2 |
	blankCells := self getBlankCellsAfterMark: aBlock.
	x1 := aBlock localX: (blankCells at: 1) colIndex.
	y1 := aBlock localY: (blankCells at: 1) rowIndex.
	x2 := aBlock localX: (blankCells at: 2) colIndex.
	y2 := aBlock localY: (blankCells at: 2) rowIndex.

	pairCell1 := aBlock x: x1 y: y1 putPairCell: blankCells.
	pairCell2 := aBlock x: x2 y: y2 putPairCell: blankCells.
	
	sudokuBoard map: pairCell1 ; map: pairCell2 .
	
]
