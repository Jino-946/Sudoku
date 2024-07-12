"
ブロックにおけるブランクセルが２つになりどちらかのセルに必ず同一の数字が入る場合,
２つのセルの座標をSudokuCellのインスタンスとしてcellsに保持する。

SudokuBlock2オブジェクトのインスタンス変数として生成される。
"
Class {
	#name : #EitherCell,
	#superclass : #Object,
	#instVars : [
		'cells'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #adding }
EitherCell >> add: cell [

	cell class = SudokuCell ifFalse:[ self error: 'a SudokuCell object expected.' ].
	cells size >= 2 ifTrue: [ self error: 'too many SudokuCell objects' ].
	(cells at: 1) element = cell element ifFalse: [ self error: 'same number required.' ].
	cells add: cell
]

{ #category : #converting }
EitherCell >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream  nextPutAll: 'anEitherCells ('; cr;
			 nextPutAll: (cells at: 1) asSimpleString; cr;
			 nextPutAll: (cells at: 2) asSimpleString; cr; 
			 nextPutAll: ')'; cr.
	
	^aStream contents .

]

{ #category : #accessing }
EitherCell >> cells [

	^cells
]

{ #category : #initialization }
EitherCell >> initialize [ 
	super initialize .
	cells := OrderedCollection new.
]

{ #category : #printing }
EitherCell >> printOn: aStream [

	aStream
		nextPutAll: self asString; cr.
]
