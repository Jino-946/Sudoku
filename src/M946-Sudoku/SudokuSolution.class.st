"
数独の解法を実装するクラス



"
Class {
	#name : #SudokuSolution,
	#superclass : #Object,
	#instVars : [
		'board'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #logic }
SudokuSolution >> tryBlockkenWay [
	"
	ブロッケン法でパズルを解く。
	「ブロックで見る」法を略して「ブロッ見(ケン)｣法 Japanglishに翻訳して「BlockkenWay｣ 
	"
]
