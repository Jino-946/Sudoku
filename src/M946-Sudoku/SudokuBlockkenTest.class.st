Class {
	#name : #SudokuBlockkenTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku-Tests'
}

{ #category : #tests }
SudokuBlockkenTest >> testToBoardCoordinatesRowColumn [

	|sBoard sBlock actual expected|
	sBoard := SudokuBoard new.
	sBoard setExample0 .
	
	"Test Block1"
	sBlock := sBoard blockkenAt: 1.
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  1 column: 1.
	
	expected := BoardCoordinates new.
	"SudokuBoard座標"
	expected row: 1 column: 1.
	self assert: actual equals: expected.
	
	"Test Block5"
	sBlock := sBoard blockkenAt: 5.
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  2 column: 3.
	"SudokuBoard座標"
	expected row: 5 column: 6.
	self assert: actual equals: expected.
	
	actual := sBlock toBoardCoordinatesRow:  3 column: 2.
	expected row: 6 column: 5.
	self assert: actual equals: expected.
	
	"Test Block6"
	sBlock := sBoard blockkenAt: 6.
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  2 column: 3.
	"SudokuBoard座標"
	expected row: 5 column: 9.
	self assert: actual equals: expected.
	
	"SudokuBlockken座標"
	actual := sBlock toBoardCoordinatesRow:  3 column: 2.
	"SudokuBoard座標"
	expected row: 6 column: 8.
	self assert: actual equals: expected.
	
	
	"Test Block8"
	sBlock := sBoard blockkenAt: 8.
	actual := sBlock toBoardCoordinatesRow:  2 column: 3.
	expected row: 8 column: 6.
	self assert: actual equals: expected.
	
	actual := sBlock toBoardCoordinatesRow:  3 column: 2.
	expected row: 9 column: 5.
	self assert: actual equals: expected.

]
