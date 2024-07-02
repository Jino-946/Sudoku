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

	|  sudokuCell |
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
	logger := M946Logger new: LogLevel info.
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
TwoNationAlliance >> getAllianceCellsAfterMark: aBlock [
	"
	aBlockの中での2国同盟,3国同盟を探す。
	ブランクセルが1つの時、またはブランクセルが2つあるいは3つ
	で垂直方向または水平方向にブランクセルが並んでいる時、
	セルの配列を返す。
	"
	| logger blankCells |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	self rowMarking: aBlock.
	self columnMarking: aBlock.
	blankCells := aBlock blankCellsAsArray .
	blankCells size = 1 ifTrue: [ ^blankCells ].
	blankCells size = 2 ifTrue: [ ((blankCells at: 1) x = (blankCells at: 2) x
										or: [(blankCells at: 1) y = (blankCells at: 2) y])
											ifTrue: [ ^blankCells ]].
	blankCells size = 3 ifTrue: [ ((blankCells at: 1) x = (blankCells at: 2) x 	
											and: [ (blankCells at: 2) x = (blankCells at: 3) x])
										ifTrue:[^blankCells].
									 ((blankCells at: 1) y = (blankCells at: 2) y 
											and: [ (blankCells at: 2) y = (blankCells at: 3) y])
										ifTrue:[^blankCells]].
	^#()
		


	
	
	
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
	logger debug: ('block inculudes {1} => {2)' format: { aBlock verifyNumber .(aBlock includes: aBlock verifyNumber)}).
	
	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getAllianceCellsAfterMark: aBlock.

	blankCells size = 1 ifTrue:[ 
		logger debug: 'block has one blank cell.'.
		
		(blankCells at: 1) element: aBlock verifyNumber.
		sudokuBoard map: (blankCells at: 1).
		nextBlock := self findNextBlock: aBlock singleCell: (blankCells at: 1).
		
		logger debug: 'next block is ...'.
		logger debug: nextBlock .
		
		nextBlock class = SudokuBlock2 ifTrue: [ 
			self setAlliance: nextBlock.
			^self]].
	blankCells size = 2 ifFalse: [ ^self ].
	pairCells := aBlock getPairCells: blankCells.
	sudokuBoard map: (pairCells at: 1); map: (pairCells at: 2).
	
	logger debug: 'block has two blank cells.'.
	
	nextBlock := self findNextBlock: aBlock pairCell: (pairCells at: 1) .
	
	logger debug: 'next block is....'.
	logger debug: nextBlock.
	
	nextBlock class = SudokuBlock2 ifTrue: [  
		self setAlliance: nextBlock]
]

{ #category : #initialization }
TwoNationAlliance >> setAllianceForTest: aBlock [

	| blankCells pairCell1 pairCell2  |	
	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getAllianceCellsAfterMark: aBlock.
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
	logger := M946Logger new: LogLevel info.
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
