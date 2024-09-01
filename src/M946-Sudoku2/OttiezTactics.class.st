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

	| reloadBlock tsumoCell logger blankCellCount |
	logger := M946FileLogger new: thisContext.
	reloadBlock := sudokuBoard
		               getBlock: aBlock blockNumber
		               verifyNumber: aBlock verifyNumber.
	logger debug: ('reloadBlock => {1}' format: {reloadBlock}).
	blankCellCount := reloadBlock countOfReservedBlankCells.
	logger debug: ('reloadBlock countOfReservedBlankCell => {1}' format: {blankCellCount}).
	blankCellCount = 4 ifTrue: [ 
		self checkDoubleTwoPairOfZeroBlanks: reloadBlock.
		self checkDoubleTwoPairOfOnePair: reloadBlock].
	blankCellCount  = 1 ifFalse: [ ^ self ].
	tsumoCell := reloadBlock allGreen.
	logger debug: ('tsumoCell => {1}' format: {tsumoCell}).
	tsumoCell class = SudokuCell ifTrue: [ sudokuBoard map: tsumoCell ]
]

{ #category : #logic }
OttiezTactics >> checkColumnTenpai: aCell [

	| column tsumoCell logger |
	logger := M946FileLogger new: thisContext.
	column := sudokuBoard getSudokuColumn: aCell colIndex.

	column countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	tsumoCell := column tsumo.
	logger debug: ('tsumoCell => {1}' format: {tsumoCell}).
	tsumoCell class = SudokuCell ifTrue: [ sudokuBoard map: tsumoCell ].
	^ self
]

{ #category : #logic }
OttiezTactics >> checkDoubleTwoPairOfOnePair: reloadBlock [
	"
	2組のツーペアができた場合、新にできたツーペアをボードにマップする
	reloadBlockには1組のツーペアがすでにある。
	------------------------------
	- ブランクセルはあわせて4つ
	- 内ツーペアセルが2つ、ワンペアセルが2つ
	- ブロックで実数字と予約数字で足りない数字を求める
	- ワンペアセルのpossibleNumbersに足りない数字を追加し、ツーペアにする
	"
	|blankSudokuCell twoPairBlank  onePairBlank numbersOfBlock newPossibleNumber logger |
	logger := M946FileLogger new: thisContext.
	blankSudokuCell := reloadBlock blankCellsAsArray .
	logger debug: ('blankSudokuCell => {1}' format: {blankSudokuCell}).
	twoPairBlank := blankSudokuCell  select: [ :cell | cell possibleNumbers size = 2 ].
	(twoPairBlank size = 2 
		and: [ (twoPairBlank at: 1) possibleNumbers = (twoPairBlank at: 2) possibleNumbers ])
		ifFalse: [ ^self ].
	onePairBlank := blankSudokuCell select: [ :cell | cell possibleNumbers size = 1 ].
	(onePairBlank size = 2 
				and: [ (onePairBlank at: 1) possibleNumbers = (onePairBlank at:2 ) possibleNumbers ])
		ifFalse: [ ^self ].
	numbersOfBlock :=  (reloadBlock blockA2D asArray select: 
		[:cell |  cell class = SmallInteger and: [ cell between: 1 and: 9]]) asOrderedCollection.
	numbersOfBlock addAll: ((twoPairBlank at: 1) possibleNumbers ); addAll:((onePairBlank at: 1) possibleNumbers ).
	newPossibleNumber := #(1 2 3 4 5 6 7 8 9) difference: numbersOfBlock .
	newPossibleNumber size = 1 ifFalse: [ ^self ].
	(onePairBlank at: 1) possibleNumbers addAll: newPossibleNumber .
	(onePairBlank at: 2) possibleNumbers addAll: newPossibleNumber .
	sudokuBoard map: (onePairBlank at: 1); map: (onePairBlank at: 2)

]

{ #category : #logic }
OttiezTactics >> checkDoubleTwoPairOfZeroBlanks: reloadBlock [
	"
	2組のツーペアができた場合、新にできたツーペアをボードにマップする
	reloadBlockには1組のツーペアがすでにある。
	------------------------------
	- ブランクセルはあわせて4つ
	- 内ツーペアセルが2つ、0セルが2つ
	- ブロックで実数字と予約数字で足りない数字を求める
	- 求めた数字のツーペアを作り0セルを埋める 	
	"
	|blankSudokuCell twoPairBlank  zeroBlank numbersOfBlock newPossibleNumbers logger |
	logger := M946FileLogger new: thisContext.
	blankSudokuCell := reloadBlock blankCellsAsArray .
	logger debug: ('blankSudokuCell => {1}' format: {blankSudokuCell}).
	twoPairBlank := blankSudokuCell  select: [ :cell | cell possibleNumbers size = 2 ].
	(twoPairBlank size = 2 
		and: [ (twoPairBlank at: 1) possibleNumbers = (twoPairBlank at: 2) possibleNumbers ])
		ifFalse: [ ^self ].
	zeroBlank := blankSudokuCell  select: [ :cell | cell possibleNumbers isEmpty].
	zeroBlank size = 2 ifFalse: [ ^self ].
	numbersOfBlock :=  (reloadBlock blockA2D asArray select: 
		[:cell |  cell class = SmallInteger and: [ cell between: 1 and: 9]]) asOrderedCollection.
	numbersOfBlock addAll: ((twoPairBlank at: 1) possibleNumbers ).
	newPossibleNumbers := #(1 2 3 4 5 6 7 8 9) difference: numbersOfBlock .
	newPossibleNumbers size = 2 ifFalse: [ ^self ].
	(zeroBlank at: 1) possibleNumbers addAll: newPossibleNumbers .
	(zeroBlank at: 2) possibleNumbers addAll: newPossibleNumbers .
	sudokuBoard map: (zeroBlank at: 1); map: (zeroBlank at: 2).
	

]

{ #category : #logic }
OttiezTactics >> checkForTwoPairs: aBlock [ 

	| reloadBlock twoPairs  "blankCells" logger |
	logger := M946FileLogger new: thisContext.
	
	reloadBlock := sudokuBoard getBlock:  (aBlock blockNumber) verifyNumber: (aBlock verifyNumber).
	twoPairs := reloadBlock blockA2D asArray select: [ :item |
		item class = SudokuCell and: [ item possibleNumbers isNotEmpty ]].
	logger debug: ('twoPairs => {1}' format: {twoPairs }).
	twoPairs size = 2 ifFalse: [ ^self ].	
	((twoPairs at: 1) possibleNumbers size = 2 and: [(twoPairs at: 2) possibleNumbers size = 2 ])
		ifFalse: [ ^self ].
	(twoPairs at: 1) possibleNumbers asBag = (twoPairs at: 2) possibleNumbers asBag 
		ifFalse: [ ^self ].
	^twoPairs 
		
	"
	blankCells := aBlock blankCellsAsArray .
	^(blankCells select: [ :cell | cell ~= (twoPairs at: 1) ]) select: [ :cell | cell ~=  (twoPairs at: 2) ]
	"
]

{ #category : #logic }
OttiezTactics >> checkRowTenpai: aCell [

	| row tsumoCell logger |
	logger := M946FileLogger new: thisContext.
	row := sudokuBoard getSudokuRow: aCell colIndex.

	row countOfReservedBlankCells = 1 ifFalse: [ ^ self ].
	tsumoCell := row tsumo.
	logger debug: ('tsumoCell => {1}' format: {tsumoCell}).
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

	| reloadBlock tsumoCell logger |
	logger := M946FileLogger new: thisContext.
	reloadBlock := sudokuBoard
		               getBlock: aBlock blockNumber
		               verifyNumber: aBlock verifyNumber.
	tsumoCell := reloadBlock twoPairsTenpai .
	logger debug: ('tsumoCell class => {1}' format: {tsumoCell class}).
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

	| cell logger |
	logger := M946FileLogger new: thisContext.
	logger debug:('column => {1}' format: {column}).
	cell := column cellOf: 0.
	cell class = SudokuCell ifFalse: [ ^ self ].
	cell element: (column missingNumbers at: 1).
	logger debug: ('cell for mapping => {1}' format: {cell}).
	sudokuBoard boardA2D at: (cell y) at: (cell x) put: (cell element)
]

{ #category : #logic }
OttiezTactics >> fillOneBlankCellOfRow: sudokuRow [

	| cell |
	cell := sudokuRow cellOf: 0.
	cell class = SudokuCell ifFalse: [ ^self ].
	cell element: (sudokuRow missingNumbers at: 1).
	sudokuBoard boardA2D at: (cell y) at: (cell x) put: (cell element)
]

{ #category : #logic }
OttiezTactics >> fillThreeBlankCellsOfColumn: sudokuColumn [
	"
	ツーペア1組と１個のブランクセルを含む列のブランクセルを解決する。
	決定した数字をSudokuBoardに配置する時はSudokuBoard>>map:を使わず
	Array2D>>at: at: put:を使い数字を配置するだけにする。
	"
	| logger threeBlankCells twoPair array numbersOfColumn missingNumber zeroCell |
	logger := M946FileLogger new: thisContext.
	threeBlankCells := sudokuColumn blankCellsAsArray .
	twoPair := sudokuColumn column select: [ :cell |
		           cell class = SudokuCell and: [
			           cell possibleNumbers size = 2 ] ].
	logger debug: ('twoPair =>
{1}' format:{twoPair}).
	(twoPair size = 2 and: [
		 (twoPair at: 1) possibleNumbers = (twoPair at: 2) possibleNumbers ])
		ifFalse: [ ^ self ].
	zeroCell := (threeBlankCells difference: twoPair) at: 1. 
	logger debug: ('zeroCell => {1}' format: {zeroCell}).
	array := sudokuColumn column select:
		                   [ :cell |
		                   cell class = SmallInteger and: [
			                   cell between: 1 and: 9 ] ].
	numbersOfColumn := array asOrderedCollection .
	numbersOfColumn addAll: (twoPair at: 1) possibleNumbers.
	logger debug: ('numbersOfColumn => {1}' format: {numbersOfColumn}).
	numbersOfColumn size = 8 ifFalse: [ ^ self ].
	missingNumber := sudokuColumn missingNumbers  at: 1.
	logger debug: ('missingNumber => {1}' format: {missingNumber}).
	
	sudokuBoard boardA2D  at: (zeroCell y) at: (zeroCell x) put: missingNumber
]

{ #category : #logic }
OttiezTactics >> fillThreeBlankCellsOfRow: sudokuRow [
	"
	ツーペア1組と１個のブランクセルを含む列のブランクセルを解決する。
	決定した数字をSudokuBoardに配置する時はSudokuBoard>>map:を使わず
	Array2D>>at: at: put:を使い数字を配置するだけにする。
	"
	| logger threeBlankCells twoPair array numbersOfRow missingNumber zeroCell |
	logger := M946FileLogger new: thisContext.
	threeBlankCells := sudokuRow blankCellsAsArray .
	twoPair := sudokuRow row select: [ :cell |
		           cell class = SudokuCell and: [
			           cell possibleNumbers size = 2 ] ].
	(twoPair size = 2 and: [
		 (twoPair at: 1) possibleNumbers = (twoPair at: 2) possibleNumbers ])
		ifFalse: [ ^ self ].
	zeroCell := (threeBlankCells difference: twoPair) at: 1. 	
	array := sudokuRow row select:
		                   [ :cell |
		                   cell class = SmallInteger and: [
			                   cell between: 1 and: 9 ] ].
	numbersOfRow := array asOrderedCollection .
	numbersOfRow addAll: (twoPair at: 1) possibleNumbers.
	numbersOfRow size = 8 ifFalse: [ ^ self ].
	missingNumber := sudokuRow missingNumbers  at: 1.

	sudokuBoard boardA2D  at: (zeroCell y) at: (zeroCell x) put: missingNumber
]

{ #category : #logic }
OttiezTactics >> fillTwoBlankCellsOfColumn: sudokuColumn [

	| missingNumbers bingo logger |
	logger := M946FileLogger new: thisContext.
	missingNumbers := sudokuColumn missingNumbers.
	logger debug: ('missingNumbers => {1}' format: {missingNumbers}).
	bingo := #().
	sudokuColumn column doWithIndex: [ :num :i | | originalRow |
		(num = 0  or: [num class = SudokuCell ])ifTrue: [  
			originalRow := sudokuBoard getOriginalRow: i.			
			logger debug: ( 'originalRow => {1}' format: {originalRow}).
			bingo := missingNumbers difference: (originalRow  intersection: missingNumbers).
			logger debug: ('bingo => {1}' format: {bingo}).
			bingo size = 1 ifTrue: [ |tempColumn|
				sudokuBoard boardA2D at: i at: (sudokuColumn colIndex) put: (bingo at: 1).
				tempColumn := sudokuBoard getSudokuColumn: (sudokuColumn colIndex).
				 self fillOneBlankCellOfColumn: tempColumn ]]].

]

{ #category : #logic }
OttiezTactics >> fillTwoBlankCellsOfRow: sudokuRow [

	| missingNumbers bingo |
	missingNumbers := sudokuRow missingNumbers .
	bingo := #().
	sudokuRow row doWithIndex: [ :num :i | | originalColumn |
		(num = 0 or: [num class = SudokuCell ]) ifTrue: [ 
			originalColumn := sudokuBoard getOriginalColumn: i.
			bingo := missingNumbers difference: (originalColumn  intersection: missingNumbers ).
			bingo size = 1 ifTrue: [ |tempRow|
				sudokuBoard boardA2D at: (sudokuRow rowIndex) at: (sudokuRow row at: i) put: (bingo at: 1).
				tempRow := sudokuBoard getSudokuRow: sudokuRow rowIndex.
				self fillOneBlankCellOfRow: tempRow]]]
]

{ #category : #logic }
OttiezTactics >> findAffectedCell: aBlock [
 	"
	ブロック内の同盟関係のセルに影響を与える他ブロックのセルをSudokuCellオブジェクトとして取得する。
	todo: reservedCells size が3または4の時の機能も実装すること
	"
	| reservedCells |
	reservedCells := aBlock blankCellsAsArray select: [ :cell |
		cell possibleNumbers isNotEmpty ].
	reservedCells size < 2 ifTrue: [ ^self ].
	reservedCells size = 2 ifTrue: [ ^self findAffectedCellOfPairCell: aBlock pairCell: reservedCells ].

]

{ #category : #logic }
OttiezTactics >> findAffectedCell: aBlock reservedCells: reservedCells [
 	"
	ブロック内の同盟関係のセルに影響を与える他ブロックのセルをSudokuCellオブジェクトとして取得する。
	todo: reservedCells size が3または4の時の機能も実装すること
	"
	reservedCells size < 2 ifTrue: [ ^self ].
	reservedCells size = 2 ifTrue: [ ^self findAffectedCellOfPairCell: aBlock pairCell: reservedCells ].

]

{ #category : #logic }
OttiezTactics >> findAffectedCellOfPairCell: aBlock pairCell: pairCell [
	"
	引数がワンペア・ツーペアのときの処理
	"
	| affectedCell logger |
	logger := M946FileLogger new: thisContext.
	affectedCell := self.
	(pairCell at: 1) possibleNumbers = (pairCell at: 2) possibleNumbers 
		ifFalse: [ ^self ].
	aBlock rowsOnBoard do: [ :row |
		logger debug: ('row => {1}' format: {row}).
		affectedCell := row getAffectedCellOf: (pairCell at: 1)	.
		logger debug: ('affectedCell => {1}' format: {affectedCell}).
		affectedCell class = SudokuCell ifTrue: [^affectedCell]].
	
	aBlock colsOnBoard do: [ :col |
		affectedCell := col getAffectedCellOf: (pairCell at: 1).
		affectedCell class = SudokuCell ifTrue: [ ^affectedCell ]].
	^self
	
	
]

{ #category : #logic }
OttiezTactics >> findNextBlock: aBlock pairCells: pairCells [

	| cell cellDirection logger |
	logger := M946FileLogger new: thisContext.
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

	| cell1 cell2 cell3 logger |
	logger := M946FileLogger new: thisContext.
	logger debug: aBlock.
	
	cell1 := (trioCells at: 1) deepCopy.
	cell2 := (trioCells at: 2) deepCopy.
	cell3 := (trioCells at: 3) deepCopy.
	
	(((cell1 possibleNumbers) 
		intersection: ( cell2 possibleNumbers))
			intersection: (cell3 possibleNumbers)) size = 1
	ifFalse: [ ^self ]	.
				
	cell1 element: aBlock verifyNumber .
	( cell1 x = cell2 x and: [cell2 x = cell3 x ])
		ifTrue: [ ^ self verticalBlockFinding: aBlock sudokuCell: cell1  ].
		
	( cell1 y = cell2 y and: [cell2 y = cell3 y ])
		ifTrue: [ ^ self horizontalBlockFinding: aBlock sudokuCell: cell1  ].
	
	
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
	logger := M946FileLogger new: thisContext.

	(aBlock includes: aBlock verifyNumber) ifTrue: [ ^self ].
	blankCells := self getAllianceCellsAfterMark: aBlock.
	logger debug: ('blankCells => 
{1}' format:{blankCells}).
	
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
	
	logger debug: ('nextBlock => {1}' format: {nextBlock}).
		nextBlock class = SudokuBlock2 
		ifTrue: [self formBilateralAlliance: nextBlock]	
		ifFalse: [
			sudokuBoard clearMarks.
			self setTwoPairOnBlock]

]

{ #category : #logic }
OttiezTactics >> getAllianceCellsAfterMark: aBlock [
	"
	aBlockの中でのワンペア・スリーカードを探す。
	ブランクセルが1つの時、またはブランクセルが2つの時はそのまま返し,
	ブランクセルが3つの時は垂直方向または水平方向にブランクセルが並ん
	でいる時にセルの配列を返す。
	"
	| blankCells logger |
	logger := M946FileLogger new: thisContext.

	self rowMarking: aBlock.
	self columnMarking: aBlock.
	blankCells := aBlock blankCellsAsArray .
	logger debug: aBlock.
	logger debug: blankCells.
	(blankCells size between: 1 and: 2 ) ifTrue: [ ^blankCells ].
	"
	blankCells size = 2 ifTrue: [ ((blankCells at: 1) x = (blankCells at: 2) x
										or: [(blankCells at: 1) y = (blankCells at: 2) y])
											ifTrue: [ ^blankCells ]].
	"
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
	| cells logger |
	logger := M946FileLogger new: thisContext.
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
	| cells  logger |
	logger := M946FileLogger new: thisContext.
	cells := aBlock blockA2D asOrderedCollection select: [ :item |
				item class = SudokuCell and: [ item notSameCoordinates: thisCell]].
	logger debug: ('thisCell => {1}' format: {thisCell}).
	logger debug: ('asymmetric cells =>
{1}'  format: {cells}).
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
								sudokuBoard map: thisCell clearPossibleNumbers ; map: (cells at:1);map: (cells at: 2)]]]]
		ifFalse:[
			thisCell possibleNumbers size = 2
				ifTrue: [ | possibleNumbers |
					possibleNumbers := thisCell possibleNumbers deepCopy.
					sudokuBoard map: thisCell clearPossibleNumbers .
					(possibleNumbers intersection: (cells at: 1) possibleNumbers ) isNotEmpty 
						and: [ (cells at: 1) possibleNumbers size = 1
							ifTrue: [ 
								(cells at: 1) element: ((cells at: 1) possibleNumbers at: 1).
								(cells at: 1) clearPossibleNumbers.
								sudokuBoard map: (cells at: 1)]].
					(possibleNumbers intersection: (cells at: 2) possibleNumbers ) isNotEmpty 
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
	logger := M946FileLogger new: thisContext.

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
	|  pairCells  logger|	
	logger := M946FileLogger new: thisContext.
	pairCells := aBlock get2Allies: blankCells .
	logger debug: ('pairCells => 
{1}' format: {pairCells}).
	sudokuBoard map: (pairCells at: 1); map: (pairCells at: 2).
	self checkBlockTenpai: aBlock.
	((pairCells at: 1) sameDirection: (pairCells at: 2))
		ifTrue: [ ^self findNextBlock: aBlock pairCells: pairCells ].

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
	logger := M946FileLogger new: thisContext.
	aCell element: aBlock verifyNumber.
	"現在のsudokuBoardのブロックを再取得する"
	actualBlock := sudokuBoard getBlock: (aBlock blockNumber) verifyNumber: (aBlock verifyNumber) .
	"ペアセル取得"
	otherCells  := self getAlliedCellForMapping: actualBlock  cell: aCell.
	logger debug: ('pairCells => 
{1}' format: {otherCells}) .
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
		logger debug: ('alliedCell => {1}' format: {alliedCell}).
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
	logger := M946FileLogger new: thisContext.
	trioCells := aBlock get3Allies: blankCells . 
	logger debug: ('trioCells => 
{1}' format: {trioCells}).
	"
	sudokuBoard map: (trioCells  at: 1); map: (trioCells at: 2); map: (trioCells at: 3).
	"
	nextBlock := self findNextBlock: aBlock trioCells: trioCells .
	
	^nextBlock 
]

{ #category : #logic }
OttiezTactics >> horizontalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946FileLogger new: thisContext.
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
	logger := M946FileLogger new: thisContext.
	copyBlock := aBlock deepCopy.
	markedPoints :=  copyBlock  markByHorizontalCell:  cell.
	(markedPoints isEmpty or: [ (aBlock includes: $X) and: [aBlock = copyBlock ]]) ifTrue:[^self].	
	markedPoints do: [ :point | |cellOfBoard|
		cellOfBoard := sudokuBoard boardA2D at: point y at: point x.
		cellOfBoard class = SudokuCell 
			ifTrue: [ cellOfBoard marked: true ]
			ifFalse: [  sudokuBoard boardA2D at: point y at: point x put: $X ]

		].
	^copyBlock
]

{ #category : #logic }
OttiezTactics >> letsGyome [

	| logger |
	logger := M946FileLogger new: thisContext.
	1 to: 9 do: [ :i | | row blankCellCount|
		row := sudokuBoard getSudokuRow: i.
		blankCellCount := row countOfReservedBlankCells.
		blankCellCount  = 1 ifTrue: [ 
			self fillOneBlankCellOfRow: row].
		blankCellCount  = 2  ifTrue: [ 
			self fillTwoBlankCellsOfRow: row].
		blankCellCount = 3 ifTrue: [ 
			self fillThreeBlankCellsOfRow: row]]
]

{ #category : #logic }
OttiezTactics >> letsRetsme [

	|logger |
	logger := M946FileLogger new: thisContext.
	logger info: thisContext.
	1 to: 9 do: [ :i | | column  blankCellCount |
		column := sudokuBoard getSudokuColumn: i.
		blankCellCount := column countOfReservedBlankCells .
		blankCellCount  = 1 ifTrue:[
			self fillOneBlankCellOfColumn: column].
		blankCellCount  = 2 ifTrue: [ 
			self fillTwoBlankCellsOfColumn: column].
		blankCellCount  = 3 ifTrue: [ 
			self fillThreeBlankCellsOfColumn: column]]

]

{ #category : #logic }
OttiezTactics >> resolveAlliance: aBlock [
	"
	他ブロックの解決した数字を元にしてブロック内の同盟(ワンペア・ツーペア)を解決する。
	"
	| affectedCell reservedCells ba thisCell otherCell logger |
	logger := M946FileLogger new: thisContext.
	reservedCells := aBlock blankCellsAsArray select: [ :cell |
		cell possibleNumbers isNotEmpty ].
	logger debug: ('reservedCells => {1}' format: {reservedCells }).
	affectedCell := self findAffectedCell: aBlock reservedCells: reservedCells .
	affectedCell class = SudokuCell ifFalse: [ ^self ].
	logger debug: ('affectedCell => {1}' format: {affectedCell  }).
	((reservedCells at: 1) sameDirection: affectedCell ) 
		ifTrue: [ thisCell := reservedCells at: 1.
				   otherCell := reservedCells at: 2 ]		
		ifFalse: [ thisCell := reservedCells at: 2.
					otherCell := reservedCells at: 1 ].
	
	ba := BilateralAllianceOfRelatedBlock thisCell: thisCell 
											otherCell: otherCell 
											confirmNumber: affectedCell element.
	ba determineTheNumber .
	logger debug: ('thisCell => {1}' format: {thisCell}).
	logger debug: ('otherCell => {1}' format: {otherCell}).
	sudokuBoard at: thisCell x @ thisCell y put: thisCell element.
	sudokuBoard at: otherCell x @ otherCell y put: otherCell element.
	
	
	^ba
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
OttiezTactics >> setTwoPairOnBlock [
	"
	formBilateralAlliance: を抜ける時にツーペアがセットできるブロックがあれば
	ツーペアをセットする。
	"
	| logger block twoPairs |
	logger := M946FileLogger new: thisContext.
	1 to: 9 do: [ :i |
		block := sudokuBoard getBlock: i.
		twoPairs := block readyForFillTwoPair .
		(twoPairs class = Array and: [ twoPairs size = 2 ]) ifTrue: [ 
			sudokuBoard map: (twoPairs at: 1); map: (twoPairs at: 2)]]
]

{ #category : #logic }
OttiezTactics >> verticalBlockFinding: aBlock sudokuCell: cell [

	| bNumber1 bNumber2 block1 block2 logger |
	logger := M946FileLogger new: thisContext.
	bNumber1 := (self relatedVertBlocks at: aBlock blockNumber) at: 1.
	bNumber2 := (self relatedVertBlocks at: aBlock blockNumber) at: 2.
	logger debug: ('sudokuCell => {1}' format: {cell}).
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
	logger := M946FileLogger new: thisContext.
	copyBlock := aBlock deepCopy .
	
	markedPoints :=  copyBlock  markByVerticalCell: cell.
	logger debug: ('markedPoints => {1}' format: {markedPoints}).
	logger debug: ('aBlock => {1}' format: {aBlock}).
	logger debug: ('copyBlock => {1}' format: {copyBlock}).

	(markedPoints isEmpty or: [ (aBlock includes: $X) and: [aBlock = copyBlock ]]) ifTrue:[^self].	
	markedPoints do: [ :point | |cellOfBoard|
		cellOfBoard := sudokuBoard boardA2D at: point y at: point x.
		logger debug: ('cellOfBoard => {1}' format: {cellOfBoard }).
		cellOfBoard class = SudokuCell 
			ifTrue: [ cellOfBoard marked: true ]
			ifFalse: [  sudokuBoard boardA2D at: point y at: point x put: $X ]
		].
	^copyBlock
]
