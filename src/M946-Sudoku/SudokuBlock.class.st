"
数独ボード構成する9個のブロックを表現するクラス。
(ブロッケン法による問題解法ロジックを使うメソッド名、変数名には麻雀用語を援用していることがある。)

数独ボード上には下記の構成でブロックは配置される。(数字はブロック番号)

    1  2  3
    4  5  6
    7  8  9

インスタンス生成
	SudokuBlock block := aSudokuBoard blockAt: aBlockNumber.
	SudokuBlock block := SudokuBlock sudokuBoard: aSudokuBoard  blockNumber: anInt1 verifyNumber: anInt2.

主なインスタンス・メソッド
- blockkenTenpai
   (ブロッケン法におけるテンパイ)
   ブランクセルが１つ(ブロック上に0が1つ)ならばtrueを返す。
   ブランクセルが一つで残りのセルは数字及びXが混在している状態。
   Xは検証数値がボードのrowまたはcolumnで重複するため検証数値を配置できないセルであることを表す。
   (麻雀用語:テンパイ)
    
- bingo
   未実装
   blockkenTenpaiの時に検証数値をブランクセルに入れその座標を返す。
   ブロック上のXを0にリセットする。
        
- tenpai
   ブランクセルが残り１つ(ブロック上に0が1つ)ならばtrueを返す
   残りのセル8個は1-9のみか確認している。
   (麻雀用語:テンパイ)   	
     
- tsumo
   tenpai確認後に実行する。
   1-9 の範囲でブロックに欠けてる数値をブランクセルにセットする。
   ブランクセルのブロック座標をボード座標(aSBCoodinates)に変換して返す。
   (麻雀用語:ツモ)
   
- chonbo
   未実装
   ブロックに同じ数字が複数ある時trueを返す。
   アルゴリズムが正しければfalseはありえないはず。
   (麻雀用語:チョンボ)
    
- furiten
   未実装
   検証数値を置けるブランクセルが同一行、同一列に複数ある場合trueを返す。
   可能性のあるブランクセル(どちらに置けるか判断できないセル)にはQをセットする。
   (麻雀用語:フリテン)
   
- sujiYomi
   未実装
   他のブロックに検証数値があると重複が発生するためブランクセルにXを置き重複を回避する目印とする。
   sujiは麻雀用語の「筋」と「数字」の掛け詞
   (麻雀用語:スジヨミ)
   
- columnSuji: colIndex
   未実装
   columnのセル要素の配列をsuji検証する。
   (麻雀用語:スジ)
   
- rowSuji: rowIndex
   未実装
   rowのセル要素の配列をsuji検証する。
   (麻雀用語:スジ)
       	
- countBlank
   ブロック上のブランクセル(0)を数える	
   
- toBoardCoordinatesRow: blockRow column: blockCol
   SudokuBlock座標をSudokuBoard座標に変換しSBCoordinatesのインスタンスとして返す
    

インスタンス変数
	blockNumber:	<SmallInteger>		ブロック番号 (1-9)
	blockA2D:	    <Array2D>			ブロック番号に対応したブロック			
	boardCols:		<Array>				ブロック列indexに対応したボード列indexを持つ配列
	boardRows:		<Array>				ブロック行indexに対応したボード行indexを持つ配列
	verifyNumber:	<SmallInteger>		検証する数値

備考				
	hash method の実装は[Overriding Equality and Hash in Pharo](https://growi.cloud/blog/3044)を参照した。

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

{ #category : #creation }
SudokuBlock class >> fromArray: anArray [
	"
	配列からSudokuBlockインスタンスを生成する。
	注意:blockA2Dを除くインスタンス変数は初期化されたまま
	"
	| block i j|

	i := 0.
	j := 0.
	block := self new.
	anArray do: [ :each |
		block row: i // 3 + 1 column: j % 3 + 1 put: each.
		i := i + 1.
		j := j + 1.
	]. 
	
	^block
]

{ #category : #creation }
SudokuBlock class >> sudokuBoard: board blockNumber: bNum verifyNumber: vNum [

	| block |
	block := board blockAt: bNum.
	block verifyNumber: vNum.
	^ block
]

{ #category : #comparing }
SudokuBlock >> = aSudokuBlockken [

	^ aSudokuBlockken class == self class
		and: [ aSudokuBlockken blockA2D = self blockA2D 
				and: [ aSudokuBlockken boardRows = self boardRows 
					and: [ aSudokuBlockken boardCols = self boardCols 
						and: [ aSudokuBlockken blockNumber = self blockNumber
							and: [aSudokuBlockken verifyNumber = self verifyNumber ] ]]]]
	
]

{ #category : #logic }
SudokuBlock >> bingo [ 
	"
    #1)blockkenTenpaiの時に検証数値をブランクセルに入れその座標を返す。
    #2)ブロック上のXを0にリセットする。	
	"
	| rowIndex colIndex boardCoordinates |
	"#1"
	rowIndex := 0.
	colIndex := 0.
	boardCoordinates := SBCoordinates new.
	1 to: 3 do: [ :ri |
		1 to: 3 do: [ :ci |
			(self row: ri column: ci) = self blankCell
			ifTrue: [	rowIndex := ri.
						colIndex := ci.
			]
		]
	].
	self row: rowIndex  column: colIndex put: verifyNumber  .
	boardCoordinates := self toBoardCoordinatesRow: rowIndex  column: colIndex .
	
	"#2"
	rowIndex := 0.
	colIndex := 0.
	1 to: 3 do: [ :ri |
		1 to: 3 do: [ :ci |
			(self row: ri column: ci) = $X
			ifTrue: [ self row: ri column: ci put: 0 ]
		]
	].	
	
	^boardCoordinates 

]

{ #category : #'private - helpers' }
SudokuBlock >> blankCell [
	"
	ブランクセルを表現する0を返す。
	"
	^0
]

{ #category : #accessing }
SudokuBlock >> blockA2D [

	^blockA2D
]

{ #category : #accessing }
SudokuBlock >> blockA2D: anArray2D [

	blockA2D := anArray2D 
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

{ #category : #logic }
SudokuBlock >> blockkenTenpai [
	"
	ブランクセルが１つ(ブロック上に0が1つ)ならばtrueを返す。
	残りのセルは1-9または$X、$Qで満たされているがユーザがキーボードより
	直接入力することを想定しないので字種のチェックは行わない。
	"
	| blankCount result |
	blankCount := 0.
	result := false.
	blockA2D do: [ :each |
		each = self blankCell 
		ifTrue: [ blankCount := blankCount + 1 ]	
	].

	blankCount = 1
	ifTrue: [ result := true ] .
	
	^result 
	
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

{ #category : #logic }
SudokuBlock >> countBlank [
	" 
	ボード上の0を数える	
	"
	| counts |
	counts := 0.
	blockA2D asArray do: [ :each | each = self blankCell  ifTrue: [ counts := counts + 1 ] ].
	
	^counts
	
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
SudokuBlock >> tenpai [
	"
	ブランクセルが残り１つ(ブロック上に0が1つ)ならばtrueを返す
	残りのセルは1-9のみで満たされている
	"
	| blankCount numberCount result |
	blankCount := 0.
	numberCount := 0.
	result := false.
	blockA2D do: [ :each |
		each = self blankCell 
		ifTrue: [ blankCount := blankCount + 1 ]
		ifFalse: [  
			each class = SmallInteger 
			ifTrue: [ numberCount := numberCount + 1 ]
		]
	].

	blankCount = 1
		and: [ numberCount = 8 
			ifTrue: [ result := true ]].
	^result 

]

{ #category : #'private - helpers' }
SudokuBlock >> toBoardCoordinatesRow: blockRow column: blockCol [
	"
	SudokuBlock座標をSudokuBoard座標に変換しBoardCoordinatesのインスタンスとして返す
	"
	| coord |
	coord := SBCoordinates new.
	coord row: (boardRows at: blockRow).
	coord column: (boardCols at: blockCol).
	
	^coord
]

{ #category : #logic }
SudokuBlock >> tsumo [
	"
	 tenpai確認後に実行する。
	 1-9 の範囲でブロックに欠けてる数値(shortOfNumber)をブランクセルにセットする。
	 ブランクセルのブロック座標をボード座標(aSBCoodinates)に変換して返す。
	"
	| rowIndex colIndex boardCoordinates sum shortOfNumber |
	
	rowIndex := 0.
	colIndex := 0.
	sum := 0.
	boardCoordinates := SBCoordinates new.
	1 to: 3 do: [ :ri |
		1 to: 3 do: [ :ci |
			(self row: ri column: ci) = self blankCell
			ifTrue: [	rowIndex := ri.
						colIndex := ci.
			].
			sum := sum + (self row: ri column: ci).
		]
	].
	shortOfNumber := 45 - sum.
	self row: rowIndex  column: colIndex put: shortOfNumber  .
	boardCoordinates := self toBoardCoordinatesRow: rowIndex  column: colIndex .
	^boardCoordinates 

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
