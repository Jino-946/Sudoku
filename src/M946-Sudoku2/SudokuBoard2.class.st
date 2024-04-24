"
数独の盤面(ボード:9X9)全体を表現するクラス

    Instance Variables
	boardA2D		<Array2D>  ボードの内部表現


    Implementation Points
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
SudokuBoard2 >> _atBlock: rowStart at: colStart [
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

{ #category : #'private - accessing' }
SudokuBoard2 >> _atHorGroup: rowStart at: colStart [

	| hGroup rs cs |
	rs := rowStart.
	cs := colStart.
	hGroup := HorBlockGroup  new.

	hGroup rowsOnBoard
		at: 1 put: (SudokuRow new: rs row: (self atRow: rs));
		at: 2 put: (SudokuRow new: rs + 1 row: (self atRow: rs + 1));
		at: 3 put: (SudokuRow new:  rs + 2 row: (self atRow: rs + 2)).

	^hGroup 
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
			aStream nextPutAll: number asString; tab.
			(separateIndices includes: colIndex)
			ifTrue:[ aStream  tab]].
		aStream cr.
		(separateIndices includes: rowIndex )
		ifTrue: [ aStream  cr;cr ]
	].
	
	^aStream contents 
]

{ #category : #accessing }
SudokuBoard2 >> atBlock: blockNumber [
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

	blockNumber = 1 ifTrue: [
		^ (self _atBlock: 1 at: 1) blockNumber: blockNumber ].
	blockNumber = 2 ifTrue: [
		^ (self _atBlock: 1 at: 4) blockNumber: blockNumber ].
	blockNumber = 3 ifTrue: [
		^ (self _atBlock:  1 at: 7) blockNumber: blockNumber ].

	blockNumber = 4 ifTrue: [
		^ (self _atBlock: 4 at: 1) blockNumber: blockNumber ].
	blockNumber = 5 ifTrue: [
		^ (self _atBlock: 4 at: 4) blockNumber: blockNumber ].
	blockNumber = 6 ifTrue: [
		^ (self _atBlock: 4 at: 7) blockNumber: blockNumber ].

	blockNumber = 7 ifTrue: [
		^ (self _atBlock: 7 at: 1) blockNumber: blockNumber ].
	blockNumber = 8 ifTrue: [
		^ (self _atBlock: 7 at: 4) blockNumber: blockNumber ].
	blockNumber = 9 ifTrue: [
		^ (self _atBlock: 7 at: 7) blockNumber: blockNumber ]
	

]

{ #category : #accessing }
SudokuBoard2 >> atColumn: colIndex [
	"
	boardよりcolIndexで指定した列を返す。
	"

	^ boardA2D atColumn: colIndex
]

{ #category : #accessing }
SudokuBoard2 >> atHorGroup: groupNumber [
	"
	数独ボード(9X9)よりgroupNumberを指定して(3X3)を取り出す。
	
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
	
	数独ボード(9X9)とgroupNumberの位置関係	
	ブロック(ナンバー)
	 G1
	 G2
	 G3
	"

	groupNumber = 1 ifTrue: [
		^ (self _atHorGroup: 1 at: 1) groupNumber: groupNumber ].

	groupNumber = 2 ifTrue: [
		^ (self _atHorGroup: 4 at: 1) groupNumber: groupNumber ].

	groupNumber = 3 ifTrue: [
		^ (self _atHorGroup: 7 at: 1) groupNumber: groupNumber ].

]

{ #category : #accessing }
SudokuBoard2 >> atRow: rowIndex [
	"
	boardよりrowIndexで指定した行を返す。
	"

	^ boardA2D  atRow: rowIndex
]

{ #category : #accessing }
SudokuBoard2 >> boardA2D [

	^ boardA2D 
]

{ #category : #logic }
SudokuBoard2 >> completed [
	"
	数独問題を解けたか判定する
	"
	1 to: 9 do: [ :blockNumber | 
		(self atBlock: blockNumber) completed 
		ifFalse: [ ^false ]
	].
	^ true
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
	"
	| i j |

	i := 0.
	j := 0.
	
	aString parseLiterals do: [ :e | 
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
SudokuBoard2 >> map:  aSudokuCell [
	"
	sudokuCellをボードにマッピングする。
	"
	boardA2D at: aSudokuCell rowIndex  at: aSudokuCell colIndex  put: aSudokuCell element 

	
]

{ #category : #printing }
SudokuBoard2 >> printOn: aStream [

	aStream nextPutAll: self asString 
]
