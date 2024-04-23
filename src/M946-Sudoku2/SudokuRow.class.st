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

{ #category : #converting }
SudokuRow >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: 'rowIndex: '; nextPutAll: rowIndex asString; cr;
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

{ #category : #comparing }
SudokuRow >> hash [ 

	^ (rowIndex hash bitXor: row hash)
]

{ #category : #testing }
SudokuRow >> includes: anObject [

	^ row includes: anObject 
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
