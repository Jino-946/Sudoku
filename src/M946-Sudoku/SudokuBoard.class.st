"
9行X9列のセルを持つ数独ボードを表現するクラス。

インスタンス変数
	board:		<Array2D>   数独ボードの内部表現
			
データ初期化メソッド
- loadFromString: aString
   数独問題(String)を数独ボードデータへ(Array2D)へコピーする。
   aString は可読性を高めるためにスペース,タブ,改行を自由に使うことができる。
   <使い方>
   board := SudokuBoard new.
   board loadFromString: aString.

主なインスタンス・メソッド  (logic)
- blockAt: aNumber
    数独ボード(9X9)よりblockNumber(1-9)で指定したブロック(3X3)を返す。
     
- colsAt: colIndex
    数独ボードよりcolIndexで指定した列の要素を行を串刺しにした配列にして返す
     
- rowsAt: rowIndex
    数独ボードよりrowIndexで指定した行配列を返す。
    
- put: returnValue 
   SudokuBlock >> tsumoの戻値であるところの座標と数値を要素とする配列を引数にとり、ボードにセットする。
    	
- sujiYomi: aBlock
   対象となる他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印にしている。
   
   rowSuji:とcolumnSuji:を利用して検証数値が重複するブロックのセルにXを配置する。
   ブロックにブランクセルが一つだけの時は、ボードのセルに検証数値を配置する。
    (麻雀用語:スジ)
   
- columnSuji: aBlock
   ブロック列のインデックスをボード列のインデックスに変換して,ボード列をスキャンし検証数値を探す。
   スキャンしたボード列に検証数値があった時、ブロックのブロック列のブランクセルにXを配置する。
   (麻雀用語:スジ)
   
- rowSuji: aBlock
   ブロック行のインデックスをボード行のインデックスに変換して,ボード行をスキャンし検証数値を探す。
   スキャンしたボード行に検証数値があった時、ブロックのブロック行のブランクセルにXを配置する。   
   (麻雀用語:スジ)
         	
- letsMe: colIndex
    未実装
    colIndexの列要素の配列を走査しブランクセルが一つの場合ブランクセルを未使用の数字で埋める。
    列見(れつみ) - letsMe: lets'me  の駄洒落
     
- gyoMe: rowIndex
   未実装
   rowIndexの行配列を走査しブランクセルが一つの場合ブランクセルを未使用の数字で埋める。
   行見(ぎょうみ) - gyoMe: letsMe とのペア
   


"
Class {
	#name : #SudokuBoard,
	#superclass : #Object,
	#instVars : [
		'board',
		'numberCounter'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
SudokuBoard >> = aBoard [

	^ aBoard class == self class
		and: [ aBoard board = self board 
			and: [aBoard numberCounter = self numberCounter]] 

]

{ #category : #accessing }
SudokuBoard >> at: coordinates put: anInteger [

	self row: coordinates row column: coordinates column put: anInteger
]

{ #category : #logic }
SudokuBoard >> blockAt: aNumber [
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
	ブロック
	 1  2  3
	 4  5  6
	 7  8  9	
	"

	aNumber = 1 ifTrue: [
		^ (self privateBlockAt: 1 at: 1) blockNumber: aNumber ].
	aNumber = 2 ifTrue: [
		^ (self privateBlockAt: 1 at: 4) blockNumber: aNumber ].
	aNumber = 3 ifTrue: [
		^ (self privateBlockAt: 1 at: 7) blockNumber: aNumber ].

	aNumber = 4 ifTrue: [
		^ (self privateBlockAt: 4 at: 1) blockNumber: aNumber ].
	aNumber = 5 ifTrue: [
		^ (self privateBlockAt: 4 at: 4) blockNumber: aNumber ].
	aNumber = 6 ifTrue: [
		^ (self privateBlockAt: 4 at: 7) blockNumber: aNumber ].

	aNumber = 7 ifTrue: [
		^ (self privateBlockAt: 7 at: 1) blockNumber: aNumber ].
	aNumber = 8 ifTrue: [
		^ (self privateBlockAt: 7 at: 4) blockNumber: aNumber ].
	aNumber = 9 ifTrue: [
		^ (self privateBlockAt: 7 at: 7) blockNumber: aNumber ]
]

{ #category : #accessing }
SudokuBoard >> board [

	^board 
]

{ #category : #'private - helpers' }
SudokuBoard >> boardAsString [
	"
	Array2D >> printOn: による表示乱れを解消する為のヘルパーメソッド	
	"
	| aStream separateIndices |
	separateIndices := #( 3 6 ).
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'SUDOKU Board'; cr.
	aStream nextPutAll: '---------------------------------------';cr.
	1 to: 9 do: [ :rowIndex |
		1 to: 9 do: [ :colIndex | |number|
			number := self board at: rowIndex at: colIndex.	
			aStream nextPutAll: number asString; tab.
			"
			number = 0
			ifTrue: [ aStream nextPutAll: '_'; tab ]
			ifFalse: [aStream nextPutAll: number asString; tab] .
			"
			(separateIndices includes: colIndex)
			ifTrue:[ aStream  tab]].
		aStream cr.
		(separateIndices includes: rowIndex )
		ifTrue: [ aStream  cr;cr ]
	].
	
	^aStream contents 
]

{ #category : #logic }
SudokuBoard >> colsAt: colIndex [
	"
	boardよりcolIndex指定した列の要素を行を上から串刺しにした配列にして返す
	"
	| result |
	result := Array new: 9 withAll: 0.
	
	1 to: 9 do: [ :rowIndex | result at: rowIndex  put: (board at: rowIndex at: colIndex) ].
	
	^result
]

{ #category : #'private - logics' }
SudokuBoard >> columnSuji: aBlock [
	"
	他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印とする。
		
	#1)ブロック列のインデックスをボード列のインデックスに変換して,(#2)ボード列をスキャンし検証数値を探す。
	#3)スキャンしたボード列に検証数値があった時、(#4)ブロックのブロック列のブランクセルにXを配置する。

 	(麻雀用語:スジ)
	"
	1 to: 3 do: [ :indexOfBlock|
		| indexOfBoard cols |
		indexOfBoard := aBlock colsOfBoard at: indexOfBlock . "#1"
		cols := self colsAt: indexOfBoard .
		(cols includes: aBlock verifyNumber) "#2"
		ifTrue: [  "#3"
			1 to: 3 do: [ :ri |
				(aBlock row: ri  column: indexOfBlock) = aBlock blankCell "#4"
				ifTrue: [ aBlock row: ri  column: indexOfBlock  put: $X ]	
			]
		].
	].

]

{ #category : #comparing }
SudokuBoard >> hash [ 

	^ (board  hash bitXor: numberCounter  hash )
]

{ #category : #initialization }
SudokuBoard >> initialize [ 

	super initialize .
	board := Array2D new:9 element: 0.
	numberCounter := NumberCounter new.
]

{ #category : #'initialization - data' }
SudokuBoard >> loadExample: anArray [
	"
	2次元配列の数独問題データ(anArray)を数独ボードデータへ(Array2D)へコピーする
	"
	1 to: 9 do:[ :i | |row|
		row := anArray at:i.
		row doWithIndex: [ :num :j | board at: i at: j put: num ]
	].
	numberCounter boardOf: board. 
" example0

#(  #(1 9 7   0 0 4   2 0 5) 
	#(6 8 0   5 3 0   9 0 0) 
	#(5 0 3   0 7 2   1 6 8)
	
	#(0 6 0   4 0 9   7 0 2) 
	#(0 7 5   0 1 0   6 8 0) 
	#(2 0 9   8 0 7   0 4 0) 
	
	#(7 5 6   3 2 0   4 0 1) 
	#(0 0 1   0 4 5   0 2 6) 
	#(8 0 4   1 0 0   3 5 7))

"
]

{ #category : #'initialization - data' }
SudokuBoard >> loadFromString: aString [
	"
	数独問題(String)を数独ボードデータへ(Array2D)へコピーする。
	aString は可読性を高めるためにスペース,タブ,改行を自由に使うことができる。
	"
	| i j |

	i := 0.
	j := 0.
	
	aString asCamelCase do: [ :char |
		board at: i // 9 + 1 at: j % 9 + 1 put: char digitValue .	
		i := i + 1.
		j := j + 1
	].
	numberCounter boardOf: board .

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
SudokuBoard >> numberCounter [

	^numberCounter 
]

{ #category : #printing }
SudokuBoard >> printOn: aStream [

	aStream nextPutAll: self boardAsString 
]

{ #category : #'private - logics' }
SudokuBoard >> privateBlockAt: rowStart at: colStart [
	" private
	数独ボード(9X9)より行の開始位置(rowStart)と列の開始位置(colStart)を指定して
	ブロック(3X3)を取り出す。
	rowStartとcolStartの組み合わせ(rowStart-colStart)は次の9通りだが
	 	1-1 1-4 1-7
	 	4-1 4-4 4-7
	 	7-1 7-4 7-7
	組み合わせの整合性はチェックは行わないのでblockkenAt:を利用して引数の
	整合性を担保する。	
	また、blockNumberはセットされないので注意すること！
	"

	| block rs cs |
	rs := rowStart.
	cs := colStart.
	block := SudokuBlock new.

	block rowsOfBoard
		at: 1 put: rs;
		at: 2 put: rs + 1;
		at: 3 put: rs + 2.

	block colsOfBoard
		at: 1 put: cs;
		at: 2 put: cs + 1;
		at: 3 put: cs + 2.

	block blockA2D
		at: 1 at: 1 put: (board at: rs at: cs);
		at: 1 at: 2 put: (board at: rs at: cs + 1);
		at: 1 at: 3 put: (board at: rs at: cs + 2);
		at: 2 at: 1 put: (board at: rs + 1 at: cs);
		at: 2 at: 2 put: (board at: rs + 1 at: cs + 1);
		at: 2 at: 3 put: (board at: rs + 1 at: cs + 2);
		at: 3 at: 1 put: (board at: rs + 2 at: cs);
		at: 3 at: 2 put: (board at: rs + 2 at: cs + 1);
		at: 3 at: 3 put: (board at: rs + 2 at: cs + 2).

	^ block
]

{ #category : #logic }
SudokuBoard >> put: returnValue [
	"
	tsumoの戻値であるところの座標と数値を要素とする配列を引数にとり、ボードにセットする。
	"
	self at: (returnValue at:1) put: (returnValue at: 2)

]

{ #category : #accessing }
SudokuBoard >> row: rowIndex column: colIndex [
	"rowIndexとcolIndexで指定した位置のボードの値を返す	
	"
	^board at: rowIndex at: colIndex 
]

{ #category : #accessing }
SudokuBoard >> row: rowIndex column: colIndex put: aNumber [
	"
	rowIndexとcolIndexで指定した位置に値をセットする	
	"

	^board at: rowIndex at: colIndex put: aNumber
]

{ #category : #'private - logics' }
SudokuBoard >> rowSuji: aBlock [
	"
	他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印とする。
		
	#1)ブロック行のインデックスをボード行のインデックスに変換して,(#2)ボード行をスキャンし検証数値を探す。
	#3)スキャンしたボード行に検証数値があった時、(#4)ブロックのブロック行のブランクセルにXを配置する。

 	(麻雀用語:スジ)
	"
	1 to: 3 do: [ :indexOfBlock|
		| indexOfBoard row |
		indexOfBoard := aBlock rowsOfBoard at: indexOfBlock . "#1"
		row := self rowsAt: indexOfBoard . 
		(row includes: aBlock verifyNumber)  "#2"
		ifTrue: [  "#3"
			1 to: 3 do: [ :ci |
				(aBlock row: indexOfBlock  column: ci) = aBlock blankCell "#4"
				ifTrue: [ aBlock row: indexOfBlock  column: ci put: $X ]	
			]
		].
	].

]

{ #category : #logic }
SudokuBoard >> rowsAt: rowIndex [
	"
	boardよりrowIndex指定した行(列配列)を返す。
	"
	| result |
	result := Array new: 9 withAll: 0.
	
	1 to: 9 do: [ :colIndex | result at: colIndex put: (board at: rowIndex at: colIndex)].
	
	^result
]

{ #category : #examples }
SudokuBoard >> setDummy [

	#(1 2 3 4 5 6 7 8 9) doWithIndex:  [ :num :i | board at: 1 at: i put: num ].
	#(2 3 4 5 6 7 8 9 1) doWithIndex:  [ :num :i | board at: 2 at: i put: num ].
	#(3 4 5 6 7 8 9 1 2) doWithIndex:  [ :num :i | board at: 3 at: i put: num ].
	#(4 5 6 7 8 9 1 2 3) doWithIndex:  [ :num :i | board at: 4 at: i put: num ].
	#(5 6 7 8 9 1 2 3 4) doWithIndex:  [ :num :i | board at: 5 at: i put: num ].
	#(6 7 8 9 1 2 3 4 5) doWithIndex:  [ :num :i | board at: 6 at: i put: num ].
	#(7 8 9 1 2 3 4 5 6) doWithIndex:  [ :num :i | board at: 7 at: i put: num ].
	#(8 9 1 2 3 4 5 6 7) doWithIndex:  [ :num :i | board at: 8 at: i put: num ].
	#(9 1 2 3 4 5 6 7 8) doWithIndex:  [ :num :i | board at: 9 at: i put: num ].
	
	numberCounter boardOf: board .
]

{ #category : #examples }
SudokuBoard >> setExample0 [
	" https://www.nikoli.co.jp/ja/puzzles/sudoku/ 初級編動画の例題"

	#(1 9 7 0 0 4 2 0 5) doWithIndex:  [ :num :i | board at: 1 at: i put: num ].
	#(6 8 0 5 3 0 9 0 0) doWithIndex:  [ :num :i | board at: 2 at: i put: num ].
	#(5 0 3 0 7 2 1 6 8) doWithIndex:  [ :num :i | board at: 3 at: i put: num ].
	
	#(0 6 0 4 0 9 7 0 2) doWithIndex:  [ :num :i | board at: 4 at: i put: num ].
	#(0 7 5 0 1 0 6 8 0) doWithIndex:  [ :num :i | board at: 5 at: i put: num ].
	#(2 0 9 8 0 7 0 4 0) doWithIndex:  [ :num :i | board at: 6 at: i put: num ].
	
	#(7 5 6 3 2 0 4 0 1) doWithIndex:  [ :num :i | board at: 7 at: i put: num ].
	#(0 0 1 0 4 5 0 2 6) doWithIndex:  [ :num :i | board at: 8 at: i put: num ].
	#(8 0 4 1 0 0 3 5 7) doWithIndex:  [ :num :i | board at: 9 at: i put: num ].
	
	numberCounter boardOf: board .
]

{ #category : #examples }
SudokuBoard >> setExample1 [
	" https://www.nikoli.co.jp/ja/puzzles/sudoku/ の例題"

	#(8 0 0 0 0 5 1 0 0) doWithIndex:  [ :num :i | board at: 1 at: i put: num ].
	#(0 0 1 0 0 0 8 0 0) doWithIndex:  [ :num :i | board at: 2 at: i put: num ].
	#(0 4 0 2 0 0 0 9 0) doWithIndex:  [ :num :i | board at: 3 at: i put: num ].
	#(0 0 0 0 3 0 0 0 2) doWithIndex:  [ :num :i | board at: 4 at: i put: num ].
	#(1 2 3 4 0 6 7 8 9) doWithIndex:  [ :num :i | board at: 5 at: i put: num ].
	#(6 0 0 0 1 0 0 0 0) doWithIndex:  [ :num :i | board at: 6 at: i put: num ].
	#(0 8 0 0 0 9 0 5 0) doWithIndex:  [ :num :i | board at: 7 at: i put: num ].
	#(0 0 2 0 0 0 4 0 0) doWithIndex:  [ :num :i | board at: 8 at: i put: num ].
	#(0 0 7 6 0 0 0 0 1) doWithIndex:  [ :num :i | board at: 9 at: i put: num ].
	
	numberCounter boardOf: board .
]

{ #category : #logic }
SudokuBoard >> sujiYomi: aBlock [

	| coordinates |
	self rowSuji: aBlock.
	self columnSuji: aBlock.
	coordinates := nil.
	aBlock blockkenTenpai ifFalse: [ ^ self ].
	coordinates := aBlock bingo.
	self at: coordinates put: aBlock verifyNumber
]
