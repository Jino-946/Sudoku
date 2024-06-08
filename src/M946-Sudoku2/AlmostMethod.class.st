"
「空きマス少見」テクニックを実装する。
[初級問題の解き方](http://daddy-number-place.blog.jp/syokyu1.pdf)

行・列・ブロックでブランクセルが1または2の時を処理する

Public methods
- solve
	- finishRows
	- finishColums
	- finishBlocks
"
Class {
	#name : #AlmostMethod,
	#superclass : #DaddyNumPreMethod,
	#instVars : [
		'missingNumbers'
	],
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'private - logics' }
AlmostMethod >> findBlocks [
	"
	全てのセルの要素が1桁の数字でブランクセルの個数が3未満のブロックをコレクションにして返す
	"
	| blocks aBlock |
	blocks := OrderedCollection new.
	1 to: 9 do:[ :n | 
		aBlock := (self sudokuBoard) atBlock: n.
		aBlock countOfReservedBlankCells < 3 ifTrue: [ blocks add: aBlock ]].
	^blocks

]

{ #category : #'private - logics' }
AlmostMethod >> findColumns [
	"
	全てのセルの要素が1桁の数字でブランクセルの個数が3未満の列をコレクションにして返す
	"
	| rows row  |
	rows := OrderedCollection new.
	1 to: 9 do:[ :n | 
		row := (self sudokuBoard) atSudokuColumn:  n.
		row countOfReservedBlankCells < 3 ifTrue: [ rows add: row ]].
	^rows

]

{ #category : #'private - logics' }
AlmostMethod >> findRows [
	"
	全てのセルの要素が1桁の数字でブランクセルの個数が3未満の行をコレクションにして返す
	"
	| rows row  |
	rows := OrderedCollection new.
	1 to: 9 do:[ :n | 
		row := (self sudokuBoard) atSudokuRow:  n.
		row countOfReservedBlankCells < 3 ifTrue: [ rows add: row ]].
	^rows

]

{ #category : #'private - logics' }
AlmostMethod >> finish1stCrossingColumn: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの最初のセルに直交する列をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| col1 logger |
	logger := M946Logger new: LogLevel info.
	col1  := sudokuBoard atSudokuColumn: (cells at: 1) x.
	logger debug: thisContext;
			debug: ('missingNumbers: {1}' format: {missingNumbers } ); 
			debug: ('col1: {1}' format: {col1}); cr.

	(col1  includes: (missingNumbers at: 1)) 
		ifTrue: [
			(cells at: 2) element: (missingNumbers at: 1).
			(cells at: 1) element: (missingNumbers at: 2).
			sudokuBoard map: (cells at: 1).
			sudokuBoard map: (cells at: 2).
			^true ]
		ifFalse:[
			(col1 includes: (missingNumbers at: 2)) ifTrue: [  
				(cells at: 2) element: (missingNumbers at: 2).
				(cells at: 1) element: (missingNumbers at: 1).
				sudokuBoard map: (cells at: 1).
				sudokuBoard map: (cells at: 2).
				^true ]].
	^false
]

{ #category : #'private - logics' }
AlmostMethod >> finish1stCrossingRow: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの最初のセルに直交する行をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| row1 logger |
	logger := M946Logger new: LogLevel info.
	row1  := sudokuBoard atSudokuRow: (cells at: 1) y.
	logger debug: thisContext;
			debug: ('missingNumbers: {1}' format: {missingNumbers } ); 
			debug: ('row: {1}' format: {row1}); cr.

	(row1 includes: (missingNumbers at: 1)) 
		ifTrue: [
			(cells at: 2) element: (missingNumbers at: 1).
			(cells at: 1) element: (missingNumbers at: 2).
			sudokuBoard map: (cells at: 1).
			sudokuBoard map: (cells at: 2).
			^true ]
		ifFalse:[
			(row1 includes: (missingNumbers at: 2)) ifTrue: [  
				(cells at: 2) element: (missingNumbers at: 2).
				(cells at: 1) element: (missingNumbers at: 1).
				sudokuBoard map: (cells at: 1).
				sudokuBoard map: (cells at: 2).
				^true ]].
	^false
]

{ #category : #'private - logics' }
AlmostMethod >> finish2ndCrossingColumn: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの2番目ののセルに直交する列をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| col2  logger |
	logger := M946Logger new: LogLevel info.
	col2  := sudokuBoard atSudokuColumn: (cells at: 2) x.
	logger debug: thisContext;
			debug: ('missingNumbers: {1}' format: {missingNumbers } ); 
			debug: ('col2: {1}' format: {col2 }); cr.

	(col2  includes: (missingNumbers at: 1)) 
		ifTrue: [
			(cells at: 1) element: (missingNumbers at: 1).
			(cells at: 2) element: (missingNumbers at: 2).
			sudokuBoard map: (cells at: 1).
			sudokuBoard map: (cells at: 2).
			^true ]
		ifFalse:[
			(col2 includes: (missingNumbers at: 2)) ifTrue: [  
				(cells at: 1) element: (missingNumbers at: 2).
				(cells at: 2) element: (missingNumbers at: 1).
				sudokuBoard map: (cells at: 1).
				sudokuBoard map: (cells at: 2).
				^true ]].
		^false
]

{ #category : #'private - logics' }
AlmostMethod >> finish2ndCrossingRow: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの2番目ののセルに直交する行をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| row2  logger |
	logger := M946Logger new: LogLevel info.
	row2  := sudokuBoard atSudokuRow: (cells at: 2) y.
	logger debug: thisContext;
			debug: ('missingNumbers: {1}' format: {missingNumbers } ); 
			debug: ('row2: {1}' format: {row2}); cr.

	(row2   includes: (missingNumbers at: 1)) 
		ifTrue: [
			(cells at: 1) element: (missingNumbers at: 1).
			(cells at: 2) element: (missingNumbers at: 2).
			sudokuBoard map: (cells at: 1).
			sudokuBoard map: (cells at: 2).
			^true ]
		ifFalse:[
			(row2 includes: (missingNumbers at: 2)) ifTrue: [  
				(cells at: 1) element: (missingNumbers at: 2).
				(cells at: 2) element: (missingNumbers at: 1).
				sudokuBoard map: (cells at: 1).
				sudokuBoard map: (cells at: 2).
				^true ]].
		^false
]

{ #category : #logic }
AlmostMethod >> finishBlocks [
	"
	ブロック内のブランクセルを特定の数字に確定できた時ボードに反映する
	"
	| blocks |
	blocks := self findBlocks .
	blocks do: [ :block | | blankCells |
		blankCells := block blankCellsAsArray .
		blankCells size = 1 ifTrue: [ | cell |
			cell := block allGreen.
			cell class = SudokuCell ifTrue: [ sudokuBoard map: cell ]].
		blankCells size = 2 ifTrue: [ self finishPairCells: blankCells block: block ]
	]

]

{ #category : #logic }
AlmostMethod >> finishColumns [
	"
	SudokuColumn内のブランクセルを特定の数字に確定できた時ボードに反映する
	"
	| columns |
	columns := self findColumns  .
	columns do: [ :column | 
		self finishCurrentColumn: column ]

]

{ #category : #'private - logics' }
AlmostMethod >> finishCurrentColumn: column [

	| blankCells completed logger | 
	logger := M946Logger new: LogLevel info.
	
	missingNumbers := self missingNumbers: column asArray.
	blankCells := column blankCellsAsArray .
	(blankCells size > 2 or:[ blankCells isEmpty] ) ifTrue: [ ^self ].	
	blankCells size = 1 ifTrue: [ 
		| cell |
		cell := column allGreen.
		cell class = SudokuCell ifTrue: [ sudokuBoard map: cell . ^self]].
	
	logger debug: thisContext;  
			debug: ('blankCells: {1}' format: {blankCells});
			debug: sudokuBoard.
	
	completed := self finish1stCrossingRow: blankCells.	
	completed ifFalse: [ completed := self finish2ndCrossingRow: blankCells ].
	
	completed ifTrue: [ 	logger debug: ('column {1} completed {2}' format: { column colIndex . sudokuBoard })
 ]
	
]

{ #category : #'private - logics' }
AlmostMethod >> finishCurrentRow: row [
	"
	finishRowsのループの中の処理を外出し
	"
	| blankCells completed logger |
	logger := M946Logger new: LogLevel info.
	
	missingNumbers := self missingNumbers: row asArray.
	blankCells := row blankCellsAsArray.
	(blankCells size > 2 or: [ blankCells isEmpty ]) ifTrue: [ ^self ].
	blankCells size = 1 ifTrue: [
		| cell |
		cell := row allGreen.
		cell class = SudokuCell ifTrue: [ sudokuBoard map: cell. ^ self] ].

	logger debug: thisContext;  
			debug: ('blankCells: {1}' format: {blankCells});
			debug: sudokuBoard.
			
	completed := self finish1stCrossingColumn: blankCells.
	completed ifFalse: [ completed := self finish2ndCrossingColumn: blankCells ].
	
	completed ifTrue: [ logger debug: ('row {1} completed {2}' format: { row rowIndex . sudokuBoard }) ].
	

]

{ #category : #'private - logics' }
AlmostMethod >> finishPairCells: cells block: block [
	"
	finishBlocksの下請けメソッド
	ブロックのブランクセルペアに2つの特定の数字(ブロックに入っていない2つの数字)が入ることを確認する
	"
	| result |
	result := false.
	missingNumbers := self missingNumbers: block asArray.
	(self finish1stCrossingColumn: cells) 
		ifFalse: [ (self finish2ndCrossingColumn: cells)
			ifFalse: [ (self finish1stCrossingRow: cells) 
				ifFalse: [self finish2ndCrossingRow: cells]]].
									
	

]

{ #category : #logic }
AlmostMethod >> finishRows [
	"
	SudokuRow内のブランクセルを特定の数字に確定できた時ボードに反映する
	"
	| rows  logger |
	logger := M946Logger new: LogLevel debug.
	rows := self findRows  .
	rows do: [ :row | 
		self finishCurrentRow: row.
	]

]

{ #category : #logic }
AlmostMethod >> solve [

	self finishBlocks .
	self finishColumns .
	self finishRows .
]
