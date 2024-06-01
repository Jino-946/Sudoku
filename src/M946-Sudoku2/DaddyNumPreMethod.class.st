"
「ナンプレおじさんの解き方」の説明をなるべく忠実に実装するクラス

使い方:
```
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := DaddyNumPreMethod new: board .
	2 timesRepeat: [  
		solver beginnerSolutions: board].
	
	board completed  ""=> true""
```
"
Class {
	#name : #DaddyNumPreMethod,
	#superclass : #SudokuSolver,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #logic }
DaddyNumPreMethod >> beginnerSolutions: board [

	(TateNicoMethod new: board) solve.		
	(YokoNicoMethod new: board) solve.	
	(AlmostMethod new: board) solve


]

{ #category : #'private - logics' }
DaddyNumPreMethod >> finishBlock: block number: n [

	| cell |
	cell := block allGreen.
	cell class = SudokuCell ifTrue: [
		sudokuBoard map: cell.
		^ self ].
	cell := block tenpai.
	cell class = SudokuCell ifFalse: [ ^ self ].
	cell element: n.
	sudokuBoard map: cell
]

{ #category : #utilities }
DaddyNumPreMethod >> missingNumbers: anArray [

	^#(1 2 3 4 5 6 7 8 9) difference: (anArray select: [ :n | n class = SmallInteger and:[n > 0]])
]
