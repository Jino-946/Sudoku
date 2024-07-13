"
数独ボードを9つに分けた1ブロックを表現するクラス

Instance Variables
blockA2D			<Array2D>  		ブロックの内部表現
blockNumber			<Smalllnteger>	ブロック番号
colsOnBoard			<Array>			ブロックの列インデックスに対応するボード上の列(SudokuColumn)
rowsOnBoard			<Array>			ブロックの行インデックスに対応するボード上の行(SudokuRow)
verifyNumber		<SmallInteger>	検証数字
eitherCells			<EitherCells>	ブロックのブランクセルが２つになり必ずどちらかに検証数字が入るセル
	
					
主なAPI
allGreen                  1つのブランクセル以外の8つのセルが1-9までの数字で埋まっている時
                          足りない数字をSudokuCellに格納して返す、でなければ0を返す
colsOnBoard               ブロックの列インデックスに対応するボードの列(SudokuColumnの配列)を返す
countOfReservedBlankCells ブランクセル以外のセルは1-9の数字で埋まっている時のブランクセルの数を返す
localX:                   ボードのX座標をブロックのX座標に変換し返す
localY:                   ボードのY座標をブロックのY座標に変換し返す
markBlankCells            すべてのブランクセルを$Xでマークする
markByHorizontalCell:     ブランクセルのY座標と引数セルのY座標が等しい時ブランクセルを$Xでマークする
markByVerticalCell:       ブランクセルのX座標と引数セルのX座標が等しい時ブランクセルを$Xでマークする
rowsOnBoard               ブロックの行に対応するボードの行(SudokuRowの配列)を返す
tenpai                    ブロックにブランクセル１つだけの時はブランクセルのボード座標をSudokuCellに
                          マッピングして返す、でなければ0を返す(allGreenと異なり$Xなどの混在可)
xOnBoard:                 ブロックのX座標をボードX座標に変換し返す
yOnBoard:                 ブロックのX座標をボードY座標に変換し返す
"
Class {
	#name : #SudokuBlock2,
	#superclass : #Object,
	#instVars : [
		'blockA2D',
		'rowsOnBoard',
		'colsOnBoard',
		'blockNumber',
		'verifyNumber',
		'eitherCells'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #creation }
SudokuBlock2 class >> sudokuBoard: board blockNumber: bNum verifyNumber: vNum [
	"
    ブロッケン法で数独問題を解決するため、対象となる数独ボード(board)より
    ブロック番号(bNum)を指定してブロックを取り出し、ブロックに検証数値を
    セットする。

	"
	| block |
	block := board getBlock: bNum.
	block verifyNumber: vNum.
	
	^ block
]

{ #category : #comparing }
SudokuBlock2 >> = aSudokuBlock2 [

	^ aSudokuBlock2 class == self class
		and: [ aSudokuBlock2 blockA2D = self blockA2D 
			and: [ aSudokuBlock2 rowsOnBoard = self rowsOnBoard 
				and: [ aSudokuBlock2 colsOnBoard = self colsOnBoard 
					and: [ aSudokuBlock2 verifyNumber = self verifyNumber  ] ] ] ]
]

{ #category : #logic }
SudokuBlock2 >> allGreen [ 
	"
	allGreen: 麻雀用語で緑一色のこと、 軍事用語でシステムが全て正しく作動すること
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := blockA2D asArray select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		array asSet size = 8
		ifFalse: [ cell := 0 ]
		ifTrue: [ 
			shortOfNumber := 45 - array sum.
			cell element: shortOfNumber ]
	].

	^ cell
]

{ #category : #converting }
SudokuBlock2 >> asArray [

	^blockA2D asArray
]

{ #category : #converting }
SudokuBlock2 >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream cr.
	aStream nextPutAll: 'Block '; nextPutAll: blockNumber asString;cr.
	aStream nextPutAll: '検証数字:'; nextPutAll: verifyNumber asString;cr.
	aStream nextPutAll: '========='; cr. 
	(1 to: blockA2D  numberOfRows)
		do: [ :r |
				(blockA2D  atRow: r)
					do: [ :each | 
						each class = SudokuCell
							ifTrue: [ 
								aStream nextPutAll: each asSimpleString ]
						 	ifFalse: [  
								aStream nextPutAll: each asString ]]
					separatedBy: [ aStream tab ]]
		separatedBy: [ aStream cr].
	aStream cr; nextPutAll: '========='.
	
	^aStream contents

]

{ #category : #accessing }
SudokuBlock2 >> blankCellsAsArray [
	"
    ブロックのブランクセルをSudokuCellの配列にして返す。
    "
	| collection |
	collection := OrderedCollection new.
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j | | cellItem |
			cellItem := blockA2D at:i at: j.
			(cellItem class = SmallInteger and: [ cellItem = 0 ]) ifTrue: [
				collection add: (SudokuCell
						 row: (rowsOnBoard at: i) rowIndex
						 column: (colsOnBoard at: j) colIndex
						 element: 0) ].
			cellItem class = SudokuCell ifTrue: [ collection add: cellItem ]]].
	^ collection asArray
]

{ #category : #accessing }
SudokuBlock2 >> blockA2D [

	^ blockA2D 
]

{ #category : #accessing }
SudokuBlock2 >> blockNumber [ 
	"
	ブロック番号を返す
	"
	^blockNumber 
]

{ #category : #accessing }
SudokuBlock2 >> blockNumber: aNumber [

	blockNumber := aNumber
]

{ #category : #accessing }
SudokuBlock2 >> cellOf: number [
	"
	numberの座標をSudokuCellにマップして返し見つからない場合は0を返す。
	"
	| index cell ri ci|
	cell := 0.
	index := blockA2D asArray indexOf: number.
	index = 0
	ifFalse: [ 
		ri := (index - 1) // 3 + 1.
		ci := (index - 1) % 3 + 1.
		cell := SudokuCell row: (rowsOnBoard at: ri) rowIndex column: (colsOnBoard at: ci) colIndex  element: number.
	].
	
	^cell
]

{ #category : #converting }
SudokuBlock2 >> colIndexOnBoard: index [
	"
	ブロックインデックスをボードインデックスに変換する
	"
	| start |
	start := 0.
	(#(1 4 7) includes: blockNumber)
	ifTrue: [ start := 1 ].
	
	(#(2 5 8) includes: blockNumber)
	ifTrue: [ start := 4 ].
	
	(#(3 6 9) includes: blockNumber)
	ifTrue: [ start := 7 ].
	
	^start + index - 1.
]

{ #category : #accessing }
SudokuBlock2 >> colsOnBoard [
	"
	ブロックの列に対応するボードの列を返す
	"
	^colsOnBoard 
]

{ #category : #logic }
SudokuBlock2 >> completed [ 
    "
    ブロックの全てのセルが1-9の数字で埋まりセルの合計が45の時trueを返す
    "
	|array|
	array := blockA2D asArray select: [ :num |
		num class == SmallInteger and: [ num between: 1 and: 9 ].
	].
	^ array asSet size = 9
		and: [ array sum = 45 ]
]

{ #category : #accessing }
SudokuBlock2 >> countOfReservedBlankCells [
	"
	ブランクセル以外のセルは1-9の数字で埋まっている時のブランクセルの数を返す
	"
	| items |
	items := blockA2D asArray select: [ :i | i class = SmallInteger and: [i < 10 and:[ i = 0 ]]].
	^ items size
	
]

{ #category : #accessing }
SudokuBlock2 >> eitherCells [

	^eitherCells 
]

{ #category : #converting }
SudokuBlock2 >> get2Allies: blankCells [

	| pairCell1 pairCell2 pairCells |
	pairCells := Array new: 2.
	pairCell1 := (blankCells at: 1) copy.
	(pairCell1 possibleNumbers includes: self verifyNumber )
		ifFalse: [ pairCell1 possibleNumbers add: self verifyNumber].
	pairCell2 := (blankCells at: 2) copy.
	(pairCell2 possibleNumbers includes: self verifyNumber )
		ifFalse: [ pairCell2 possibleNumbers add: self verifyNumber].
	pairCells at: 1 put: pairCell1 .
	pairCells at: 2 put: pairCell2 .
	^ pairCells.

]

{ #category : #converting }
SudokuBlock2 >> get3Allies: blankCells [	
	
	| cell1 cell2 cell3 cellAllies |
	cellAllies := Array new: 3.
	cell1 := (blankCells at: 1) copy.
	(cell1 possibleNumbers includes: self verifyNumber)
		ifFalse: [ cell1 possibleNumbers add: self verifyNumber  ].
	cell2 := (blankCells at: 2) copy.
	(cell2 possibleNumbers includes: self verifyNumber)
		ifFalse: [ cell2 possibleNumbers add: self verifyNumber  ].
	cell3 := (blankCells at: 3) copy.
	(cell3 possibleNumbers includes: self verifyNumber)
		ifFalse: [ cell3 possibleNumbers add: self verifyNumber  ].
		
	cellAllies at: 1 put: cell1.
	cellAllies at: 2 put: cell2.
	cellAllies at: 3 put: cell3.
	
	^cellAllies 

]

{ #category : #deprecated }
SudokuBlock2 >> getPairCellsFromCells: pairOfSudokuCell [
	"
	2つのブランクセルがSudokuCellのインスタンスの時の処理
	"
	| pairCell1 pairCell2 pairCells |
	pairCells := Array new: 2.
	pairCell1 := self	x: (self localX: (pairOfSudokuCell  at: 1) colIndex)
						y: (self localY: (pairOfSudokuCell  at: 1) rowIndex)
						putPairCell: pairOfSudokuCell .
	pairCell2 := self	x: (self localX: (pairOfSudokuCell  at: 2) colIndex)
						y: (self localY: (pairOfSudokuCell  at: 2) rowIndex)
						putPairCell: pairOfSudokuCell .
	pairCells at: 1 put: pairCell1 .
	pairCells at: 2 put: pairCell2 .
	
	^pairCells 


]

{ #category : #deprecated }
SudokuBlock2 >> getPairCellsFromDifferentCells: blankCells [
	"
	2つのブランクセルがSudokuPairCellとSudokuCellのインスタンスが混在している時の処理
	"
	| cell pairCell resultArray pairCell2 logger |
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
	resultArray := Array new: 2.
	(blankCells at: 1) class = SudokuPairCell 
		ifTrue: [ 
			pairCell := blankCells at: 1.
			cell := blankCells at: 2]
		ifFalse: [ 
			pairCell := blankCells at: 2.
			cell := blankCells at: 1].
	pairCell pairOfNumbers remove: 0.
	pairCell pairOfNumbers add: self verifyNumber.

	pairCell2 := self x: (self localX: cell colIndex)
							  y: (self localY: cell rowIndex)
							  putPairCell: { pairCell otherCell . cell}.
	logger debug: ('pairCell => {1}' format: {pairCell}).
	logger debug: ('pairCell2 => {1}' format: {pairCell2}).
							
							
	resultArray at: 1 put: pairCell  .
	resultArray at: 2 put: pairCell2 .
	^resultArray 
]

{ #category : #deprecated }
SudokuBlock2 >> getPairCellsFromPairCells: pairOfSudokuPairCells [
	"
	2つのブランクセルがSudokuPairCellのインスタンスの時の処理
	"
	(pairOfSudokuPairCells at: 1) pairOfNumbers add: self verifyNumber .
	(pairOfSudokuPairCells at: 2) pairOfNumbers add: self verifyNumber.
	^pairOfSudokuPairCells 
]

{ #category : #comparing }
SudokuBlock2 >> hash [ 
	^(((( blockA2D hash bitXor: rowsOnBoard hash )
			bitXor: colsOnBoard hash )
				bitXor: blockNumber hash )
					bitXor: verifyNumber hash)
]

{ #category : #testing }
SudokuBlock2 >> includes: number [

	| sudokuCells logger |
	logger := M946Logger new: LogLevel info.
	logger debug: thisContext.
    (blockA2D asArray includes: number) ifTrue: [ ^true].
    sudokuCells := blockA2D asArray select: [ :item |
        item class = SudokuCell and: [ item possibleNumbers includes: number]].
    sudokuCells size > 1 ifTrue: [ ^true ].
    ^false

]

{ #category : #testing }
SudokuBlock2 >> includesVerifyNumber [

	^blockA2D asArray includes: verifyNumber
]

{ #category : #initialization }
SudokuBlock2 >> initialize [ 

	super initialize .
	blockA2D := Array2D new:  3 element: 0.
	colsOnBoard := Array new: 3.
	rowsOnBoard := Array new: 3.
	verifyNumber := 0.
	eitherCells := OrderedCollection new.
	
]

{ #category : #converting }
SudokuBlock2 >> localX: boardX [
	"
	ボードのX座標をブロックのX座標に変換し返す。
	変換できない時は0を返す。
	"
	| localX |
	localX := boardX.
	(#(2 5 8) includes: blockNumber ) ifTrue: [ localX := boardX - 3 ].
	(#(3 6 9) includes: blockNumber ) ifTrue: [ localX := boardX - 6 ].
	(localX between: 1 and: 3) ifFalse: [ localX := 0 ].
	
	^localX
]

{ #category : #converting }
SudokuBlock2 >> localY: boardY [
	"
	ボードのY座標をブロックのY座標に変換し返す。
	変換できない時は0を返す。
	"
	| localY |
	localY := boardY.
	(#(4 5 6) includes: blockNumber ) ifTrue: [ localY := boardY - 3 ].
	(#(7 8 9) includes: blockNumber ) ifTrue: [ localY := boardY - 6 ].
	(localY between: 1 and: 3) ifFalse: [ localY := 0 ].
	
	^localY
]

{ #category : #'private - logics' }
SudokuBlock2 >> markBlankCells [
	"
	すべてのブランクセルを$Xでマークする
	"
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j |
			(self row: i column: j) = 0
				ifTrue: [ self row: i column: j put: $X ]]]
]

{ #category : #logic }
SudokuBlock2 >> markByHorizontalCell: aSudokuCell [
	"
	ブランクセルのY座標と引数セルのY座標が等しい時、
	ブランクセルを$Xでマークする。
	"
	(self includes: aSudokuCell element) ifTrue: [ ^self ].
	self blankCellsAsArray do: [ :blankCell | 
		(blankCell y = aSudokuCell y) ifTrue: [ 
			self row: (self localY: (blankCell y)) column: (self localX: (blankCell x))  put: $X ]]


]

{ #category : #'private - logics' }
SudokuBlock2 >> markByNumberToMark: numberToMark [
	"
	ブランクセルに直交するSudokuRowとSudokuColumnを検査し
	numberToMark があるときはブランクセルを$Xでマークする
	"
	(self includes: numberToMark) ifTrue: [ ^self ].
	
	self blankCellsAsArray do: [ :blankCell | 	| sudokuRow sudokuColumn |
		sudokuRow := self rowsOnBoard  at: (self localY: blankCell y).
		sudokuColumn := self colsOnBoard at: (self localX: blankCell x).
		((sudokuRow includes: numberToMark) or: [ sudokuColumn includes: numberToMark  ]) ifTrue: [ 
			self row: (self localY: (blankCell y)) column: (self localX: (blankCell x))  put: $X ]]

]

{ #category : #logic }
SudokuBlock2 >> markByVerticalCell: aSudokuCell [
	"
	ブランクセルのY座標と引数セルのY座標が等しい時、
	ブロックのブランクセルを$Xでマークする。
	"
	| logger |
	logger := M946Logger new: LogLevel info.
	logger debug: thisContext.
	(self includes: aSudokuCell element) ifTrue: [ ^self ].
	self blankCellsAsArray do: [ :blankCell | 
		(blankCell x = aSudokuCell x) ifTrue: [ 
			logger debug: blankCell .			
			self row: (self localY: (blankCell y)) column: (self localX: (blankCell x))  put: $X ]]


]

{ #category : #'private - utility' }
SudokuBlock2 >> missingNumbers [ 

	^#(1 2 3 4 5 6 7 8 9) difference:  blockA2D asArray
]

{ #category : #printing }
SudokuBlock2 >> printOn: aStream [

	aStream
		nextPutAll: self asString; cr.
]

{ #category : #accessing }
SudokuBlock2 >> row: rIndex column: cIndex [

	^blockA2D at: rIndex at: cIndex 
]

{ #category : #accessing }
SudokuBlock2 >> row: rIndex column: cIndex put: elem [

	blockA2D at: rIndex at: cIndex put: elem
]

{ #category : #accessing }
SudokuBlock2 >> rowIndexOf: number [
	"
	numberの行インデックスを返す
	"
	| index |
	index := blockA2D asArray indexOf: number.
	^(index - 1) // 3 + 1.

]

{ #category : #converting }
SudokuBlock2 >> rowIndexOnBoard: index [
	"
	ブロックインデックスをボードインデックスに変換する
	"
	| start |
	(self blockNumber between: 1 and: 3)
		ifTrue: [ start := 1 ]
		ifFalse: [
			start := (self blockNumber between: 4 and: 6)
				         ifTrue: [ 4 ]
				         ifFalse: [ 7 ] ].
	^ start + index - 1
]

{ #category : #accessing }
SudokuBlock2 >> rowsOnBoard [
	"
	ブロックの行に対応するボードの行を返す
	"
	^rowsOnBoard 
]

{ #category : #logic }
SudokuBlock2 >> tenpai [ 
	"
	ブロックにブランクセル１つだけの時はブランクセルのボード座標をSudokuCellにマッピングして返す。
	でなければ0を返す。
	"
	| cell array |
	cell := 0.
	array := blockA2D asArray.
	(array select: [ :val | val = 0 ]) size = 1
	ifTrue: [ | blankIndex ri ci | 
		blankIndex := array indexOf: 0 .
		ri := (blankIndex - 1) // 3.
		ci := (blankIndex - 1) % 3.
		cell := SudokuCell 
			row: (rowsOnBoard at: ri + 1) rowIndex column: (colsOnBoard at: ci + 1 ) colIndex  element: verifyNumber .
	].
	
	^ cell
	
]

{ #category : #deprecated }
SudokuBlock2 >> tsumo [
    "
	Deprecated : use allGreen
	
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := blockA2D asArray select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		array asSet size = 8
		ifFalse: [ cell := 0 ]
		ifTrue: [ 
			shortOfNumber := 45 - array sum.
			cell element: shortOfNumber ]
	].

	^ cell
]

{ #category : #accessing }
SudokuBlock2 >> verifyNumber [
	"
	検証数字を返す
	"
	^verifyNumber 
]

{ #category : #accessing }
SudokuBlock2 >> verifyNumber: aNumber [

	verifyNumber := aNumber
]

{ #category : #'instance creation' }
SudokuBlock2 >> x: colIndex y: rowIndex [

	^self row:  rowIndex column: colIndex 
]

{ #category : #accessing }
SudokuBlock2 >> x: colIndex y: rowIndex put: anObject [

	(anObject class = Array and: [ (anObject at: 1) class = SudokuCell ]) 
		ifTrue: [ 
			self x: colIndex  y: rowIndex   putPairCell: anObject ]
		ifFalse: [ 
			self row: rowIndex column: colIndex  put: anObject ]
]

{ #category : #'private - logics' }
SudokuBlock2 >> x: colIndex y: rowIndex putPairCell: anArrayOfCell [

	| cell1 cell2 pairCell |
	
	cell1 := anArrayOfCell at:1.
	cell2 := anArrayOfCell at: 2.
	pairCell := SudokuPairCell thisCell: cell1 otherCell: cell2.
	(colIndex = (self localX: cell2 x) and: [ rowIndex = (self localY:  cell2 y)])
	 	ifFalse: [ pairCell := SudokuPairCell thisCell: cell2 otherCell: cell1 ].
	pairCell pairKinds: PairKinds onePair.
	pairCell pairOfNumbers add: self verifyNumber .
	pairCell pairOfNumbers add: 0.

	self row: rowIndex column: colIndex  put: pairCell .
	^pairCell
]

{ #category : #converting }
SudokuBlock2 >> xOnBoard: indexOnBlock [

	self rowIndexOnBoard: indexOnBlock 

	
]

{ #category : #converting }
SudokuBlock2 >> yOnBoard: indexOnBlock [

	self colIndexOnBoard: indexOnBlock 
]
