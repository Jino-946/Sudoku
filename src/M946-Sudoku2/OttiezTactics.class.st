"
おってぃチャンネルで紹介されている数独解法2国同盟を実装するクラス。

[BOXの２ペアを探す2国同盟で数独なんて簡単さ！]( https://www.youtube.com/watch?v=H1aZ7jiz6Yo )
"
Class {
	#name : #OttiezTactics,
	#superclass : #SudokuSolver,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #logic }
OttiezTactics >> columnMarking: aBlock [

	| logger |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	aBlock colsOnBoard do: [ :sudokuColumn |
		(sudokuColumn includes: aBlock verifyNumber) ifTrue: [ 
			| x y cell |
			logger debug: sudokuColumn asSimpleString.
			x := sudokuColumn colIndex .
			y := sudokuColumn indexOf: aBlock verifyNumber.
			logger debug: ('x={1} y={2} verifyNumber={3}' format: {x . y . aBlock verifyNumber}).
			(x = 0 or: [ y = 0 ]) ifTrue: [ self error: 'x = 0 or y = 0' ].
			cell := (sudokuBoard getCellRow: y cellColumn: x) copy.
			"予約セルが入っている場合があるため改めて数をセット"
			cell element: aBlock verifyNumber.
			cell clearPossibleNumbers.
			aBlock markByVerticalCell: cell.
			"
			aBlock blockNumber = 1 ifTrue: [ 
				sudokuBoard  serializeToFileNamed: 'fuel/board-getAlliedCellForMapping.fuel'.
				 ].	
			"
			logger debug: aBlock ]].
]

{ #category : #logic }
OttiezTactics >> fillOneBlankCellOfColumn: column [

	| cell logger |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	logger debug: column asSimpleString .
	column countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	cell := column cellOf: 0.
	cell class = SudokuCell ifFalse: [ ^ self ].
	cell element: (column missingNumbers at: 1).
	sudokuBoard map: cell
]

{ #category : #logic }
OttiezTactics >> fillTwoBlankCellsOfColumn: sudokuColumn [

	| missingNumbers bingo logger  |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	logger debug: sudokuColumn asSimpleString  .
	sudokuColumn countOfReservedBlankCells = 2 ifFalse: [ ^ self ].
	missingNumbers := sudokuColumn missingNumbers.
	bingo := #().
	sudokuColumn column doWithIndex: [ :num :i | | sudokuRow |
		sudokuRow := sudokuBoard getSudokuRow: i.
		(num = 0  or: [num class = SudokuCell ])ifTrue: [  
			bingo := missingNumbers difference: (sudokuRow row intersection: missingNumbers).
			bingo size = 1 ifTrue: [ 
				sudokuColumn at: i put: (bingo at: 1).
				sudokuBoard map: sudokuColumn.
				 self fillOneBlankCellOfColumn: sudokuColumn ]]].

]

{ #category : #logic }
OttiezTactics >> findNextBlock: aBlock pairCells: pairCells [

	| cell cellDirection |
	cell := (pairCells at: 1)  copy.
	cell element: aBlock verifyNumber.
	
	cellDirection := (pairCells at: 1) direction: (pairCells at: 2).
	cellDirection = CellDirection diagonal ifTrue: [ ^self ].
	cellDirection = CellDirection  vertical 
		ifTrue: [
		^ self verticalBlockFinding: aBlock sudokuCell: cell ]
		ifFalse: [
		^ self horizontalBlockFinding: aBlock sudokuCell: cell ]
]

{ #category : #logic }
OttiezTactics >> findNextBlock: aBlock singleCell: cell [

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

{ #category : #logic }
OttiezTactics >> findNextBlock: aBlock trioCells: trioCells [

	| cell |
	cell := (trioCells at: 1) copy.
	cell element: aBlock verifyNumber .
	((trioCells at: 1) x = (trioCells at: 2) x and: [(trioCells at: 2) x = (trioCells at:3 ) x ])
		ifTrue: [ ^ self verticalBlockFinding: aBlock sudokuCell: cell  ].
		
	((trioCells at: 1) y = (trioCells at: 2) y and: [(trioCells at: 2) y = (trioCells at:3 ) y ])
		ifTrue: [ ^ self horizontalBlockFinding: aBlock sudokuCell: cell  ].
	
	
]

{ #category : #logic }
OttiezTactics >> formBilateralAlliance: aBlock [
	"
	2国同盟方式の中核メソッド
	
	対象ブロックのブランクセルについて、検証数字が入らないセルをマークし
	残ったブランクセルが3以下の時に処理する。
	1)ブランクセルが1の時、検証数字が入るセルと確定するのでボードに検証数字をマップし
  	  次の対象ブロックを探し、setAlliance:を再帰呼び出しする。
	2)ブランクセルが2の時、2国同盟と呼びSudokuCellのインスタンスのpossibleNumbersに
 	  検証数字を追加しボードにマップする。
  	  1)の時と同様に次の対象ブロックを探し、setAlliance:を再帰呼び出しする。
  	  対象ブロックの検索方法: ブランクセルが同一行にある時は水平方向に並ぶブロックが対象になり
      ブランクセルが同一列にある時は垂直方向に並ぶブロックが対象となる。
	3)ブランクセルが3の時は、2の時に準じて処理する。
	"
	| blankCells  nextBlock logger |	
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.	
	logger debug: aBlock.
	logger debug: ('block inculudes {1} => {2)' format: { aBlock verifyNumber .(aBlock includes: aBlock verifyNumber)}).
	
	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getAllianceCellsAfterMark: aBlock.
	logger debug: (' blank cells:
{1}' format: {blankCells} ).

	(blankCells size between: 1 and: 3) ifFalse: [ ^self ].
	nextBlock := self.
	blankCells size = 1 ifTrue:[ 
		nextBlock := self getNextBlcokOfSingleBlankCell: aBlock cell: (blankCells at: 1)].
	blankCells size = 2 ifTrue: [ 
		nextBlock := self getNextBlockOfPairBlankCells: aBlock cells: blankCells].
	blankCells size = 3 ifTrue: [ 
		nextBlock := self getNextBlockOfTrioBlankCells: aBlock cells: blankCells ].
	
	nextBlock class = SudokuBlock2 ifTrue: [  
	self formBilateralAlliance: nextBlock]	

]

{ #category : #logic }
OttiezTactics >> getAllianceCellsAfterMark: aBlock [
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
	logger debug: aBlock .
	logger debug: sudokuBoard .
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

{ #category : #logic }
OttiezTactics >> getAlliedCellForMapping: aBlock cell: aCell [

	"
    aBlockの中にaCellの同盟セル(ペアセル)があり、自動的にボードに数が
    配置可能な時はSudokuCellオブジェクとして返す。	
	"
	| cells candidateCell pairNumbers |
	cells := aBlock blockA2D asArray select: [ :item |
						item class = SudokuCell and: [ item ~= aCell ]].
	cells size = 1 ifFalse: [ ^self ].
	candidateCell := cells at: 1.
	pairNumbers := aCell pairNumbers: candidateCell.
	pairNumbers size = 1 ifFalse: [ ^self ].
	candidateCell element: (pairNumbers at: 1).
	^candidateCell clearPossibleNumbers 
]

{ #category : #logic }
OttiezTactics >> getNextBlcokOfSingleBlankCell: aBlock cell: aCell [
	"
	入る数字が決まったセルをsudokuBoardにマップし、
	次の検証対象となるsudokuBlockを返す。
	"
	| nextBlock logger alliedCell |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.	
	aCell element: aBlock verifyNumber.
	alliedCell := self getAlliedCellForMapping: aBlock cell: aCell.
	aCell clearPossibleNumbers .
	logger debug: aCell.
	sudokuBoard map: aCell.
	"
	alliedCell class = SudokuCell ifTrue: [ sudokuBoard map: alliedCell ].
	"
	nextBlock := self findNextBlock: aBlock singleCell: aCell.
	logger debug: 'next block is ....'.
	logger debug: nextBlock.
	^nextBlock.
]

{ #category : #logic }
OttiezTactics >> getNextBlockOfPairBlankCells: aBlock cells: blankCells [
	"
	2国同盟が決まったセルをsudokuBoardにマップし、
	次の検証対象となるsudokuBlockを返す。
	"
	| logger pairCells nextBlock |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	
	pairCells := aBlock get2Allies: blankCells .
	logger debug: pairCells.
	sudokuBoard map: (pairCells at: 1); map: (pairCells at: 2).
	logger debug: sudokuBoard .
	
	nextBlock := self findNextBlock: aBlock pairCells: pairCells .
	logger debug: 'next block is ....'.
	logger debug: nextBlock.
	
	^nextBlock 
]

{ #category : #logic }
OttiezTactics >> getNextBlockOfTrioBlankCells: aBlock cells: blankCells [

	| logger trioCells nextBlock |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	trioCells := aBlock get3Allies: blankCells .
	sudokuBoard map: (trioCells at: 1); map: (trioCells at: 2); map: (trioCells at: 3).
	logger debug: sudokuBoard .
	nextBlock := self findNextBlock: aBlock trioCells: trioCells .
	logger debug: 'next block is ....'.
	logger debug: nextBlock.
	
	^nextBlock 
]

{ #category : #logic }
OttiezTactics >> horizontalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946Logger new: LogLevel debug.
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

{ #category : #logic }
OttiezTactics >> letsRetsme [

	| logger |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	1 to: 9 do: [ :i | | column |
		column := sudokuBoard getSudokuColumn: i.
		logger debug: column asSimpleString .
		column countOfReservedBlankCells = 1 ifTrue:[
			self fillOneBlankCellOfColumn: column.
			].
		column countOfReservedBlankCells = 2 ifTrue: [ 
			self fillTwoBlankCellsOfColumn: column.
			logger debug: column asSimpleString .
			]]

]

{ #category : #logic }
OttiezTactics >> letsRetsme: colNumber [
	"
	letsRetsme  動作検証用メソッド
	"
	| logger column countOfBlankCell |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	column := sudokuBoard getSudokuColumn: colNumber.
	logger debug: column asSimpleString.
	countOfBlankCell := column countOfReservedBlankCells.
	logger debug: ('count of blank cell: {1}' format: { countOfBlankCell  } ).
	countOfBlankCell  = 1 ifTrue: [
		self fillOneBlankCellOfColumn: column.
		column := sudokuBoard getSudokuColumn: colNumber.
		logger debug:
			('count of blank cell: 1 ... {1}' format: { column asSimpleString }) ].
	countOfBlankCell  = 2 ifFalse: [ ^ self ].
	self fillTwoBlankCellsOfColumn: column.
	column := sudokuBoard getSudokuColumn: colNumber.
	logger debug:
		('count of blank cell: 2 ... {1}' format: { column asSimpleString })
]

{ #category : #logic }
OttiezTactics >> rowMarking: aBlock [
	| logger |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	aBlock rowsOnBoard do: [ :sudokuRow |
		(sudokuRow includes: aBlock verifyNumber) ifTrue: [ 
			| x y cell |
			logger debug: sudokuRow asSimpleString .
			x := sudokuRow indexOf: aBlock verifyNumber.
			y := sudokuRow rowIndex .
			logger debug: ('x={1} y={2} verifyNumber={3}' format: {x . y . aBlock verifyNumber}).
			(x = 0 or: [ y = 0 ]) ifTrue: [ self error: 'x = 0 or y = 0' ].
			cell := (sudokuBoard getCellRow: y cellColumn: x) copy.
			"予約セルが入っている場合があるため改めて数をセット"
			cell element: aBlock verifyNumber.
			cell clearPossibleNumbers.
			aBlock markByHorizontalCell: cell.
			logger debug: aBlock]].
]

{ #category : #logic }
OttiezTactics >> verticalBlockFinding: aBlock sudokuCell: cell [

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
