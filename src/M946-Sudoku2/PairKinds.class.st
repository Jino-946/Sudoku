"
SudokuPairCellsの種類を表す

**PairKinds onePair**
ブロックに2個のブランクセルがあり,どちらかのセルに**[特定の数字(1つ)]**が必ず入る状態を表す。
ブランクセル双方にSudokuPairCellsのインスタンスをセットする。
同一行にaSudokuPairCellsが並んでいるとその行の他のセルには**[その数字]**が入ることは無いことが確定する。
同一列にaSudokuPairCellsが並んでいるときも同様である。


**PairKinds twoPair**
ブロックに2個のブランクセルがあり,どちらのセルにも**[特定の数字ペアの片方]**が必ず入る状態を表す。
ブランクセル双方にSudokuPairCellsのインスタンスをセットする。
同一行にaSudokuPairCellsが並んでいるとその行の他のセルには**[数字ペアのどちらも]**が入ることは無いことが確定する。
同一列にaSudokuPairCellsが並んでいるときも同様である。

**PairKinds isolated**
上記以外の場合を表す。




"
Class {
	#name : #PairKinds,
	#superclass : #Enum,
	#category : #'M946-Sudoku2-Enum'
}

{ #category : #creating }
PairKinds class >> isolated [

	^self new value: #isolated
]

{ #category : #creating }
PairKinds class >> onePair [

	^self new value: #onePair
]

{ #category : #creating }
PairKinds class >> twoPair [

	^self new value: #twoPair 
]
