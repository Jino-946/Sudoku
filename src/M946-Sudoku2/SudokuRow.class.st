"
数独ボードの行を表現するクラス

    Instance Variables
	row			<Array>				行の9つのセルの配列
	rowIndex	<SmallInteger>		ボード上の行インデックス


  
"
Class {
	#name : #SudokuRow,
	#superclass : #Object,
	#instVars : [
		'rowIndex',
		'row'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'instance creation' }
SudokuRow class >> new: index row: anArray [

	|sudokuRow|
	sudokuRow := self new.
	sudokuRow rowIndex: index.
	sudokuRow row: anArray.
	
	^sudokuRow

]

{ #category : #comparing }
SudokuRow >> = sudokuRow [

	^ sudokuRow class == self class
		and: [ sudokuRow rowIndex = self rowIndex 
			and: [sudokuRow row = self row ]]
]

{ #category : #logic }
SudokuRow >> allGreen [
	"
	allGreen: 麻雀用語で緑一色のこと、 軍事用語でシステムが全て正しく作動すること
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := row select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		array asSet size = 8
		ifTrue: [ 
			shortOfNumber := 45 - array sum.
			cell element: shortOfNumber ]
	].

	^ cell

]

{ #category : #converting }
SudokuRow >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream cr; nextPutAll: 'rowIndex: '; nextPutAll: rowIndex asString; cr;
			 nextPutAll: row asString. 
	^ aStream contents 


]

{ #category : #accessing }
SudokuRow >> at: index [

	^row at: index
]

{ #category : #accessing }
SudokuRow >> at: index put: value [

	row at: index put: value
]

{ #category : #'private - utility' }
SudokuRow >> clearMarks [

	1 to: 9 do: [ :i | (row at: i) class = Character 
							ifTrue:[row at:i put: 0]]

	
]

{ #category : #'private - utility' }
SudokuRow >> countBlankCells [ 

	^(row select: [ :n | n = 0 ]) size
]

{ #category : #logic }
SudokuRow >> eitherCell [
	"
	ブロック行の中で２つのセルにどちらかに必ず同じ数字が入る時、他のブロックの
	同じ行にはその数は入れることはできないので$Xでマークする。
	マークしたセル情報をSudokuCellに格納し配列として返す。
	でなければ0 を返す
	"
	| digitChars cells cell |
	cells := 0.
	digitChars  := row select: [ :c | c class = Character and: [ c between: $1 and: $9 ]].
	(digitChars  size = 2 and: [ (digitChars  at: 1) = (digitChars  at: 2)])
	ifTrue: [  
		cells := OrderedCollection new.
		1 to: 9 do: [ :i | 
			((row at: i) = 0) ifTrue: [ 
				row at: i put: $X .
				cell := SudokuCell row: i column: rowIndex  element: $X.
				cells add: cell.
			]]].
	 ^cells
]

{ #category : #comparing }
SudokuRow >> hash [ 

	^ (rowIndex hash bitXor: row hash)
]

{ #category : #testing }
SudokuRow >> includes: anObject [

	^ row includes: anObject 
]

{ #category : #'private - logics' }
SudokuRow >> markBlankCells [ 

	1 to: 9 do: [ :i | 
		 (self at: i) = 0
			ifTrue: [ self at: i put: $X ]]
]

{ #category : #printing }
SudokuRow >> printOn: aStream [

	aStream nextPutAll: self asString; cr.
]

{ #category : #accessing }
SudokuRow >> row [

	^row
]

{ #category : #accessing }
SudokuRow >> row: anArray [

	row := anArray copy.
]

{ #category : #accessing }
SudokuRow >> rowIndex [

	^rowIndex 
]

{ #category : #accessing }
SudokuRow >> rowIndex: aNumber [

	rowIndex := aNumber.
]

{ #category : #logic }
SudokuRow >> tenpai [ 
	"
	行にブランクセル１つだけの時はブランクセルのボード座標をSudokuCellにマッピングして返す。
	でなければ0を返す。
	"
	| cell |
	cell := 0.
	((row select: [ :val | val = 0 ]) size) = 1
	ifTrue: [ cell := SudokuCell row: rowIndex  column: (row indexOf: 0)  element: 0 ].
	
	^ cell
	
]

{ #category : #logic }
SudokuRow >> tsumo [
   "
    Senderは戻値がSudokuCellであることを確認後、SudokuBoard >> map:  でボードにマッピングすること
    "
	| cell array shortOfNumber |
	cell := self tenpai.
	cell class = SudokuCell 
	ifTrue: [ 
		array := row select: [ :e | 
					e class = SmallInteger and: [ e between: 1 and: 9 ] ].
		array asSet size = 8
		ifTrue: [ 
			shortOfNumber := 45 - array sum.
			cell element: shortOfNumber ]
	].

	^ cell

]
