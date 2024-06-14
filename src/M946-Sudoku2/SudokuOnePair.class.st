"
ブロックに2個のブランクセルがあり,どちらかのセルに[特定の数字]が必ず入る状態を表す。
ブランクセル双方にSudokuOnePairのインスタンスをセットする。
同一行にaSudokuOnePairが並んでいるとその行の他のセルには[特定の数字]が入ることは無いことが確定する。
同一列にaSudokuOnePairが並んでいるときも同様である。

Instance Variables
theNumber        <Integer>

"
Class {
	#name : #SudokuOnePair,
	#superclass : #SudokuPairCells,
	#instVars : [
		'theNumber'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #converting }
SudokuOnePair >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: '$'; nextPutAll: theNumber asString.
	
	^aStream contents 
]

{ #category : #accessing }
SudokuOnePair >> theNumber [

	^theNumber 
]

{ #category : #accessing }
SudokuOnePair >> theNumber: anInteger [

	theNumber := anInteger 
]
