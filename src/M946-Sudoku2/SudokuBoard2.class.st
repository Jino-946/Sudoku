"
数独の盤面(ボード:9X9)全体を表現するクラス

Instance Variables
	boardA2D		<Array2D>  ボードの内部表現

   主なAPI
   セルのあるブロックを得る
```
   aSudokuBlock := aSudokuBoard atBlock: aSudokuCell blockNumber
```		
   セルのある行を得る
```
   aSudokuRow := aSudokuBoard atSudokuRow: aSudokuCell rowIndex
```
   セルのある列を得る
```
   aSudokuColumn := aSudokuBoard atSudokuColumn: aSudokuCell colIndex
```
"
Class {
	#name : #SudokuBoard2,
	#superclass : #Object,
	#instVars : [
		'boardA2D'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #comparing }
SudokuBoard2 >> = sudokuBoard [

	^ sudokuBoard class == self class
		and: [ sudokuBoard boardA2D  = self boardA2D ] 

]

{ #category : #'private - accessing' }
SudokuBoard2 >> _getBlock: rowStart at: colStart [
	" private
	数独ボード(9X9)より行の開始位置(rowStart)と列の開始位置(colStart)を指定して
	ブロック(3X3)を取り出す。
	rowStartとcolStartの組み合わせ(rowStart-colStart)は次の9通りだが
	 	1-1 1-4 1-7
	 	4-1 4-4 4-7
	 	7-1 7-4 7-7
	組み合わせの整合性はチェックは行わないのでatBlock:を使用することにより引数の
	整合性を担保する。	
	また、blockNumberはセットされないので注意すること！
	"

	| block rs cs |
	rs := rowStart.
	cs := colStart.
	block := SudokuBlock2 new.

	block rowsOnBoard
		at: 1 put: (SudokuRow new: rs row: (self atRow: rs));
		at: 2 put: (SudokuRow new: rs + 1 row: (self atRow: rs + 1));
		at: 3 put: (SudokuRow new:  rs + 2 row: (self atRow: rs + 2)).



	block colsOnBoard
		at: 1 put: (SudokuColumn new: cs column: (self atColumn: cs));
		at: 2 put: (SudokuColumn new: cs + 1 column: (self atColumn: cs + 1));
		at: 3 put: (SudokuColumn new: cs + 2 column: (self atColumn: cs + 2)).


	block blockA2D
		at: 1 at: 1 put: (boardA2D  at: rs at: cs);
		at: 1 at: 2 put: (boardA2D  at: rs at: cs + 1);
		at: 1 at: 3 put: (boardA2D  at: rs at: cs + 2);
		at: 2 at: 1 put: (boardA2D  at: rs + 1 at: cs);
		at: 2 at: 2 put: (boardA2D  at: rs + 1 at: cs + 1);
		at: 2 at: 3 put: (boardA2D  at: rs + 1 at: cs + 2);
		at: 3 at: 1 put: (boardA2D  at: rs + 2 at: cs);
		at: 3 at: 2 put: (boardA2D  at: rs + 2 at: cs + 1);
		at: 3 at: 3 put: (boardA2D  at: rs + 2 at: cs + 2).

	^ block
]

{ #category : #'private - printing' }
SudokuBoard2 >> asString [

	| aStream separateIndices |
	separateIndices := #( 3 6 ).
	aStream := ReadWriteStream on: String new.
	aStream cr.
	1 to: 9 do: [ :rowIndex |
		1 to: 9 do: [ :colIndex | |number|
			number := self boardA2D  at: rowIndex at: colIndex.	
			number class = Character ifTrue: [ number := '$', number asString ].
			number class = SudokuCell ifTrue: [ number := number asSpecialString  ].
			aStream nextPutAll: number asString; tab.
			(separateIndices includes: colIndex)
			ifTrue:[ aStream space; space; space]].
		aStream cr.
		(separateIndices includes: rowIndex )
		ifTrue: [ aStream  cr]
	].
	
	^aStream contents 
]

{ #category : #accessing }
SudokuBoard2 >> atColumn: colIndex [
	"
	boardA2DよりcolIndexで指定した列を返す。
	"

	^ boardA2D atColumn: colIndex
]

{ #category : #accessing }
SudokuBoard2 >> atRow: rowIndex [
	"
	boardA2DよりrowIndexで指定した行を返す。
	"

	^ boardA2D  atRow: rowIndex
]

{ #category : #accessing }
SudokuBoard2 >> boardA2D [

	^ boardA2D 
]

{ #category : #logic }
SudokuBoard2 >> clearMarks [
	"
	AnyWay実装に$X,$1-$9などのマークをboardA2Dに直接書き込むようになったので、
	不要になったら消すためのメソッド
	"
	1 to: 9 do: [ :i |
		1 to: 9 do: [ :j |
			(boardA2D at: i at: j) class = Character ifTrue: [
				boardA2D at: i at: j put: 0 ] ] ]
]

{ #category : #'as yet unclassified' }
SudokuBoard2 >> clearPairCells [

	1 to: 9 do: [ :i |
		1 to: 9 do: [ :j |
			(boardA2D at: i at: j) class = SudokuPairCell  ifTrue: [
				boardA2D at: i at: j put: 0 ] ] ]
]

{ #category : #logic }
SudokuBoard2 >> completed [
	"
	数独問題を解けたか判定する
	"
	1 to: 9 do: [ :number | 
		(self getBlock: number) completed 
		ifFalse: [ ^false ].
		(self getSudokuColumn:  number) completed 
		ifFalse: [ ^false ].
		(self getSudokuRow:  number) completed 
		ifFalse: [ ^false ].	
	].
	^ true
]

{ #category : #creation }
SudokuBoard2 >> getBlock: blockNumber [
	"
	数独ボード(9X9)よりblockNumberを指定してブロック(3X3)を取り出す。
	
	数独ボード
	1 2 3  4 5 6  7 8 9
	2 3 4  5 6 7  8 9 1 
	3 4 5  6 7 8  9 1 2
	
	4 5 6  7 8 9  1 2 3
	5 6 7  8 9 1  2 3 4
	6 7 8  9 1 2  3 4 5
	
	7 8 9  1 2 3  4 5 6
	8 9 1  2 3 4  5 6 7 
	9 1 2  3 4 5  6 7 8	
	
	数独ボード(9X9)とblockNumberの位置関係	
	ブロック(ナンバー)
	 B1  B2  B3
	 B4  B5  B6
	 B7  B8  B9	
	"
	| block |
	block := SudokuBlock2 new.
	blockNumber = 1 ifTrue: [
		block := (self _getBlock: 1 at: 1) blockNumber: blockNumber ].
	blockNumber = 2 ifTrue: [
		block := (self _getBlock: 1 at: 4) blockNumber: blockNumber ].
	blockNumber = 3 ifTrue: [
	 	block := (self _getBlock:  1 at: 7) blockNumber: blockNumber ].
	blockNumber = 4 ifTrue: [
		block := (self _getBlock: 4 at: 1) blockNumber: blockNumber ].
	blockNumber = 5 ifTrue: [
		block := (self _getBlock: 4 at: 4) blockNumber: blockNumber ].
	blockNumber = 6 ifTrue: [
		block := (self _getBlock: 4 at: 7) blockNumber: blockNumber ].
	blockNumber = 7 ifTrue: [
		block := (self _getBlock: 7 at: 1) blockNumber: blockNumber ].
	blockNumber = 8 ifTrue: [
		block :=  (self _getBlock: 7 at: 4) blockNumber: blockNumber ].
	blockNumber = 9 ifTrue: [
		block := (self _getBlock: 7 at: 7) blockNumber: blockNumber ].
	
	self setEitherCells: block.	
	^block
	

]

{ #category : #creation }
SudokuBoard2 >> getBlock: bNum verifyNumber: vNum [

	| block |
	block := self getBlock: bNum.
	^ block verifyNumber: vNum
]

{ #category : #accessing }
SudokuBoard2 >> getCellRow: rowIndex cellColumn: colIndex [

	^SudokuCell row: rowIndex column: colIndex element: (boardA2D at: rowIndex at: colIndex )
]

{ #category : #accessing }
SudokuBoard2 >> getSudokuCell: aPoint [

	
	^ self getCellRow: aPoint y cellColumn: aPoint x.

]

{ #category : #creation }
SudokuBoard2 >> getSudokuColumn: colIndex [
	"
	colIndex で指定した行を SudokuColumn に変換して返す
	"
	^SudokuColumn new: colIndex column: (self atColumn: colIndex)

]

{ #category : #creation }
SudokuBoard2 >> getSudokuRow: rowIndex [
	"
	rowIndex で指定した行を SudokuRow に変換して返す
	"
	^SudokuRow new: rowIndex row: (self atRow: rowIndex)
]

{ #category : #comparing }
SudokuBoard2 >> hash [ 

	^ boardA2D   hash
]

{ #category : #initialization }
SudokuBoard2 >> initialize [ 

	super initialize .
	boardA2D  := Array2D new:9 element: 0.
]

{ #category : #'initialization - data' }
SudokuBoard2 >> loadFromString: aString [
	"
	数独問題(String)を数独ボードデータへ(Array2D)へコピーする。
	aString は可読性を高めるためにスペース,タブ,改行を自由に使うことができる。
	parseLiterals 
	"
	| i j |

	i := 0.
	j := 0.
	
	aString  parseLiterals  do: [ :e | 
		boardA2D at: i // 9 + 1 at: j % 9 + 1 put: e.
		i := i + 1.
		j := j + 1.
 	]

"
  aString := '
  1 9 7  0 0 4  2 0 5
  6 8 0  5 3 0  9 0 0
  5 0 3  0 7 2  1 6 8
	
  0 6 0  4 0 9  7 0 2 
  0 7 5  0 1 0  6 8 0
  2 0 9  8 0 7  0 4 0
	
  7 5 6  3 2 0  4 0 1
  0 0 1  0 4 5  0 2 6 
  8 0 4  1 0 0  3 5 7
'
"
]

{ #category : #accessing }
SudokuBoard2 >> map:  sudokuItem [
	"
	SudokuCell, SudokuRow, SudokuColumn, SudokuBlock2 をボードにマッピングする。
	"
	"
	sudokuItem class = SudokuCell ifTrue: [  
		boardA2D at: sudokuItem  rowIndex  at: sudokuItem  colIndex  put: sudokuItem  element ].
	"
	sudokuItem class = SudokuCell ifTrue: [ 
		sudokuItem possibleNumbers isEmpty 
			ifTrue: [  
				boardA2D at: sudokuItem  rowIndex  at: sudokuItem  colIndex  put: sudokuItem  element]
			ifFalse: [  
				 boardA2D at: sudokuItem  rowIndex  at: sudokuItem  colIndex  put: sudokuItem ]].
	
	sudokuItem class = SudokuRow ifTrue: [  
		1 to: 9 do: [ :i | 
			boardA2D at: sudokuItem rowIndex at: i put: (sudokuItem row at: i) ]].

	sudokuItem class = SudokuColumn ifTrue: [  
		1 to: 9 do: [ :i |
			boardA2D at: i at: sudokuItem colIndex put: (sudokuItem column at: i)]].
	
	sudokuItem class = SudokuBlock2 ifTrue: [ 
		self mapSudokuBlock2: sudokuItem ].
	
	sudokuItem class = SudokuPairCell ifTrue: [ 
		self mapSudokuPairCell: sudokuItem ]

	
]

{ #category : #'accessing - private' }
SudokuBoard2 >> mapSudokuBlock2: sudokuBlock [
	"
	sudokuBlock2をボードにマッピングする 
	"
	| rowIndex colIndex item |
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j | 
			rowIndex := sudokuBlock rowIndexOnBoard: i.
			colIndex := sudokuBlock colIndexOnBoard: j.
			item := sudokuBlock row: i column: j.
			boardA2D at: rowIndex at: colIndex put: item.
		]	
 	]
]

{ #category : #accessing }
SudokuBoard2 >> mapSudokuCell: sudokuCell [
	"
	sudokuCellの座標で示されるセル値のクラスがSudokuPairCellの時、片方のペアの数字が決まると
	もう一方の数字が自動的に決定する動作を実装した。
	"
	| pairCell rIndex cIndex logger |
	logger := M946Logger new: LogLevel info.
	logger debug: thisContext.
	logger debug: (boardA2D at: sudokuCell rowIndex at: sudokuCell colIndex) class.
	(boardA2D at: sudokuCell rowIndex at: sudokuCell colIndex) class= SudokuPairCell ifTrue: [ 
		pairCell := boardA2D at: sudokuCell rowIndex at: sudokuCell colIndex.
		rIndex := pairCell otherCell rowIndex.
		cIndex := pairCell otherCell colIndex.
		boardA2D at: rIndex at: cIndex put: (pairCell pairOfNumbers at: 1)].
	
	boardA2D
		at: sudokuCell rowIndex
		at: sudokuCell colIndex
		put: sudokuCell element.


]

{ #category : #accessing }
SudokuBoard2 >> mapSudokuPairCell: aPairCell [

	| rowIndex colIndex |
	rowIndex := aPairCell thisCell rowIndex.
	colIndex := aPairCell thisCell colIndex.
	boardA2D at: rowIndex at: colIndex put: aPairCell 
]

{ #category : #printing }
SudokuBoard2 >> printOn: aStream [

	aStream nextPutAll: self asString 
]

{ #category : #initialization }
SudokuBoard2 >> setEitherCells: block [

	| charDigits |
	charDigits := #($1 $2 $3 $4 $5 $6 $7 $8 $9).
	1 to: 3 do: [ :i |
		1 to: 3 do: [ :j | | char rowIndex colIndex |
			char := block blockA2D at: i at: j.
			(charDigits includes: char)	ifTrue: [ 
				rowIndex := block rowIndexOnBoard: i.
				colIndex := block colIndexOnBoard: j.
				block eitherCells add: (SudokuCell row: rowIndex column: colIndex element: char )	]]]
	
]
