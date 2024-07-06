"
複数セルの並ぶ向き

	Class methods
	 CellDirection vertical   複数セルが垂直に並んでいる。(x座標が等しい)
	 CellDirection horizontal 複数セルが垂直に並んでいる。(y座標が等しい)
	 CellDirection diagonal   複数セルが斜めに並んでいる。(x座標y座標共に等しくない)
"
Class {
	#name : #CellDirection,
	#superclass : #Enum,
	#category : #'M946-Sudoku2-Enum'
}

{ #category : #'row/column operations' }
CellDirection class >> diagonal [

	^self new value: #diagonal
]

{ #category : #accessing }
CellDirection class >> horizontal [

	^self new value: #horizontal
]

{ #category : #accessing }
CellDirection class >> vertical [

	^self new value: #vertical
]
