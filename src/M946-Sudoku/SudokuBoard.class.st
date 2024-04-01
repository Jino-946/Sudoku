Class {
	#name : #SudokuBoard,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #logic }
SudokuBoard >> blockkenAt: blockNumber [
	"
	数独ボード(9X9)よりblockNumberを指定してブロック(3X3)を取り出す。
	数独ボード(9X9)とブロックの位置関係
	 	1  2  3
	 	4  5  6
	 	7  8  9	
	"
	blockNumber = 1 ifTrue: [ ^self blockkenAt: 1 at: 1 ].
	blockNumber = 2 ifTrue: [ ^self blockkenAt: 1 at: 4 ].
	blockNumber = 3 ifTrue: [ ^self blockkenAt: 1 at: 7 ].
	
	blockNumber = 4 ifTrue: [ ^self blockkenAt: 4 at: 1 ].
	blockNumber = 5 ifTrue: [ ^self blockkenAt: 4 at: 4 ].
	blockNumber = 6 ifTrue: [ ^self blockkenAt: 4 at: 7 ].
	
	blockNumber = 7 ifTrue: [ ^self blockkenAt: 7 at: 1 ].
	blockNumber = 8 ifTrue: [ ^self blockkenAt: 7 at: 4 ].
	blockNumber = 9 ifTrue: [ ^self blockkenAt: 7 at: 7 ].

]

{ #category : #logic }
SudokuBoard >> blockkenAt: rowStart at: colStart [
	" private
	数独ボード(9X9)より行の開始位置(rowStart)と列の開始位置(colStart)を指定して
	ブロック(3X3)を取り出す。
	rowStartとcolStartの組み合わせ(rowStart-colStart)は次の9通りだが
	 	1-1 1-4 1-7
	 	4-1 4-4 4-7
	 	7-1 7-4 7-7
	組み合わせの整合性はチェックは行わないのでblockkenAt:を利用して引数の
	整合性を担保する。	
	"
	| blockken rs cs |
	rs := rowStart.
	cs := colStart.
	blockken := SudokuBlockken new.
	
	blockken boardRows at:1 put: rs;
						at: 2 put: rs + 1;
						at: 3 put: rs + 2.
						
	blockken boardCols at:1 put: cs;
						at: 2 put: cs + 1;
						at: 3 put: cs + 2.
						
	blockken blockkenA2D at: 1 at: 1 put: (board at: rs at: cs);
						  at:  1 at: 2 put: (board at: rs at: cs + 1);
						  at:  1 at: 3 put: (board at: rs at: cs + 2);	
						  at:  2 at: 1 put: (board at: rs + 1 at: cs);
						  at:  2 at: 2 put: (board at: rs + 1 at: cs + 1);
						  at:  2 at: 3 put: (board at: rs + 1 at: cs + 2);
						  at:  3 at: 1 put: (board at: rs + 2 at: cs);
						  at:  3 at: 2 put: (board at: rs + 2 at: cs + 1);
						  at:  3 at: 3 put: (board at: rs + 2 at: cs + 2).

	^ blockken
]

{ #category : #accessing }
SudokuBoard >> board [

	^board 
]

{ #category : #initialization }
SudokuBoard >> initialize [ 

	super initialize .
	board := Array2D new:9 element: 0
]

{ #category : #printing }
SudokuBoard >> printOn: aStream [

	aStream nextPutAll: board asString 
]

{ #category : #accessing }
SudokuBoard >> row: anInteger column: anInteger2 [

	^board at: anInteger at: anInteger2 
]

{ #category : #accessing }
SudokuBoard >> row: anInteger column: anInteger2 put: val [

	^board at: anInteger at: anInteger2 put: val
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
]
