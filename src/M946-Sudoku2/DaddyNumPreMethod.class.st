"
「ナンプレおじさんの解き方」の説明をなるべく忠実に実装するクラス
"
Class {
	#name : #DaddyNumPreMethod,
	#superclass : #SudokuSolver,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #utilities }
DaddyNumPreMethod >> missingNumbers: anArray [

	^#(1 2 3 4 5 6 7 8 9) difference: (anArray select: [ :n | n class = SmallInteger and:[n > 0]])
]
