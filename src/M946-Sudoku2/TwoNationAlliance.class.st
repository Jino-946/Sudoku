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

	| blankCells pairCell1 pairCell2 |	
	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getBlankCellsAfterMark: aBlock.
	blankCells size = 1 ifTrue:[ 
		(blankCells at: 1) element: aBlock verifyNumber.
		sudokuBoard map: (blankCells at: 1).
		^self
	].
	blankCells size = 2 ifFalse: [ ^self ].

	pairCell1 := aBlock	x: (aBlock localX: (blankCells at: 1) colIndex)
							y: (aBlock localY: (blankCells at: 1) rowIndex)
							putPairCell: blankCells.
	pairCell2 := aBlock	x: (aBlock localX: (blankCells at: 2) colIndex)
							y: (aBlock localY: (blankCells at: 2) rowIndex)
							putPairCell: blankCells.
	sudokuBoard map: pairCell1 ; map: pairCell2 .
	"
	上級問題でこのような条件に遭遇することはレアケース,このレアな機会を適切に使っていく
	のが数独解法のテクニックかもしれない
	setAlliance をうまく利用し再帰呼び出し処理するべきかな
	"

]
