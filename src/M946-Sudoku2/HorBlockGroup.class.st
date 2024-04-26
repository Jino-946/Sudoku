"
数独ボード(SudokuBoard2)の水平に並ぶ3つのブロックをグループとして表現するクラス

[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方④]」の実装に利用します。

	Instance Variables.
	groupNumber		<SmallInteger>		グループ番号
	rowsOnBoard		<Array>				ブロックの行インデックスに対応するボード上の行(SudokuRow)の配列
	verifyNumber	<SmallInteger>		検証数値
				
"
Class {
	#name : #HorBlockGroup,
	#superclass : #Object,
	#instVars : [
		'groupNumber',
		'rowsOnBoard',
		'verifyNumber'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #converting }
HorBlockGroup >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: ' groupNumber: '; print: groupNumber ;cr.
	rowsOnBoard do: [ :sudokuRow|
		sudokuRow row doWithIndex: [ :num :index |
			num class = SmallInteger ifTrue: [ aStream space  ].
			aStream print: num.
			(((index - 1) % 3 ) = 2)
			ifTrue: [ aStream tab]
			ifFalse: [ aStream nextPutAll: ' ' ].
		].
		aStream cr.		
	].

	^aStream contents 
]

{ #category : #accessing }
HorBlockGroup >> atBlock: number [

	| startCol blockNumber block row |
	block := SudokuBlock2 new.
	startCol := 10.
	blockNumber  := 0.
	number = 1
		ifTrue: [ startCol := 0.
			]
		ifFalse: [
			number = 2
				ifTrue: [ startCol := 3 ]
				ifFalse: [ number = 3 ifTrue: [ startCol := 6 ] ] ].
	1 to: 3 do: [ :i |
		row := rowsOnBoard at: i.
		1 to: 3 do: [ :j | block row: i column: j put: (row at: j + startCol) ] ].
	blockNumber := (groupNumber - 1) * 3 + number.
	block blockNumber: blockNumber; verifyNumber: verifyNumber .

	^block 
]

{ #category : #accessing }
HorBlockGroup >> groupNumber [

	^groupNumber 
]

{ #category : #accessing }
HorBlockGroup >> groupNumber: number [

	groupNumber := number
]

{ #category : #initialization }
HorBlockGroup >> initialize [ 

	super initialize .
	rowsOnBoard := Array new: 3.
	verifyNumber := 0.
	
]

{ #category : #printing }
HorBlockGroup >> printOn: aStream [

	aStream
		nextPutAll: self asString; cr.
]

{ #category : #accessing }
HorBlockGroup >> rowsOnBoard [ 

	^rowsOnBoard 
]

{ #category : #accessing }
HorBlockGroup >> verifyNumber [

	^verifyNumber 
]

{ #category : #accessing }
HorBlockGroup >> verifyNumber: number [

	verifyNumber := number 
	
]
