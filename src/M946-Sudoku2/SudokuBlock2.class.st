"
数独ボードを9つに分けた1ブロックを表現するクラス

    Instance Variables
	blockA2D			<Array2D>  		ブロックの内部表現
	blockNumber			<Smalllnteger>	ブロック番号
	colsOnBoard			<Array>			ブロックの列インデックスに対応するボード上の列(SudokuColumn)
	rowsOnBoard			<Array>			ブロックの行インデックスに対応するボード上の行(SudokuRow)
	verifyNumber		<SmallInteger>	検証数字
	eitherCells			<EitherCells>	ブロックのブランクセルが２つになり必ずどちらかに検証数字が入るセル
                  
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
	block := board atBlock: bNum.
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
	aStream nextPutAll: 'Block '; nextPutAll: blockNumber asString;cr.
	aStream nextPutAll: '検証数字:'; nextPutAll: verifyNumber asString;cr.
	aStream nextPutAll: '========='; cr. 
	(1 to: blockA2D  numberOfRows)
		do: [ :r |
				(blockA2D  atRow: r)
					do: [ :each | aStream print: each ]
					separatedBy: [ aStream tab ]]
		separatedBy: [ aStream cr].
	aStream cr; nextPutAll: '========='.
	
	^aStream contents

]

{ #category : #accessing }
SudokuBlock2 >> blankCellsAsArray [
	"
    ブロックのブランクセルをSudokuCellの配列にして返す
    "
	| collection |
	collection := OrderedCollection new.
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j |
			(blockA2D at: i at: j) = 0 ifTrue: [
				collection add: (SudokuCell
						 row: (rowsOnBoard at: i) rowIndex
						 column: (colsOnBoard at: j) colIndex
						 element: 0) ] ] ].

	^ (collection select: [ :each | each class = SudokuCell ]) asArray
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

{ #category : #comparing }
SudokuBlock2 >> hash [ 
	^(((( blockA2D hash bitXor: rowsOnBoard hash )
			bitXor: colsOnBoard hash )
				bitXor: blockNumber hash )
					bitXor: verifyNumber hash)
]

{ #category : #testing }
SudokuBlock2 >> includes: number [

	^blockA2D asArray includes: number 
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
	eitherCells := EitherCells new.
	
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

	self row:  rowIndex column: colIndex 
]

{ #category : #accessing }
SudokuBlock2 >> x: colIndex y: rowIndex put: elem [

	self row: rowIndex column: colIndex  put: elem
]

{ #category : #converting }
SudokuBlock2 >> xOnBoard: indexOnBlock [

	self rowIndexOnBoard: indexOnBlock 

	
]

{ #category : #converting }
SudokuBlock2 >> yOnBoard: indexOnBlock [

	self colIndexOnBoard: indexOnBlock 
]
