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
AlmostMethod >> finish1stColumn: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの最初のセルに直交する列をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| col1 |
	col1  := sudokuBoard atSudokuColumn: (cells at: 1) x.
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
AlmostMethod >> finish1stRow: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの最初のセルに直交する行をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| row1 |
	row1  := sudokuBoard atSudokuRow: (cells at: 1) y.
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
	^true
]

{ #category : #'private - logics' }
AlmostMethod >> finish2ndColumn: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの2番目ののセルに直交する列をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| col2  |
	col2  := sudokuBoard atSudokuColumn: (cells at: 2) x.
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
AlmostMethod >> finish2ndRow: cells [
	"
	finishPairCells:block: の下請けメソッド
	ブランクセルペアの2番目ののセルに直交する行をスキャンしブランクセルに入る数字が確定した時はボードに反映する
	"
	| row2  |
	row2  := sudokuBoard atSudokuRow: (cells at: 2) y.
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
	columns do: [ :column | | blankCells |
		missingNumbers := self missingNumbers: column asArray.
		blankCells := column  blankCellsAsArray .
		blankCells size = 1 ifTrue: [ | cell |
			cell := column allGreen.
			cell class = SudokuCell ifTrue: [ sudokuBoard map: cell ]].
		blankCells size = 2 ifTrue: [ 
			self finish1stRow: blankCells.
			self finish2ndRow: blankCells]
	]

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
	(self finish1stColumn: cells) 
		ifFalse: [ (self finish2ndColumn: cells)
			ifFalse: [ (self finish1stRow: cells) 
				ifFalse: [self finish2ndRow: cells]]].
									
	

]

{ #category : #logic }
AlmostMethod >> finishRows [
	"
	SudokuRow内のブランクセルを特定の数字に確定できた時ボードに反映する
	"
	| rows |
	rows := self findRows  .
	rows do: [ :row | | blankCells |
		missingNumbers := self missingNumbers: row asArray.
		blankCells := row  blankCellsAsArray .
		blankCells size = 1 ifTrue: [ | cell |
			cell := row allGreen.
			cell class = SudokuCell ifTrue: [ sudokuBoard map: cell ]].
		blankCells size = 2 ifTrue: [ 
			self finish1stColumn: blankCells.
			self finish2ndColumn: blankCells]
	]

]

{ #category : #logic }
AlmostMethod >> solve [

	self finishBlocks .
	self finishColumns .
	self finishRows .
]
