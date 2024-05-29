Class {
	#name : #AllmostFinishedMethod,
	#superclass : #DaddyNumPreMethod,
	#instVars : [
		'missingNumbers'
	],
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #logic }
AllmostFinishedMethod >> findBlocks [
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

{ #category : #logic }
AllmostFinishedMethod >> finish1stColumn: cells [
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

{ #category : #logic }
AllmostFinishedMethod >> finish1stRow: cells [
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

{ #category : #logic }
AllmostFinishedMethod >> finish2ndColumn: cells [
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

{ #category : #logic }
AllmostFinishedMethod >> finish2ndRow: cells [
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
AllmostFinishedMethod >> finishBlocks [
	"
	ブロック内のブランクセルを特定の数字に確定できた時ボードに書き込む
	"
	| blocks |
	blocks := self findBlocks .
	blocks do: [ :block | | blankCells |
		blankCells := block blankCellsAsArray .
		blankCells size = 1 ifTrue: [ | cell |
			cell := block tsumo.
			cell class = SudokuCell ifTrue: [ sudokuBoard map: cell ]].
		blankCells size = 2 ifTrue: [ self finishPairCells: blankCells block: block ]
	]

]

{ #category : #logic }
AllmostFinishedMethod >> finishPairCells: cells block: block [
	"
	finishBlocksの下請けメソッド
	ブロックのブランクセルペアに2つの特定の数字(ブロックに入っていない2つの数字)が入ることを確認する
	"
	| result |
	result := false.
	missingNumbers := self missingNumbers: block blockA2D asArray.
	(self finish1stColumn: cells) 
		ifFalse: [ (self finish2ndColumn: cells)
			ifFalse: [ (self finish1stRow: cells) 
				ifFalse: [self finish2ndRow: cells]]].
									
	

]
