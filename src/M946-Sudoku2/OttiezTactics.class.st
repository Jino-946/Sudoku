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
OttiezTactics >> checkBlockTenpai: aBlock [

	| reloadBlock tsumoCell |
	reloadBlock := sudokuBoard
		               getBlock: aBlock blockNumber
		               verifyNumber: aBlock verifyNumber.
	reloadBlock countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	tsumoCell := reloadBlock allGreen.
	tsumoCell class = SudokuCell ifTrue: [ sudokuBoard map: tsumoCell ]
]

{ #category : #logic }
OttiezTactics >> checkColumnTenpai: aCell [

	| column tsumoCell |
	column := sudokuBoard getSudokuColumn: aCell colIndex.

	column countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	tsumoCell := column tsumo.
	tsumoCell class = SudokuCell ifTrue: [ sudokuBoard map: tsumoCell ].
	^ self
]

{ #category : #logic }
OttiezTactics >> checkForTwoPairs: aBlock [ 

	| reloadBlock twoPairs  blankCells |
	reloadBlock := sudokuBoard getBlock:  (aBlock blockNumber) verifyNumber: (aBlock verifyNumber).
	twoPairs := reloadBlock blockA2D asArray select: [ :item |
		item class = SudokuCell and: [ item possibleNumbers isNotEmpty ]].
	twoPairs size = 2 ifFalse: [ ^self ].	
	((twoPairs at: 1) possibleNumbers size = 2 and: [(twoPairs at: 2) possibleNumbers size = 2 ])
		ifFalse: [ ^self ].
	(twoPairs at: 1) possibleNumbers asBag = (twoPairs at: 2) possibleNumbers asBag 
		ifFalse: [ ^self ].
	blankCells := aBlock blankCellsAsArray .
	^(blankCells select: [ :cell | cell ~= (twoPairs at: 1) ]) select: [ :cell | cell ~=  (twoPairs at: 2) ]
]

{ #category : #logic }
OttiezTactics >> checkRowTenpai: aCell [

	| row tsumoCell |
	row := sudokuBoard getSudokuRow: aCell colIndex.

	row countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	tsumoCell := row tsumo.
	tsumoCell class = SudokuCell ifTrue: [ sudokuBoard map: tsumoCell ].
	^ self
]

{ #category : #logic }
OttiezTactics >> checkTenpai: aBlock cell: aCell [

	self checkBlockTenpai: aBlock.
	self checkTwoPairsTenpai: aBlock .
	self checkColumnTenpai: aCell.
	self checkRowTenpai: aCell.
]

{ #category : #logic }
OttiezTactics >> checkTwoPairsTenpai: aBlock [

	| reloadBlock tsumoCell  |
	reloadBlock := sudokuBoard
		               getBlock: aBlock blockNumber
		               verifyNumber: aBlock verifyNumber.
	tsumoCell := reloadBlock twoPairsTenpai .
	tsumoCell class = SudokuCell ifTrue: [ sudokuBoard map: tsumoCell ]
]

{ #category : #logic }
OttiezTactics >> columnMarking: aBlock [

	aBlock colsOnBoard do: [ :sudokuColumn |
		(sudokuColumn includes: aBlock verifyNumber) ifTrue: [ 
			| x y cell |
			x := sudokuColumn colIndex .
			y := sudokuColumn indexOf: aBlock verifyNumber.
			(x = 0 or: [ y = 0 ]) ifTrue: [ self error: 'x = 0 or y = 0' ].
			cell := (sudokuBoard getCellRow: y cellColumn: x) copy.
			cell blockNumber = aBlock blockNumber ifFalse: [  
				cell element: aBlock verifyNumber.
				cell clearPossibleNumbers.
				aBlock markByVerticalCell: cell]]].
]

{ #category : #logic }
OttiezTactics >> fillOneBlankCellOfColumn: column [

	| cell |
	column countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	cell := column cellOf: 0.
	cell class = SudokuCell ifFalse: [ ^ self ].
	cell element: (column missingNumbers at: 1).
	sudokuBoard map: cell
]

{ #category : #logic }
OttiezTactics >> fillTwoBlankCellsOfColumn: sudokuColumn [

	| missingNumbers bingo |
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

	| cell cellDirection logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
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

	| resultBlock |
	resultBlock := self horizontalBlockFinding: aBlock sudokuCell: cell.
	resultBlock class = SudokuBlock2 ifTrue: [
		resultBlock verifyNumber: aBlock verifyNumber.
		^ resultBlock ].
	resultBlock := self verticalBlockFinding: aBlock sudokuCell: cell.
	resultBlock class = SudokuBlock2 ifFalse: [ ^ self ].
	resultBlock verifyNumber: aBlock verifyNumber.
	^ resultBlock
]

{ #category : #logic }
OttiezTactics >> findNextBlock: aBlock trioCells: trioCells [

	| cell logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	logger debug: aBlock.
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
  	  次の対象ブロックを探し、formBilateralAlliance:を再帰呼び出しする。
	2)ブランクセルが2の時、2国同盟と呼びSudokuCellのインスタンスのpossibleNumbersに
 	  検証数字を追加しボードにマップする。
  	  1)の時と同様に次の対象ブロックを探し、formBilateralAlliance:を再帰呼び出しする。
  	  対象ブロックの検索方法: ブランクセルが同一行にある時は水平方向に並ぶブロックが対象になり
      ブランクセルが同一列にある時は垂直方向に並ぶブロックが対象となる。
	3)ブランクセルが3の時は、2の時に準じて処理する。
	"
	| blankCells  nextBlock  checkResult logger |	
	logger := M946FileLogger new.
	logger debug: thisContext.
	
	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getAllianceCellsAfterMark: aBlock.
	logger debug: ('blankCells => {1}' format:{blankCells}).
	
	checkResult := self checkForTwoPairs: aBlock.
	logger debug: ('checkResult => {1}' format:{checkResult}).
	
	checkResult = self ifFalse: [ blankCells := checkResult ].
	(blankCells size between: 1 and: 3) ifFalse: [ 
		sudokuBoard clearMarks .
		^self ].  
	nextBlock := self.
	blankCells size = 1 ifTrue:[ 
		nextBlock := self getNextBlockOfSingleBlankCell: aBlock cell: (blankCells at: 1)].
	blankCells size = 2 ifTrue: [ 
		nextBlock := self getNextBlockOfPairBlankCells: aBlock cells: blankCells].
	blankCells size = 3 ifTrue: [ 
		nextBlock := self getNextBlockOfTrioBlankCells: aBlock cells: blankCells ].
	logger trace: sudokuBoard .
	logger debug: ('nextBlock => {1}' format: {nextBlock}).
	sudokuBoard clearMarks .
	logger trace: sudokuBoard .
	nextBlock class = SudokuBlock2 
		ifTrue: [self formBilateralAlliance: nextBlock]	
		"ifFalse: [sudokuBoard clearMarks]"

]

{ #category : #logic }
OttiezTactics >> getAllianceCellsAfterMark: aBlock [
	"
	aBlockの中での2国同盟,3国同盟を探す。
	ブランクセルが1つの時、またはブランクセルが2つあるいは3つ
	で垂直方向または水平方向にブランクセルが並んでいる時、
	セルの配列を返す。
	"
	| blankCells logger |
	logger := M946FileLogger new.
	logger debug: thisContext.

	self rowMarking: aBlock.
	self columnMarking: aBlock.
	blankCells := aBlock blankCellsAsArray .
	logger debug: aBlock.
	logger debug: blankCells.
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
OttiezTactics >> getAlliedCellForMapping: aBlock cell: thisCell [
	"
	aBlockの中にaCellの同盟セル(ペアセル)があり、自動的にボードに数が
    配置可能な時にSudokuCellオブジェクトの配列として返す。	
	但し.非対称ペアセルの場合は getAlliedCellForMappingNoPairNumber:cell: の中でボードに
	マッピングするのでSudokuCellオブジェクトの配列は返さない。
	"
	| cells  |
	(thisCell possibleNumbers includes: thisCell element)
		ifTrue: [  
			cells := aBlock blockA2D asArray select: [ :item |
				item class = SudokuCell and: [ 
					(item notSameCoordinates: thisCell) and:[
						(item possibleNumbers intersection: thisCell possibleNumbers ) isNotEmpty]]].	
			^cells]
		ifFalse: [ 
			self getAlliedCellForMappingNoPairNumber: aBlock cell: thisCell]
	
]

{ #category : #logic }
OttiezTactics >> getAlliedCellForMappingNoPairNumber: aBlock cell: thisCell [
	"
	aBlockの中にaCellの非対称ペアナンバー(ペアセル)があり、自動的にボードに数が
    配置可能な時にsudokuBoard にマップする。
	ただしthisCellに入ることが確定した数字はペア数字以外の数字
	"
	| cells  |
	cells := aBlock blockA2D asOrderedCollection select: [ :item |
				item class = SudokuCell and: [ item notSameCoordinates: thisCell]].
	thisCell possibleNumbers size = 1 
		ifTrue: [  
			cells sort: [ :a :b | a possibleNumbers size > b possibleNumbers size ].
			((cells at: 1) possibleNumbers includes: (thisCell possibleNumbers at: 1))
				ifTrue: [ 
					(cells at: 1) element: (thisCell possibleNumbers at: 1).
					((cells at: 1) possibleNumbers intersection: (cells at: 2) possibleNumbers) isNotEmpty
						and: [ (cells at: 2) possibleNumbers size = 1
							ifTrue: [ 
								(cells at: 2) element: ((cells at: 2) possibleNumbers at: 1).
								(cells at: 1) clearPossibleNumbers .
								(cells at: 2) clearPossibleNumbers.
								sudokuBoard map: (cells at:1);map: (cells at: 2)]]]]
		ifFalse:[
			thisCell possibleNumbers size = 2
				ifTrue: [ 
					(thisCell possibleNumbers intersection: (cells at: 1) possibleNumbers ) isNotEmpty 
						and: [ (cells at: 1) possibleNumbers size = 1
							ifTrue: [ 
								(cells at: 1) element: ((cells at: 1) possibleNumbers at: 1).
								(cells at: 1) clearPossibleNumbers.
								sudokuBoard map: (cells at: 1)]].
					(thisCell possibleNumbers intersection: (cells at: 2) possibleNumbers ) isNotEmpty 
						and: [ (cells at: 2) possibleNumbers size = 1
							ifTrue: [ 
								(cells at: 2) element: ((cells at: 2) possibleNumbers at: 1).
								(cells at: 2) clearPossibleNumbers. 
								sudokuBoard map: (cells at: 2)]]]].

]

{ #category : #logic }
OttiezTactics >> getNextBlockOfAsymmetricPair: aBlock thisCell: thisCell cells: otherCells [
	"

	次の検証対象となるsudokuBlockを返す。
	"
	| nextBlock alliedCell logger |
	logger := M946FileLogger new.
	logger debug: thisContext.

	alliedCell := nil.
	otherCells do: [ :otherCell |
		otherCell class = SudokuCell ifTrue: [ 
			"ペアセルに入る数を確定する"
			alliedCell := (BilateralAlliance thisCell: thisCell  otherCell: otherCell) determineTheNumber ].
			alliedCell class = SudokuCell ifTrue: [ sudokuBoard map: alliedCell ]].
	thisCell clearPossibleNumbers .
	sudokuBoard map: thisCell.
	self checkTenpai: aBlock cell: thisCell.
	nextBlock := self findNextBlock: aBlock singleCell: thisCell.
	logger debug: nextBlock.
	^nextBlock.
]

{ #category : #logic }
OttiezTactics >> getNextBlockOfPairBlankCells: aBlock cells: blankCells [
	"
	2国同盟が決まったセルをsudokuBoardにマップし、
	次の検証対象となるsudokuBlockを返す。
	"
	|  pairCells nextBlock logger|	
	logger := M946FileLogger new.
	logger debug: thisContext.
	pairCells := aBlock get2Allies: blankCells .
	sudokuBoard map: (pairCells at: 1); map: (pairCells at: 2).
	self checkBlockTenpai: aBlock.
	nextBlock := self findNextBlock: aBlock pairCells: pairCells .
	
	^nextBlock 
]

{ #category : #logic }
OttiezTactics >> getNextBlockOfSingleBlankCell: aBlock cell: aCell [
	"
	入る数字が決まったセルをsudokuBoardにマップする。
	1)入る数字が決まったセルが2国同盟で、かつもう一方のセルに入る数が
      決まった時はsudokuBoardにマップする。
    2)入る数字が決まったセルが非対称ペアで、getNextBlockOfAsymmetricPair:thisCell:cells: により
      セルに入る数が決まった時はsudokuBoardにマップする。
	次の検証対象となるsudokuBlockを返す。
	"
	| nextBlock  alliedCell otherCells actualBlock logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	aCell element: aBlock verifyNumber.
	"現在のsudokuBoardのブロックを再取得する"
	actualBlock := sudokuBoard getBlock: (aBlock blockNumber) verifyNumber: (aBlock verifyNumber) .
	"ペアセル取得"
	otherCells  := self getAlliedCellForMapping: actualBlock  cell: aCell.
	logger debug: ('pairCells => {1}' format: {otherCells}) .
	(otherCells class = Array and: [ otherCells size = 2 ]) ifTrue: [ 
		nextBlock := self getNextBlockOfAsymmetricPair: aBlock thisCell: aCell cells: otherCells.
		nextBlock class = SudokuBlock2 ifTrue: [ ^nextBlock ]
	].	
	alliedCell := nil.
	(otherCells class = Array and:[ 
		otherCells size = 1 and: [
			 (otherCells at: 1) class = SudokuCell]]) ifTrue: [ 
		"ペアセルに入る数を確定する"
		alliedCell := (BilateralAlliance thisCell: aCell otherCell: (otherCells at: 1)) determineTheNumber ].
		alliedCell class = SudokuCell ifTrue: [ sudokuBoard map: alliedCell ].
	aCell clearPossibleNumbers .
	sudokuBoard map: aCell.
	self checkTenpai: aBlock cell: aCell.
	nextBlock := self findNextBlock: aBlock singleCell: aCell.
	^nextBlock.
]

{ #category : #logic }
OttiezTactics >> getNextBlockOfTrioBlankCells: aBlock cells: blankCells [
	"
	トリオセルはSudokuBoardにマップはせず、次の対象ブロックの検索にのみ使用する。
	"
	|  trioCells nextBlock logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	trioCells := aBlock get3Allies: blankCells . 
	logger debug: ('trioCells => 
{1}' format: {trioCells}).
	nextBlock := self findNextBlock: aBlock trioCells: trioCells .
	
	^nextBlock 
]

{ #category : #logic }
OttiezTactics >> horizontalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	bNumber1 := (self relatedHorBlocks at: aBlock blockNumber) at: 1.
	bNumber2 := (self relatedHorBlocks at: aBlock blockNumber) at: 2.
	block1 := sudokuBoard
		          getBlock: bNumber1
		          verifyNumber: aBlock verifyNumber.
	block2 := sudokuBoard
		          getBlock: bNumber2
		          verifyNumber: aBlock verifyNumber.
	(block1 includes: aBlock verifyNumber) 
		ifFalse: [
			^self horizontalBlockMarking: block1  sudokuCell: cell].

	(block2 includes: aBlock verifyNumber) 
		ifFalse: [
			^self horizontalBlockMarking: block2  sudokuCell: cell ].
	^self
]

{ #category : #logic }
OttiezTactics >> horizontalBlockMarking: aBlock sudokuCell: cell [

	| markedPoints copyBlock logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	copyBlock := aBlock deepCopy.
	markedPoints :=  copyBlock  markByHorizontalCell:  cell.
	(markedPoints isEmpty or: [ (aBlock includes: $X) and: [aBlock = copyBlock ]]) ifTrue:[^self].	
	markedPoints do: [ :point | sudokuBoard boardA2D at: point y at: point x put: $X].
	^copyBlock
]

{ #category : #logic }
OttiezTactics >> letsRetsme [

	|logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	1 to: 9 do: [ :i | | column |
		column := sudokuBoard getSudokuColumn: i.
		column countOfReservedBlankCells = 1 ifTrue:[
			self fillOneBlankCellOfColumn: column.
			].
		column countOfReservedBlankCells = 2 ifTrue: [ 
			self fillTwoBlankCellsOfColumn: column.
			]]

]

{ #category : #logic }
OttiezTactics >> letsRetsme: colNumber [
	"
	letsRetsme  動作検証用メソッド
	"
	| column countOfBlankCell |
	column := sudokuBoard getSudokuColumn: colNumber.
	countOfBlankCell := column countOfReservedBlankCells.
	countOfBlankCell  = 1 ifTrue: [
		self fillOneBlankCellOfColumn: column.
		column := sudokuBoard getSudokuColumn: colNumber.].
	countOfBlankCell  = 2 ifFalse: [ ^ self ].
	self fillTwoBlankCellsOfColumn: column.
	column := sudokuBoard getSudokuColumn: colNumber.

]

{ #category : #logic }
OttiezTactics >> rowMarking: aBlock [
	
	aBlock rowsOnBoard do: [ :sudokuRow |
		(sudokuRow includes: aBlock verifyNumber) ifTrue: [ 
			| x y cell |
			x := sudokuRow indexOf: aBlock verifyNumber.
			y := sudokuRow rowIndex .
			(x = 0 or: [ y = 0 ]) ifTrue: [ self error: 'x = 0 or y = 0' ].
			cell := (sudokuBoard getCellRow: y cellColumn: x) copy.
			cell blockNumber = aBlock blockNumber ifFalse: [  
				cell element: aBlock verifyNumber.
				cell clearPossibleNumbers.
				aBlock markByHorizontalCell: cell]]].
]

{ #category : #logic }
OttiezTactics >> verticalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	bNumber1 := (self relatedVertBlocks at: aBlock blockNumber) at: 1.
	bNumber2 := (self relatedVertBlocks at: aBlock blockNumber) at: 2.
	logger trace: ('sudokuCell => {1}' format: {cell}).
	logger debug: sudokuBoard .
	block1 := sudokuBoard
		          getBlock: bNumber1
		          verifyNumber: aBlock verifyNumber.
	block2 := sudokuBoard
		          getBlock: bNumber2
		          verifyNumber: aBlock verifyNumber.
	(block1 includes: aBlock verifyNumber) 
		ifFalse: [ 
			^self verticalBlockMarking: block1  sudokuCell: cell ].
		
	(block2 includes: aBlock verifyNumber) 
		ifFalse: [
			^self verticalBlockMarking: block2  sudokuCell: cell]
]

{ #category : #logic }
OttiezTactics >> verticalBlockMarking: aBlock sudokuCell: cell [

	| markedPoints copyBlock logger |
	logger := M946FileLogger new.
	logger debug: thisContext.
	copyBlock := aBlock deepCopy .
	
	markedPoints :=  copyBlock  markByVerticalCell: cell.
	(markedPoints isEmpty or: [ (aBlock includes: $X) and: [aBlock = copyBlock ]]) ifTrue:[^self].	
	markedPoints do: [ :point | sudokuBoard boardA2D at: point y at: point x put: $X].
	^copyBlock
]
