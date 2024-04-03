"
SudokuBlockkenの座標をSudokuBoardの座標に変換した座標を保持する。

hash method の実装は[Overriding Equality and Hash in Pharo](https://growi.cloud/blog/3044)を参照した。

    Instance Variables
	column:		<anInteger>
	row:		<anInteger>


    
"
Class {
	#name : #SBCoordinates,
	#superclass : #Object,
	#instVars : [
		'row',
		'column'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
SBCoordinates >> = aBoardCoordinates [

	^aBoardCoordinates class = self class
		and: [ aBoardCoordinates row = self row 
			and: [ aBoardCoordinates column = self column  ]]

	
]

{ #category : #accessing }
SBCoordinates >> column [

	^column


]

{ #category : #accessing }
SBCoordinates >> column: anInteger [

	column := anInteger 


]

{ #category : #comparing }
SBCoordinates >> hash [ 

	^row hash bitXor: column hash
			

]

{ #category : #initialization }
SBCoordinates >> initialize [ 

	super initialize .
	row := 0.
	column := 0.
]

{ #category : #accessing }
SBCoordinates >> row [

	^row
]

{ #category : #accessing }
SBCoordinates >> row: anInteger [

	row := anInteger 
]

{ #category : #accessing }
SBCoordinates >> row: anInt1 column: anInt2 [

	row := anInt1 .
	column := anInt2
]
