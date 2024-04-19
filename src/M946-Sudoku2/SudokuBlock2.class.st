"
数独ボードを9つに分けた1ブロックを表現するクラス

    Instance Variables
	blockA2D			<Array2D>  		ブロックの内部表現
	blockNumber			<Smalllnteger>	ブロック番号
	colsOnBoard			<Array>			ブロックの列インデックスに対応するボード上の列(SudokuColumn)
	rowsOnBoard			<Array>			ブロックの行インデックスに対応するボード上の行(SudokuRow)
	colIndicesOnBoard	<Array>			ブロックの列インデックスに対応するボードの列インデックス
	rowIndicesOnBoard	<Array>			ブロックの行インデックスに対応するボードの行インデックス
	verifyNumber		<SmallInteger>	検証数字


"
Class {
	#name : #SudokuBlock2,
	#superclass : #Object,
	#instVars : [
		'blockA2D',
		'rowsOnBoard',
		'colsOnBoard',
		'rowIndicesOnBoard',
		'colIndicesOnBoard',
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
SudokuBlock2 >> colIndicesOnBoard [

	^colIndicesOnBoard 
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
	colIndicesOnBoard := Array braceWith: 0 with:0  with: 0.
	rowIndicesOnBoard := Array braceWith: 0 with:0  with: 0.
	verifyNumber := 0.
	
]

{ #category : #printing }
SudokuBlock2 >> printOn: aStream [

	aStream
		nextPutAll: self _blockAsString; cr;
		nextPutAll: 'row indices on board: ';
		nextPutAll: rowIndicesOnBoard    asString;cr;
		nextPutAll: 'col indices on board: ';
		nextPutAll: colIndicesOnBoard   asString

]

{ #category : #accessing }
SudokuBlock2 >> rowIndicesOnBoard [

	^rowIndicesOnBoard 
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
	ブロックにブランクセル１つだけの時はブランクセルの位置をボード座標に変換して返す。
	でなければ0を返す。
	"
	| result array |
	result := 0.
	array := blockA2D asArray.
	(array select: [ :val | val = 0 ]) size = 1
	ifTrue: [ | blankIndex ri ci | 
		blankIndex := array indexOf: 0 .
		ri := (blankIndex - 1) // 3.
		ci := (blankIndex - 1) % 3.
		result := SudokuCell 
			row: (rowIndicesOnBoard at: ri + 1) column: (colIndicesOnBoard at: ci + 1 ) element: 0.
	].
	
	^ result
	
]

{ #category : #accessing }
SudokuBlock2 >> verifyNumber [
	"
	検証数字を返す
	"
	^verifyNumber 
]
