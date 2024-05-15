"
数独ボードの列を表現するクラス

    Instance Variables
	column		<Array>			列の9つのセルの配列
	colIndex	<SmallInteger>	ボード上の列インデックス



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
SudokuColumn >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'colIndex: '; nextPutAll: colIndex asString.
	column doWithIndex: [ :c :idx |
			 	idx % 3 = 1 ifTrue: [ aStream cr ]. 
				aStream print: c; cr. ].

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

{ #category : #'as yet unclassified' }
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

{ #category : #comparing }
SudokuColumn >> hash [ 

	^ (colIndex hash bitXor:  column hash)
]

{ #category : #testing }
SudokuColumn >> includes: anObject [

	^ column includes: anObject 
]

{ #category : #'private - logics' }
SudokuColumn >> markBlankCells [ 

	1 to: 9 do: [ :i | 
		 (self at: i) = 0
			ifTrue: [ self at: i put: $X ]]
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
