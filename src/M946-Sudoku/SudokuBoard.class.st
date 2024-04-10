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
    colIndexの列要素の配列を走査しブランクセルが一つの場合ブランクセルを未使用の数字で埋める。
    列見(れつみ) - letsMe: lets'me  の駄洒落
     
- gyoMe: rowIndex
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

{ #category : #'sudoku - task' }
SudokuBoard class >> advancedTasks240410 [
	" 
	レツミー方式及び行見方式を実装した段階では
	04月10日の上級レベルの問題は2問とも解決できなかった。
	"
^
#(
'
500 020 190
000 900 870
030 040 060

090 000 600
800 290 000
000 603 020

000 009 500
000 010 000
007 380 000
'

'
846 010 000
902 003 000
300 400 708

004 001 070
000 090 061
020 000 000

050 100 040
090 006 000
000 500 003
'
)
]

{ #category : #'sudoku - task' }
SudokuBoard class >> beginnersTasks240331 [
	" 
	https://si-coding.net/
	[過去のナンプレ(数独)問題集はこちら] 2024年03月31日 入門問題 (1-4)
	"
	^ #(
'
906  824  350
012  030  006
503  960  287

291  300  760
000  049  803
380  000  000

100  490  000
620  100  005
058  000  009
'

'
026  350  800
700  060  100
849  007  603

060  005  300
000  291  507
517  830  092

601  004  038
070  003  940
300  982  010
'

'
081  570  060
400  800  010
060  020  003

009  000  305
050  200  089
040  007  000

007  080  051
000  000  000
893  140  002
'

'
004  032  000
007  010  904
200  005  000

410  306  078
000  000  000
830  400  090

500  070  682
091  020  407
008  504  030
'
)
]

{ #category : #'sudoku - task' }
SudokuBoard class >> beginnersTasks240407 [
	" 
	https://si-coding.net/
	[過去のナンプレ(数独)問題集はこちら] 2024年04月07日 入門問題 (1-4)
	"
	^ #(

'
0 0 7  0 3 2  8 0 0
8 3 0  0 6 0  0 1 5
5 0 0  0 4 0  0 7 0

0 0 9  0 1 6  0 0 0
2 6 0  0 0 4  3 9 1
0 4 3  0 5 9  7 8 6

4 0 0  8 0 1  9 3 7
0 0 1  6 7 0  0 0 8
0 0 8  0 0 0  0 6 2
'

'
0 4 0  0 0 6  2 3 7
3 0 2  0 9 0  0 0 1
1 0 0  3 2 0  4 8 0

7 0 1  6 0 0  9 4 0
5 0 3  0 0 9  0 2 8
4 2 0  8 7 3  1 5 0

6 9 0  2 0 5  0 1 4
0 0 5  7 3 4  6 0 0
0 3 0  0 0 0  0 0 5
'


'
8 0 0  0 0 1  0 0 2
0 1 4  0 5 7  0 0 6
0 0 0  0 0 0  0 0 4

0 3 0  5 0 0  0 1 0
7 5 8  0 0 0  0 0 0
0 0 0  0 7 0  9 6 5

2 4 0  6 0 0  0 0 0
9 0 3  7 0 0  0 2 0
0 0 5  0 9 2  4 0 0
'

'
3 0 6  0 0 7  0 0 2
0 0 4  0 0 5  0 8 0
0 8 0  6 0 0  7 0 0

0 0 9  0 5 4  0 1 0
1 0 0  0 0 0  3 5 0
0 6 0  0 8 0  2 0 9

0 0 0  0 0 0  0 0 8
0 1 0  0 6 2  0 4 0
5 0 2  7 9 8  0 0 3
'
)
]

{ #category : #'sudoku - task' }
SudokuBoard class >> intermediateTasks [

^ #(
" ニコリ公式 数独の解き方 中級編"
'
000 002 000
070 030 800
600 080 700

083 000 012
000 501 000
590 000 640

005 090 003
002 050 080
000 700 000
'

"20240407"
'
000 500 070
000 009 003
900 100 000

080 406 000
520 900 100
004 000 000

640 000 000
010 083 005
093 000 017
'

'
200 000 000
501 060 000
083 900 000

700 400 800
004 500 300
000 019 075

400 000 008
009 070 050
000 103 007
'


"20240408"
'
005 100 030
090 400 060
007 800 200

180 002 000
000 000 004
000 900 170

040 070 000
261 030 000
000 000 092
'

'
040 001 003
000 000 802
008 407 005

070 040 000
005 060 701
090 000 000

807 000 000
600 530 000
000 108 030
'

)
]

{ #category : #'sudoku - task' }
SudokuBoard class >> intermediateTasks240409 [

^ #(
'
000 050 000
000 702 130
506 004 000

008 000 010
349 000 070
700 006 020

000 080 200
802 000 400
000 300 050
'

'
090 013 020
700 200 006
300 900 007

650 000 000
003 000 010
080 590 000

000 057 003
000 000 000
000 360 904
'
)
]

{ #category : #'sudoku - task' }
SudokuBoard class >> intermediateTasks240410 [

^ #(
'
060 030 005
000 100 700
450 000 000

502 000 000
800 603 029
007 090 000

000 006 000
006 400 030
000 700 490
'

'
300 000 208
800 069 000
400 050 000

000 700 050
000 008 600
050 002 400

000 910 020
080 006 007
003 000 000

'
)
]

{ #category : #'sudoku - solution' }
SudokuBoard class >> solveTask: task [

	| sudokuBoard |
	sudokuBoard := self new.
	sudokuBoard solution: task
	
"
task := '
1 9 7  0 0 4  2 0 5
6 8 0  5 3 0  9 0 0
5 0 3  0 7 2  1 6 8
	
0 6 0  4 0 9  7 0 2
0 7 5  0 1 0  6 8 0
2 0 9  8 0 7  0 4 0 
	
7 5 6  3 2 0  4 0 1
0 0 1  0 4 5  0 2 6 
8 0 4  1 0 0  3 5 7
'.

SudokuBoard solveTask: task.

"
	
]

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

{ #category : #logic }
SudokuBoard >> blockkenWay: sudokuBoard [
	"
	ブロッケン方式

	
	ボード上の全てのブロックをブロッケン法を用いブランクセルを埋める。
    ブロックにブランクセルが一つで残りのセルが数字で埋まっている場合は
    入るべき数字が決まるのでボード上の対応するセルにその数字をセットする。
	"
	| block |
	block := nil.
	1 to: 9 do: [ :i |
		1 to: 9 do: [ :j |
			block := SudokuBlock
				         sudokuBoard: sudokuBoard
				         blockNumber: i
				         verifyNumber: j.
			sudokuBoard sujiYomi: block.
			block completed ifFalse: [
				block tenpai ifTrue: [ sudokuBoard put: block tsumo ] ] ] ].

	
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

{ #category : #logic }
SudokuBoard >> columnTsumo: colIndex [
    "
	列の9つのセルの内8つのセルに数字が入ると残ったセルに入る数字は必然的に決まるので
	ボード上の対応するセルにその数字をセットする。
	"
	| colArray tempCols rowIndex |
	colArray := self colsAt: colIndex.
	tempCols := colArray select: [ :each | each > 0 ].
	tempCols size = 8 ifTrue: [ 
		rowIndex := colArray indexOf: 0.
		board at: rowIndex at: colIndex put: 45 - (tempCols sum)
	].
	^ self
]

{ #category : #logic }
SudokuBoard >> completed [ 
	 "
	ボード上の全てのブロックが完成している時はtrueを返す。
	 "
	1 to: 9 do: [ :n | | block |
		block := self blockAt: n.
		block completed ifFalse: [ ^ false ]
	].

	^true
]

{ #category : #examples }
SudokuBoard >> executeExample [
	"
	動作確認用
	"
	| example0 example1 block localBoard |
example0 :='
1 9 7  0 0 4  2 0 5
6 8 0  5 3 0  9 0 0
5 0 3  0 7 2  1 6 8
	
0 6 0  4 0 9  7 0 2
0 7 5  0 1 0  6 8 0
2 0 9  8 0 7  0 4 0 
	
7 5 6  3 2 0  4 0 1
0 0 1  0 4 5  0 2 6 
8 0 4  1 0 0  3 5 7
'.
	
example1 := '
8	0	0		0	0	5		1	0	0	
0	0	1		0	0	0		8	0	0	
0	4	0		2	0	0		0	9	0	


0	0	0		0	3	0		0	0	2	
1	2	3		4	0	6		7	8	9	
6	0	0		0	1	0		0	0	0	


0	8	0		0	0	9		0	5	0	
0	0	2		0	0	0		4	0	0	
0	0	7		6	0	0		0	0	1	

'.	

	localBoard  := self class  new.
	localBoard  loadFromString: example1.
	Transcript clear.

   

	Transcript show: '問題: '; show: localBoard; cr; cr.
	block := nil.
	5 timesRepeat: [  
		1 to: 9 do: [ :i |
			1 to: 9 do: [ :j |
				block := SudokuBlock sudokuBoard: localBoard  blockNumber: i verifyNumber: j.
		    	localBoard sujiYomi: block.
				block completed 
				ifFalse: [  
					block tenpai 
					ifTrue: [ localBoard put: block tsumo  ]
				].
			].
		].
	
		1 to: 9 do: [ :i |
			localBoard columnTsumo: i.
			localBoard rowTsumo: i.
	   ]
   
	].
	Transcript show: '結果: ' ;show: localBoard.
	
 
]

{ #category : #logic }
SudokuBoard >> gyome: sudokuBoard block: block [
	"
	レッツミー(列見)方式の90展開バージョン -- 行見(ギョウミ)
	
	ボードの列の行配列に注目してブランクセルに検証数字を配置できないセルを$Xでマークする。
	配列のブランクセルが一つになったなら配備される数字は自動的に決定する。
	
	1)検証するブロックに検証数字が存在する時は注目した行配列のブロックに対応するブランクセルにXを配置する。
	2)ボードの行配列を走査してインデックスに対応するボードの列の串刺し配列を確認し検証数字が存在する時はセルにXを配置する。
	3) 2)の終了後、行配列にブランクセルが一つの時は、ブランクセルのボード座標に検証数字をセットする。
	"

	| colCells rowCells blankCount |
	1 to: 3 do: [ :rowIndex | 
		rowCells := sudokuBoard rowsAt: (block rowsOfBoard at: rowIndex ).
		
		(rowCells includes: block verifyNumber)
		ifFalse: [ 
			"1)"
			1 to: 3 do: [ :i|
				(rowCells at: (block colsOfBoard at: i)) = 0
				ifTrue: [ rowCells at: (block colsOfBoard at: i) put: $X ].
			].
			"2)"
			1 to: 9 do: [ :j|
				colCells := sudokuBoard colsAt: j.
				(colCells includes: block verifyNumber)
				ifTrue: [ rowCells at: j put: $X ]
			].
		    "ブランクセルを数える"
			blankCount := 0.
			rowCells do: [ :cell | 
				cell = 0 ifTrue: [ blankCount := blankCount + 1 ].
			].
			"3)"
			blankCount = 1
			ifTrue: [ |cIndex|
				cIndex := rowCells indexOf: 0.
				sudokuBoard row: (block rowsOfBoard at: rowIndex ) column: cIndex put: block verifyNumber .
			].
		]				
	].
		
	

	
]

{ #category : #logic }
SudokuBoard >> gyomeWay: sudokuBoard [

	| block |
	1 to: 9 do: [ :n |
		block := sudokuBoard blockAt: n.
			1 to: 9 do: [ :vNum| 
				block verifyNumber: vNum.
				(block blockA2D includes: vNum)
				ifTrue: [ 
					self gyome: sudokuBoard block: block.
			].	
		]
	]
	
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

{ #category : #logic }
SudokuBoard >> letsme: sudokuBoard block: block [
	"
	レッツミー(列見)方式の中核となるメソッド
	ボードの列の串刺し配列に注目してブランクセルに検証数字を配置できないセルを$Xでマークする。
	配列のブランクセルが一つになったなら配備される数字は自動的に決定する。
	
	1)検証するブロックに検証数字が存在する時は注目した列の串刺し配列のブロックに対応するブランクセルにXを配置する。
	2)ボードの列串刺し配列を走査してインデックスに対応するボードの行配列を確認し検証数字が存在する時はセルにXを配置する。
	3) 2)の終了後、列串刺し配列にブランクセルが一つの時は、ブランクセルのボード座標に検証数字をセットする。
	"

	| colCells rowCells blankCount |
	1 to: 3 do: [ :colIndex | 
		colCells := sudokuBoard colsAt: (block colsOfBoard at: colIndex ).
		(colCells includes: block verifyNumber)
		ifFalse: [ 
			"1)"
			1 to: 3 do: [ :i|
				(colCells at: (block rowsOfBoard at: i)) = 0
				ifTrue: [ colCells at: (block rowsOfBoard at: i) put: $X ].
			].
			"2)"
			1 to: 9 do: [ :j|
				rowCells := sudokuBoard rowsAt: j.
				(rowCells includes: block verifyNumber)
				ifTrue: [ colCells at: j put: $X ]
			].
		    "ブランクセルを数える"
			blankCount := 0.
			colCells do: [ :cell | 
				cell = 0 ifTrue: [ blankCount := blankCount + 1 ].
			].
			"3)"
			blankCount = 1
			ifTrue: [ |rowIndex|
				rowIndex := colCells indexOf: 0.
				sudokuBoard row: rowIndex column:  (block colsOfBoard at: colIndex ) put: block verifyNumber .
			].
		]				
	].
		
	

	
]

{ #category : #logic }
SudokuBoard >> letsmeWay: sudokuBoard [
	"
	レッツミー(列見)方式
	ボードの列の串刺し配列に注目してブランクセルに検証数字を配置できないセルを$Xでマークする。
	配列のブランクセルが一つになったなら配備される数字は自動的に決定する。
	
	1)検証するブロックに検証数字が存在する時は注目した列の串刺し配列のブロックに対応するブランクセルにXを配置する。
	2)ボードの列串刺し配列を走査してインデックスに対応するボードの行配列を確認し検証数字が存在する時はセルにXを配置する
	3) 2)の終了後、列串刺し配列にブランクセルが一つの時は、ブランクセルのボード座標に検証数字をセットする。
	"
	
	| block |
	1 to: 9 do: [ :n |
		block := sudokuBoard blockAt: n.
			1 to: 9 do: [ :vNum| 
				block verifyNumber: vNum.
				(block blockA2D includes: vNum)
				ifTrue: [ 
					"
					Transcript show: 'レツミー block: ' ;show: n ; show: ' verifyNumber: '; show: vNum ;cr.
					"
					self letsme: sudokuBoard block: block.
			].	
		]
	]
	
]

{ #category : #'initialization - data' }
SudokuBoard >> loadExample: anArray [
	"
	ユニットテストで使用している
	2次元配列の数独問題データ(anArray)を数独ボードデータへ(Array2D)へコピーする.	
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

{ #category : #logic }
SudokuBoard >> masumeWay: sudokuBoard [
	"
	マスミ方式
	
	ブロック上のブランクセルに注目してブランクセルに配置できない数字の配列を作る。
	1)ブロックのゼロ以外の数字の配列を作る
	2)ブランクセルの行インデックスに対応するボードの行のゼロ以外の数字の配列を作る
	3)ブランクセルの列インデックスに対応するボードの列のゼロ以外の数字の配列を作る
	4)1,2,3 を連結する
	5)4をセットにして数字の重複をなくす
	6)5の要素を数え8ならばブランクセルに入る数字が決定する
	"
	| block |
	1 to: 9 do: [ :n | | coordBlankCells blockCells rowCells colCells set |
		block := sudokuBoard  blockAt: n.
		coordBlankCells := block coordinatesOfBlankCells .
		blockCells := block nonBlankCells.
		coordBlankCells do: [ :coord |
			rowCells := (sudokuBoard  rowsAt: (block rowsOfBoard at: coord row)) select: [ :cell| cell > 0].
			colCells := (sudokuBoard  colsAt: (block colsOfBoard at: coord column)) select: [ :cell| cell > 0].

			set := ((blockCells copyWithAll: rowCells) copyWithAll: colCells ) asSet.	
			
			set size = 8
			ifTrue: [ | rIndex cIndex val |
				rIndex :=  block rowsOfBoard at: coord row.
				cIndex :=  block colsOfBoard at: coord column.
				val := 45 - set sum .
				sudokuBoard  row: rIndex  column: cIndex  put: val.
			].		
	 	].
		
	].
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

{ #category : #logic }
SudokuBoard >> rowColTenpai: sudokuBoard [
	"
	行または列の9つのセルの内8つのセルに数字が入ると残ったセルに入る数字は必然的に決まるので
	ボード上の対応するセルにその数字をセットする。
	"
	1 to: 9 do: [ :i |
		sudokuBoard columnTsumo: i.
		sudokuBoard rowTsumo: i.
	]
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
SudokuBoard >> rowTsumo: rowIndex [
	"
	行の9つのセルの内8つのセルに数字が入ると残ったセルに入る数字は必然的に決まるので
	ボード上の対応するセルにその数字をセットする。
	"
	| rowArray tempRows colIndex |
	rowArray := self rowsAt: rowIndex.
	tempRows := rowArray select: [ :each | each > 0 ].
	tempRows size = 8 ifTrue: [ 
		colIndex := rowArray indexOf: 0.
		board at: rowIndex at: colIndex put: 45 - tempRows sum
	].
	^ self
]

{ #category : #logic }
SudokuBoard >> rowsAt: rowIndex [
	"
	boardよりrowIndex指定した行(列配列)を返す。
	"
	"
	| result |
	result := Array new: 9 withAll: 0.
	
	1 to: 9 do: [ :colIndex | result at: colIndex put: (board at: rowIndex at: colIndex)].
	"
	^ (board atRow: rowIndex) copy
]

{ #category : #'initialization - data' }
SudokuBoard >> setDummy [
	"
	ユニットテストで使用している
	"
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

{ #category : #initialization }
SudokuBoard >> setExample0 [
	" 
	ユニットテストで使用している
	https://www.nikoli.co.jp/ja/puzzles/sudoku/ 初級編動画の例題
	"

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

{ #category : #'initialization - data' }
SudokuBoard >> setExample1 [
	" 
	ユニットテストで使用している
	https://www.nikoli.co.jp/ja/puzzles/sudoku/ の例題
	"
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

{ #category : #'sudoku - solution' }
SudokuBoard >> solution: task [
	"
	 si-codig.netサイトのナンプレ問題より入門問題及び初級問題4問を解くことを目指す。completed!!
	 2024年04月07日の初級問題中級問題は4問全て解けた。
	 2024年03月31日の初級問題は4問全て解けた。
	
	 letsmeWay:メソッドを実装することでintermediateTasks at: 5 を除く4問は解決できた。
	 ntermediateTasks20240409の中級問題全2問は解決できた。
	"
	| sudokuBoard  message |
	sudokuBoard := self class new.
	sudokuBoard loadFromString: task.
	Transcript clear.

	Transcript
		show: '問題: ';
		show: sudokuBoard;
		cr;
		cr.
	10 timesRepeat: [  
			self blockkenWay: sudokuBoard.
			self rowColTenpai: sudokuBoard.
			self masumeWay: sudokuBoard.
			self letsmeWay: sudokuBoard.
			self gyomeWay: sudokuBoard .
	].

	message := ''.
	message := sudokuBoard completed
		           ifTrue: [ '問題解決！ ']
		           ifFalse: [ '残念でした！ '].

	Transcript
		show: '結果: ';
		show: message;
		show: sudokuBoard
]

{ #category : #logic }
SudokuBoard >> sujiYomi: aBlock [
	"
 	対象となる他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印にしている。
 	rowSuji:とcolumnSuji:を利用して検証数値が重複するブロックのセルにXを配置する。
 	ブロックにブランクセルが一つだけの時は、ボードのセルに検証数値を配置する。
  	(麻雀用語:スジ)	
	"
	| coordinates |
	(aBlock blockA2D asArray includes: aBlock verifyNumber)
	ifTrue: [ ^self ].
	
	self rowSuji: aBlock.
	self columnSuji: aBlock.
	coordinates := nil.
	aBlock blockkenTenpai ifFalse: [ ^ self ].
	coordinates := aBlock bingo.
	self at: coordinates put: aBlock verifyNumber
]
