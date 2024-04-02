"
数独ボード構成する9個のブロックを表現するクラス。

hash method の実装は[Overriding Equality and Hash in Pharo](https://growi.cloud/blog/3044)を参照した。

数独ボード上には下記の構成でブロックは配置される。

    1  2  3
    4  5  6
    7  8  9

インスタンスの生成
	SudokuBlockken blockken := aSudokuBoard blockkenAt: aBlockNumber.

インスタンス変数
	blockNumber:	<SmallInteger>
	blockkenA2D:	<Array2D>
	boardCols:		<Array>
	boardRows:		<Array>
	verifyNumber:	<SmallInteger>
"
Class {
	#name : #SudokuBlock,
	#superclass : #Object,
	#instVars : [
		'blockA2D',
		'boardRows',
		'boardCols',
		'blockNumber',
		'verifyNumber'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
SudokuBlock >> = aSudokuBlockken [

	^ aSudokuBlockken class == self class
		and: [ aSudokuBlockken blockA2D = self blockA2D 
				and: [ aSudokuBlockken boardRows = self boardRows 
					and: [ aSudokuBlockken boardCols = self boardCols 
						and: [ aSudokuBlockken blockNumber = self blockNumber
							and: [aSudokuBlockken verifyNumber = self verifyNumber ] ]]]]
	
]

{ #category : #accessing }
SudokuBlock >> blockA2D [

	^blockA2D
]

{ #category : #'private - helpers' }
SudokuBlock >> blockAsString [
	"
	Array2D >> printOn: による表示乱れを解消する為のヘルパーメソッド	
	"
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
SudokuBlock >> blockNumber [

	^blockNumber 
]

{ #category : #accessing }
SudokuBlock >> blockNumber: aNumber [

	blockNumber := aNumber
]

{ #category : #accessing }
SudokuBlock >> boardCols [
	"blockの列のindex(1-3)に対応するSudokuBoardの列のindex配列を返す"
	^boardCols 
]

{ #category : #accessing }
SudokuBlock >> boardRows [
	"blockの行のindex(1-3)に対応するSudokuBoardの行のindex配列を返す"
	^boardRows 
]

{ #category : #comparing }
SudokuBlock >> hash [ 

	^((((blockA2D hash bitXor: boardRows hash )
			bitXor: boardCols hash) 
				bitXor: blockNumber hash)
					bitXor: verifyNumber  hash)
					
		
]

{ #category : #initialization }
SudokuBlock >> initialize [ 

	super initialize .
	blockA2D := Array2D new:  3 element: 0.
	boardRows  := Array braceWith: 0 with:0  with: 0.
	boardCols  := Array braceWith: 0 with:0  with: 0.
	blockNumber := 0.
	verifyNumber := 0.
	
]

{ #category : #printing }
SudokuBlock >> printOn: aStream [

	aStream
		nextPutAll: self blockAsString; cr;
		nextPutAll: 'board rows: ';
		nextPutAll: boardRows  asString;cr;
		nextPutAll: 'board cols: ';
		nextPutAll: boardCols asString
]

{ #category : #accessing }
SudokuBlock >> row: rowIndex column: colIndex [

	^blockA2D at: rowIndex at: colIndex 
]

{ #category : #accessing }
SudokuBlock >> row: rowIndex column: colIndex put: aNumber [

	^blockA2D at: rowIndex at: colIndex put: aNumber
]

{ #category : #logic }
SudokuBlock >> toBoardCoordinatesRow: blockRow column: blockCol [
	"
	SudokuBlockken座標をSudokuBoard座標に変換しBoardCoordinatesのインスタンスとして返す
	"
	| coord |
	coord := MCoordinates new.
	coord row: (boardRows at: blockRow).
	coord column: (boardCols at: blockCol).
	
	^coord
]

{ #category : #accessing }
SudokuBlock >> verifyNumber [
	"
	ブロックの正しい配置セルを探す数字
	"
	
	^verifyNumber 
]

{ #category : #accessing }
SudokuBlock >> verifyNumber: anInteger [
	
	verifyNumber := anInteger 
]
