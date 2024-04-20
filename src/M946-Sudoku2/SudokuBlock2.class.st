"
数独ボードを9つに分けた1ブロックを表現するクラス

    Instance Variables
	blockA2D			<Array2D>  		ブロックの内部表現
	blockNumber			<Smalllnteger>	ブロック番号
	colsOnBoard			<Array>			ブロックの列インデックスに対応するボード上の列(SudokuColumn)
	rowsOnBoard			<Array>			ブロックの行インデックスに対応するボード上の行(SudokuRow)
	verifyNumber		<SmallInteger>	検証数字


"
Class {
	#name : #SudokuBlock2,
	#superclass : #Object,
	#instVars : [
		'blockA2D',
		'rowsOnBoard',
		'colsOnBoard',
		'blockNumber',
		'verifyNumber'
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
	block := board blockAt: bNum.
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

{ #category : #'private - printing' }
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
SudokuBlock2 >> colsOnBoard [
	"
	ブロックの列に対応するボードの列を返す
	"
	^colsOnBoard 
]

{ #category : #comparing }
SudokuBlock2 >> hash [ 
	^(((( blockA2D hash bitXor: rowsOnBoard hash )
			bitXor: colsOnBoard hash )
				bitXor: blockNumber hash )
					bitXor: verifyNumber hash)
]

{ #category : #initialization }
SudokuBlock2 >> initialize [ 

	super initialize .
	blockA2D := Array2D new:  3 element: 0.
	colsOnBoard := Array new: 3.
	rowsOnBoard := Array new: 3.
	verifyNumber := 0.
	
]

{ #category : #printing }
SudokuBlock2 >> printOn: aStream [

	aStream
		nextPutAll: self asString; cr.
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
			row: (rowsOnBoard at: ri + 1) rowIndex column: (colsOnBoard at: ci + 1 ) colIndex  element: 0.
	].
	
	^ cell
	
]

{ #category : #logic }
SudokuBlock2 >> tsumo [
    "
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := blockA2D asArray select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		array asSet size = 8
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
