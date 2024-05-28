"
ブロックにおけるブランクセルが２つになりどちらかのセルに必ず
検証数字が入る場合,２つのセルの座標をSudokuCellのインスタンスとして
cellsに保持する。
"
Class {
	#name : #EitherCells,
	#superclass : #Object,
	#instVars : [
		'cells'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #adding }
EitherCells >> add: cell [

	cells add: cell
]

{ #category : #converting }
EitherCells >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream cr; nextPutAll: 'EitherCells ('; cr.
	aStream nextPutAll: (cells at: 1) asString; cr;cr.
	aStream nextPutAll: (cells at: 2) asString; cr.
	aStream nextPutAll: ')'; cr.
	
	^aStream contents .

]

{ #category : #accessing }
EitherCells >> at: index [

	^cells at: index
]

{ #category : #accessing }
EitherCells >> cells [

	^cells
]

{ #category : #accessing }
EitherCells >> colIndex [
	"
	２つのセルの列インデックスが等しい時は列インデックスを返し,でなければ0を返す
	"
	(cells at: 1) colIndex = (cells at: 2) colIndex 
		ifTrue: [ ^(cells at: 1) colIndex]
		ifFalse: [ ^0 ]
]

{ #category : #initialization }
EitherCells >> initialize [ 
	super initialize .
	cells := OrderedCollection new.
]

{ #category : #testing }
EitherCells >> isEmpty [ 

	^cells isEmpty 
]

{ #category : #testing }
EitherCells >> isNotEmpty [

	^cells isNotEmpty 
]

{ #category : #printing }
EitherCells >> printOn: aStream [

	aStream
		nextPutAll: self asString; cr.
]

{ #category : #accessing }
EitherCells >> rowIndex [
	"
	２つのセルの行インデックスが等しい時は行インデックスを返し,でなければ0を返す
	"
	(cells at: 1) rowIndex = (cells at: 2) rowIndex 
		ifTrue: [ ^(cells at: 1) rowIndex]
		ifFalse: [ ^0 ]
]

{ #category : #'accessing - structure variables' }
EitherCells >> x [

	^self colIndex 
]

{ #category : #'accessing - structure variables' }
EitherCells >> y [

	^self rowIndex 
]
