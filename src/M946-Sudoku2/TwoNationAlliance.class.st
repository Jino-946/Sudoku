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
TwoNationAlliance >> findNextBlock: aBlock pairCell: aPairCell [

	|  logger sudokuCell |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	
	sudokuCell := aPairCell thisCell copy.
	sudokuCell element: aBlock verifyNumber.
	aPairCell isVertical 
		ifTrue: [ 
			^self verticalBlockFinding: aBlock sudokuCell: sudokuCell]
		ifFalse: [ 
			^self horizontalBlockFinding: aBlock sudokuCell: sudokuCell]

		
			
	
	
	
	

	

]

{ #category : #'as yet unclassified' }
TwoNationAlliance >> findNextBlock: aBlock singleCell: cell [

	| logger resultBlock |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	resultBlock := self horizontalBlockFinding: aBlock sudokuCell: cell.
	resultBlock class = SudokuBlock2 ifTrue: [
		logger debug: 'horizontal block finding'.
		resultBlock verifyNumber: aBlock verifyNumber.
		^ resultBlock ].
	resultBlock := self verticalBlockFinding: aBlock sudokuCell: cell.
	resultBlock class = SudokuBlock2 ifFalse: [ ^ self ].
	logger debug: 'vertical block finding'.
	resultBlock verifyNumber: aBlock verifyNumber.
	^ resultBlock
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
TwoNationAlliance >> horizontalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946Logger new: LogLevel info.
	logger debug: thisContext.
	bNumber1 := (self relatedHorBlocks at: aBlock blockNumber) at: 1.
	bNumber2 := (self relatedHorBlocks at: aBlock blockNumber) at: 2.
	block1 := sudokuBoard
		          getBlock: bNumber1
		          verifyNumber: aBlock verifyNumber.
	block2 := sudokuBoard
		          getBlock: bNumber2
		          verifyNumber: aBlock verifyNumber.
	(block1 includes: aBlock verifyNumber) ifFalse: [
		block1 markByHorizontalCell: cell.
		^ block1 ].

	(block2 includes: aBlock verifyNumber) ifTrue: [ ^ self ].
	block2 markByHorizontalCell: cell.
	^ block2
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

	| blankCells pairCells nextBlock logger |	
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.	
	logger debug: aBlock.
	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getBlankCellsAfterMark: aBlock.
	logger debug: aBlock .
	blankCells size = 1 ifTrue:[ 
		(blankCells at: 1) element: aBlock verifyNumber.
		sudokuBoard map: (blankCells at: 1).
		nextBlock := self findNextBlock: aBlock singleCell: (blankCells at: 1).
		logger debug: nextBlock .
		nextBlock class = SudokuBlock2 ifTrue: [ 
			self setAlliance: nextBlock.
			^self]].
	blankCells size = 2 ifFalse: [ ^self ].
	pairCells := aBlock getPairCells: blankCells.
	sudokuBoard map: (pairCells at: 1); map: (pairCells at: 2).
	
	"
	pairCell1 := aBlock	x: (aBlock localX: (blankCells at: 1) colIndex)
							y: (aBlock localY: (blankCells at: 1) rowIndex)
							putPairCell: blankCells.
	pairCell2 := aBlock	x: (aBlock localX: (blankCells at: 2) colIndex)
							y: (aBlock localY: (blankCells at: 2) rowIndex)
							putPairCell: blankCells.
	sudokuBoard map: pairCell1 ; map: pairCell2 .
	"
	"
	上級問題でこのような条件が成立する場面に遭遇することはレアケース,このレアな機会を適切に使っていく
	のが数独解法のテクニックかもしれない
	setAlliance をうまく利用し再帰呼び出し処理するべきかな
	"
	nextBlock := self findNextBlock: aBlock pairCell: (pairCells at: 1) .
	nextBlock class = SudokuBlock2 ifTrue: [  
		self setAlliance: nextBlock]
]

{ #category : #initialization }
TwoNationAlliance >> setAllianceForTest: aBlock [

	| blankCells pairCell1 pairCell2  |	
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
	^pairCell1 
	
	
]

{ #category : #'as yet unclassified' }
TwoNationAlliance >> verticalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	bNumber1 := (self relatedVertBlocks at: aBlock blockNumber) at: 1.
	bNumber2 := (self relatedVertBlocks at: aBlock blockNumber) at: 2.
	block1 := sudokuBoard
		          getBlock: bNumber1
		          verifyNumber: aBlock verifyNumber.
	block2 := sudokuBoard
		          getBlock: bNumber2
		          verifyNumber: aBlock verifyNumber.
	(block1 includes: aBlock verifyNumber) ifFalse: [
		block1 markByVerticalCell: cell.
		logger debug: cell.
		^ block1 ].
	(block2 includes: aBlock verifyNumber) ifTrue: [ ^ self ].
	block2 markByVerticalCell: cell.
	^ block2
]
