"
SudokuBlockkenの座標をSudokuBoardの座標に変換した座標を保持する。

hash method の実装は[Overriding Equality and Hash in Pharo](https://growi.cloud/blog/3044)を参照した。

    Instance Variables
	column:		<anInteger>
	row:		<anInteger>


    
"
Class {
	#name : #MCoordinates,
	#superclass : #Object,
	#instVars : [
		'row',
		'column'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
MCoordinates >> = aBoardCoordinates [

	^aBoardCoordinates class = self class
		and: [ aBoardCoordinates row = self row 
			and: [ aBoardCoordinates column = self column  ]]

	
]

{ #category : #accessing }
MCoordinates >> column [

	^column


]

{ #category : #accessing }
MCoordinates >> column: anInteger [

	column := anInteger 


]

{ #category : #comparing }
MCoordinates >> hash [ 

	^row hash bitXor: column hash
			

]

{ #category : #initialization }
MCoordinates >> initialize [ 

	super initialize .
	row := 0.
	column := 0.
]

{ #category : #accessing }
MCoordinates >> row [

	^row
]

{ #category : #accessing }
MCoordinates >> row: anInteger [

	row := anInteger 
]

{ #category : #accessing }
MCoordinates >> row: anInt1 column: anInt2 [

	row := anInt1 .
	column := anInt2
]
