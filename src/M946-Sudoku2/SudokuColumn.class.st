"
数独ボードの列を表現するクラス

Instance Variables
column		<Array>			列の9つのセルの配列
colIndex	<SmallInteger>	ボード上の列インデックス
		
主なAPI
- allGreen               1つのブランクセル以外の8つのセルが1-9までの数字で埋まっている時
                         足りない数字をSudokuCellに格納して返す、でなければ0を返す
- blankCellsAsArray      SudokuColumnのブランクセルをSudokuCellの配列にして返す
- cellOf:                number(値)の座標をSudokuCell にマップして返す, 見つからないときは0を返す
- countOfReservedBlankCells ブランクセル以外のセルが1-9の数字で埋まっている時のブランクセルの数を返す
- tenpai                 列にブランクセル１つだけの時はブランクセルのボード座標をSudokuCellにマッピングして返す
                         ブランクセルが複数のときは0を返す。



"
Class {
	#name : #SudokuColumn,
	#superclass : #Object,
	#instVars : [
		'colIndex',
		'column'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'instance creation' }
SudokuColumn class >> new: index column: anArray [

	| sudokuColumn |
	sudokuColumn := self new.
	sudokuColumn colIndex: index.
	sudokuColumn column: anArray.
	
	^sudokuColumn 
]

{ #category : #comparing }
SudokuColumn >> = sudokuColumn [

	^ sudokuColumn class == self class 
		and: [ sudokuColumn colIndex = self colIndex 
			and: [ sudokuColumn column = self column ]  ]
]

{ #category : #logic }
SudokuColumn >> allGreen [
	"
	allGreen: 麻雀用語で緑一色のこと、 軍事用語でシステムが全て正しく作動すること
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := column select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		
		array asSet size = 8
		ifTrue: [ 
			shortOfNumber := 45 - array sum.
			cell element: shortOfNumber ]
		ifFalse: [ cell := 0 ]
	].

	^ cell
]

{ #category : #converting }
SudokuColumn >> asArray [

	^column
]

{ #category : #converting }
SudokuColumn >> asSimpleString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'aSudokuColumn #';
			nextPutAll: colIndex asString;
			nextPutAll: '('.
	column doWithIndex: [ :c :idx |
				idx = 1 ifTrue: [ aStream space ].
			 	(idx > 1 and: [idx % 3 = 1]) ifTrue: [ aStream tab ]. 
				c class = SudokuCell 
					ifTrue: [ aStream nextPutAll: c asSimpleString ; space ]
					ifFalse:[	aStream print: c; space ]].
	aStream nextPutAll: ' )'.

	^ aStream contents 
]

{ #category : #converting }
SudokuColumn >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'colIndex: '; nextPutAll: colIndex asString; space; space.
	column doWithIndex: [ :c :idx |
			 	idx % 3 = 1 ifTrue: [ aStream tab ]. 
				aStream print: c; space. ].

	^ aStream contents 
]

{ #category : #accessing }
SudokuColumn >> at: index [

	^column at: index
]

{ #category : #accessing }
SudokuColumn >> at: index put: val [

	column at: index put: val 
]

{ #category : #accessing }
SudokuColumn >> blankCellsAsArray [
	"
    SudokuColumnのブランクセルをSudokuCellの配列にして返す
    "
	| collection |
	collection := OrderedCollection new.
	1 to: 9 do: [ :i |
		(column at: i ) = 0 ifTrue: [
			collection add: (SudokuCell
						 		row: i
						 		column: colIndex 
						 		element: 0)].					
		(column at: i) class = SudokuCell ifTrue:[ collection add: (column at: i)] ].

	^ collection  asArray
]

{ #category : #accessing }
SudokuColumn >> cellOf: number [
	"
	numberの座標をSudokuCellにマップして返し見つからない場合は0を返す。
	"
	| index cell|
	cell := 0.
	index := self asArray indexOf: number.
	index = 0 ifFalse: [ 
		cell := SudokuCell row: index column: colIndex element: number].
	
	^cell
]

{ #category : #'private - utility' }
SudokuColumn >> clearMarks [

	1 to: 9 do: [ :i | (column at: i) class = Character 
							ifTrue:[column at:i put: 0]]

	
]

{ #category : #accessing }
SudokuColumn >> colIndex [

	^colIndex 
]

{ #category : #accessing }
SudokuColumn >> colIndex: aNumber [

	colIndex := aNumber 
]

{ #category : #accessing }
SudokuColumn >> column [

	^column 
]

{ #category : #accessing }
SudokuColumn >> column: anArray [


	column := anArray copy.
]

{ #category : #logic }
SudokuColumn >> completed [ 

	^(#(1 2 3 4 5 6 7 8 9) difference: column) isEmpty
]

{ #category : #'private - utility' }
SudokuColumn >> countOfReservedBlankCells [
	"
	ブランクセル以外のセルは1-9の数字で埋まっている時のブランクセルの数を返す
	"
	^9 - (column select: [ :n | n class = SmallInteger and: [ n < 10  and: [ n > 0 ]]]) size
]

{ #category : #comparing }
SudokuColumn >> hash [ 

	^ (colIndex hash bitXor:  column hash)
]

{ #category : #testing }
SudokuColumn >> includes: number [

	| sudokuCells |
	sudokuCells := column select: [ :item | item class = SudokuCell ].
	sudokuCells isEmpty ifTrue: [ ^column includes: number ].
	
	^(sudokuCells anySatisfy: [ :cell | cell possibleNumbers includes: number ])
		or: [  column includes: number ]
]

{ #category : #accessing }
SudokuColumn >> indexOf: number [

	| cells sudokuCells |
	cells := column select: [ :cell | cell class = SmallInteger].
	(cells includes: number) ifTrue: [ ^column indexOf: number ].
	
	sudokuCells := column select: [ :cell | cell class = SudokuCell ].
	cells := sudokuCells select: [ :cell | cell possibleNumbers includes: number ].
	cells size > 1 ifFalse: [ ^0 ].
	^column indexOf: (cells at: 1)
	
]

{ #category : #'private - logics' }
SudokuColumn >> markBlankCells [ 

	1 to: 9 do: [ :i | 
		 (self at: i) = 0
			ifTrue: [ self at: i put: $X ]]
]

{ #category : #'private - utility' }
SudokuColumn >> missingNumbers [ 

	^#(1 2 3 4 5 6 7 8 9) difference:  column
]

{ #category : #printing }
SudokuColumn >> printOn: aStream [

	aStream nextPutAll: self asString; cr.
]

{ #category : #logic }
SudokuColumn >> tenpai [ 
	"
	列にブランクセル１つだけの時はブランクセルのボード座標をSudokuCellにマッピングして返す。
	でなければ0を返す。
	"
	| cell |
	cell := 0.
	((column select: [ :val | val = 0 ]) size) = 1
	ifTrue: [ cell := SudokuCell row: (column indexOf: 0) column: colIndex element: 0 ].
	
	^ cell
	
]

{ #category : #logic }
SudokuColumn >> tsumo [
    "
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := column select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		array asSet size = 8
		ifTrue: [ 
			shortOfNumber := 45 - array sum.
			cell element: shortOfNumber ]
	].

	^ cell
]
