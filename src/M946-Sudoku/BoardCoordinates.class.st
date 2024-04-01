"
SudokuBlockkenの座標をSudokuBoardの座標に変換した座標を保持する。

Internal Representation and Key Implementation Points.

    Instance Variables
	column:		<anInteger>
	row:		<anInteger>


    
"
Class {
	#name : #BoardCoordinates,
	#superclass : #Object,
	#instVars : [
		'row',
		'column'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #accessing }
BoardCoordinates >> column [

	^column


]

{ #category : #accessing }
BoardCoordinates >> column: anInteger [

	column := anInteger 


]

{ #category : #initialization }
BoardCoordinates >> initialize [ 

	super initialize .
	row := 0.
	column := 0.
]

{ #category : #accessing }
BoardCoordinates >> row [

	^row
]

{ #category : #accessing }
BoardCoordinates >> row: anInteger [

	row := anInteger 
]
