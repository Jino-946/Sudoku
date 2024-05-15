"
数独ボード(SudokuBoard2)の水平に並ぶ3つのブロックをグループとして表現するクラス

[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方④]」の実装に利用します。

	Instance Variables.
	sudokuBoard    <SudokuBoard2>    グループのコンテナ
	groupNumber		<SmallInteger>		グループ番号
	groupA2D		<Array2D>			グループの内部表現
	verifyNumber	<SmallInteger>		検証数値
	-- deplicated ---
	rowsOnBoard		<Array>				ブロックの行インデックスに対応するボード上の行(SudokuRow)の配列
	colsOnBoard		<Array>				ブロックの列インデックスに対応するボード上の列(SudokuColumn)の配列
				
"
Class {
	#name : #SudokuHorGroup,
	#superclass : #Object,
	#instVars : [
		'groupNumber',
		'sudokuBoard',
		'groupA2D',
		'verifyNumber',
		'rowsOnBoard',
		'colsOnBoard'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'instance creation' }
SudokuHorGroup class >> new: sudokuBoard [
	| horGroup |
	horGroup := self  new.
	^ horGroup sudokuBoard: sudokuBoard 
	
	
]

{ #category : #converting }
SudokuHorGroup >> asString [

	| aStream elem |
	aStream := ReadWriteStream on: String new.
	aStream
		cr;
		nextPutAll: ' groupNumber: ';
		print: groupNumber;
		cr.
	1 to: 3 do: [ :i |
		1 to: 9 do: [ :j |
			elem := groupA2D at: i at: j.
			elem class = SmallInteger ifTrue: [ aStream space ].
			aStream print: elem.
			j - 1 % 3 = 2
				ifTrue: [ aStream tab ]
				ifFalse: [ aStream nextPutAll: ' ' ] ].
		aStream cr ].

	^ aStream contents
]

{ #category : #accessing }
SudokuHorGroup >> atBlock: number [
	"

	"

	|  blockNumber block |
	blockNumber := (groupNumber - 1) * 3 + number.
	block := sudokuBoard atBlock: blockNumber.
	block verifyNumber: verifyNumber.
	^ block
"
	block := SudokuBlock2 new.
	startIndex := 0.
	blockNumber := 0.
	number = 1 ifTrue: [ startIndex := 0 ].
	number = 2 ifTrue: [ startIndex := 3 ].
	number = 3 ifTrue: [ startIndex := 6 ].

	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j |
		block blockA2D  at: i at: j put: (groupA2D at: i at: startIndex + j) ] ].




	blockNumber := (groupNumber - 1) * 3 + number.
	block
		blockNumber: blockNumber;
		verifyNumber: verifyNumber.
"

]

{ #category : #accessing }
SudokuHorGroup >> atSudokuColumn: colIndex [
	"
	colIndex(1-9)のSudokuColumnを返す
	"

	^ sudokuBoard atSudokuColumn: colIndex 
]

{ #category : #accessing }
SudokuHorGroup >> atSudokuRow: rowIndex [
	"
	rowIndex(1-3)をSudokuBoard2のインデックスに変換しSudokuRowを返す
	"
	|baseIndex|
	baseIndex := 0.
	groupNumber = 1 ifTrue: [ baseIndex := 0 ].
	groupNumber = 2 ifTrue: [ baseIndex := 3 ].
	groupNumber = 3 ifTrue: [ baseIndex := 6 ].
	
	^ sudokuBoard atSudokuRow: baseIndex + rowIndex 
]

{ #category : #accessing }
SudokuHorGroup >> colsOnBoard [ 

	^colsOnBoard 
]

{ #category : #accessing }
SudokuHorGroup >> groupA2D [

	^ groupA2D 
]

{ #category : #accessing }
SudokuHorGroup >> groupNumber [

	^groupNumber 
]

{ #category : #accessing }
SudokuHorGroup >> groupNumber: number [

	groupNumber := number
]

{ #category : #initialization }
SudokuHorGroup >> initialize [ 

	super initialize .
	
	groupA2D := Array2D rows: 3 columns: 9 .
	groupNumber := 0.
	verifyNumber := 0.
		
	rowsOnBoard := Array new: 3.
	colsOnBoard := Array new: 9.

	
]

{ #category : #printing }
SudokuHorGroup >> printOn: aStream [

	aStream
		nextPutAll: self asString; cr.
]

{ #category : #accessing }
SudokuHorGroup >> rowsOnBoard [ 

	^rowsOnBoard 
]

{ #category : #accessing }
SudokuHorGroup >> sudokuBoard: board [

	sudokuBoard := board.
]

{ #category : #accessing }
SudokuHorGroup >> verifyNumber [

	^verifyNumber 
]

{ #category : #accessing }
SudokuHorGroup >> verifyNumber: number [

	verifyNumber := number 
	
]
