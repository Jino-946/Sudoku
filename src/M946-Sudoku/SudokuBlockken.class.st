"
数独ボード構成する9個のブロックを表現するクラス。
""Blockken""とは""Block見""の駄洒落

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
	#name : #SudokuBlockken,
	#superclass : #Object,
	#instVars : [
		'blockkenA2D',
		'boardRows',
		'boardCols',
		'blockNumber',
		'verifyNumber'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
SudokuBlockken >> = aSudokuBlockken [

	^ aSudokuBlockken class == self class
		and: [ aSudokuBlockken blockkenA2D = self blockkenA2D 
				and: [ aSudokuBlockken boardRows = self boardRows 
					and: [ aSudokuBlockken boardCols = self boardCols 
						and: [ aSudokuBlockken blockNumber = self blockNumber
							and: [aSudokuBlockken verifyNumber = self verifyNumber ] ]]]]
	
]

{ #category : #accessing }
SudokuBlockken >> blockNumber [

	^blockNumber 
]

{ #category : #accessing }
SudokuBlockken >> blockNumber: aNumber [

	blockNumber := aNumber
]

{ #category : #accessing }
SudokuBlockken >> blockkenA2D [

	^blockkenA2D
]

{ #category : #'private - helpers' }
SudokuBlockken >> blockkenAsString [
	"
	Array2D >> printOn: による表示乱れを解消する為のヘルパーメソッド	
	"
	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'Block '; nextPutAll: blockNumber asString;cr.
	aStream nextPutAll: '検証数字:'; nextPutAll: verifyNumber asString;cr.
	aStream nextPutAll: '========='; cr. 
	(1 to: blockkenA2D  numberOfRows)
		do: [ :r |
				(blockkenA2D  atRow: r)
					do: [ :each | aStream print: each ]
					separatedBy: [ aStream tab ]]
		separatedBy: [ aStream cr].
	aStream cr; nextPutAll: '========='.
	
	^aStream contents

	
]

{ #category : #accessing }
SudokuBlockken >> boardCols [
	"blockkenの列のindex(1-3)に対応するSudokuBoardのindex配列を返す"
	^boardCols 
]

{ #category : #accessing }
SudokuBlockken >> boardRows [
	"blockkenの行のindex(1-3)に対応するSudokuBoardのindex配列を返す"
	^boardRows 
]

{ #category : #comparing }
SudokuBlockken >> hash [ 

	^((((blockkenA2D hash bitXor: boardRows hash )
			bitXor: boardCols hash) 
				bitXor: blockNumber hash)
					bitXor: verifyNumber  hash)
					
		
]

{ #category : #initialization }
SudokuBlockken >> initialize [ 

	super initialize .
	blockkenA2D := Array2D new:  3 element: 0.
	boardRows  := Array braceWith: 0 with:0  with: 0.
	boardCols  := Array braceWith: 0 with:0  with: 0.
	blockNumber := 0.
	verifyNumber := 0.
	
]

{ #category : #printing }
SudokuBlockken >> printOn: aStream [

	aStream
		nextPutAll: self blockkenAsString; cr;
		nextPutAll: 'board rows: ';
		nextPutAll: boardRows  asString;cr;
		nextPutAll: 'board cols: ';
		nextPutAll: boardCols asString
]

{ #category : #accessing }
SudokuBlockken >> row: rowIndex column: colIndex [

	^blockkenA2D at: rowIndex at: colIndex 
]

{ #category : #accessing }
SudokuBlockken >> row: rowIndex column: colIndex put: aNumber [

	^blockkenA2D at: rowIndex at: colIndex put: aNumber
]

{ #category : #logic }
SudokuBlockken >> toBoardCoordinatesRow: blockRow column: blockCol [
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
SudokuBlockken >> verifyNumber [
	"
	ブロックの正しい配置セルを探す数字
	"
	
	^verifyNumber 
]

{ #category : #accessing }
SudokuBlockken >> verifyNumber: anInteger [
	
	verifyNumber := anInteger 
]
