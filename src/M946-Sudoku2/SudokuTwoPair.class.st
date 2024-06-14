"
ブロックに2個のブランクセルがあり,どちらかのセルに[特定の数字ペア]が必ず入る状態を表す。
ブランクセル双方にSudokuTwoPairのインスタンスをセットする。
同一行にaSudokuTwoPairが並んでいるとその行の他のセルには[特定の数字ペア]が入ることは無いことが確定する。
同一列にaSudokuTwoPairが並んでいるときも同様である。

Instance Variables
pairOfNumbers      <OrderedCollection>

"
Class {
	#name : #SudokuTwoPair,
	#superclass : #SudokuPairCells,
	#instVars : [
		'pairOfNumbers'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #adding }
SudokuTwoPair >> addNumber: anInteger [

	pairOfNumbers add: anInteger .
]

{ #category : #converting }
SudokuTwoPair >> asString [

	| aStream |
	aStream := ReadWriteStream on: String new.
	aStream nextPutAll: (pairOfNumbers at: 1); nextPutAll: (pairOfNumbers at: 2).
	
	^aStream contents 
]

{ #category : #initialization }
SudokuTwoPair >> initialize [ 

	super initialize .
	pairOfNumbers := OrderedCollection new.
]

{ #category : #accessing }
SudokuTwoPair >> pairOfNumbers [

	^ pairOfNumbers
]
