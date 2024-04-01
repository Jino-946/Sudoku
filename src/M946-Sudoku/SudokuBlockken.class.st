Class {
	#name : #SudokuBlockken,
	#superclass : #Object,
	#instVars : [
		'blockkenA2D',
		'boardRows',
		'boardCols'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
SudokuBlockken >> = aSudokuBlockken [

	^ aSudokuBlockken class == self class
		and: [ aSudokuBlockken blockkenA2D = self blockkenA2D 
				and: [ aSudokuBlockken boardRows = self boardRows 
					and: [ aSudokuBlockken boardCols = self boardCols ] ] ]
	
]

{ #category : #accessing }
SudokuBlockken >> blockkenA2D [

	^blockkenA2D
]

{ #category : #helper }
SudokuBlockken >> blockkenAsString [
	"
	Array2D >> printOn: による表示乱れを解消する為のヘルパーメソッド	
	"
	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: '=========';  cr.
	(1 to: blockkenA2D  numberOfRows)
		do: [ :r |
				(blockkenA2D  atRow: r)
					do: [ :each | aStream print: each ]
					separatedBy: [ aStream tab ]]
		separatedBy: [ aStream cr ].
	aStream cr; nextPutAll: '========='.
	
	^aStream contents

	
]

{ #category : #accessing }
SudokuBlockken >> boardCols [
	"blockkenの列のindex(1-3)に対応するSudokuBoardのindex配列を返す"
	^boardCols 
]

{ #category : #accessing }
SudokuBlockken >> boardRows [
	"blockkenの行のindex(1-3)に対応するSudokuBoardのindex配列を返す"
	^boardRows 
]

{ #category : #initialization }
SudokuBlockken >> initialize [ 

	super initialize .
	blockkenA2D := Array2D new:  3 element: 0.
	boardRows  := Array braceWith: 0 with:0  with: 0.
	boardCols  := Array braceWith: 0 with:0  with: 0.
	
]

{ #category : #printing }
SudokuBlockken >> printOn: aStream [

	aStream
		nextPutAll: 'blockkenA2D'; cr;
		nextPutAll: self blockkenAsString; cr;
		nextPutAll: 'board rows: ';
		nextPutAll: boardRows  asString;cr;
		nextPutAll: 'board cols: ';
		nextPutAll: boardCols asString
]

{ #category : #accessing }
SudokuBlockken >> row: rowIndex column: colIndex [

	^blockkenA2D at: rowIndex at: colIndex 
]

{ #category : #accessing }
SudokuBlockken >> row: rowIndex column: colIndex put: aNumber [

	^blockkenA2D at: rowIndex at: colIndex put: aNumber
]
