"
数独の解法の基底クラス


    Instance Variables
	sudokuBoard		<SudokuBoard>	パズルを解く対象の数独ボード


"
Class {
	#name : #BasicWay,
	#superclass : #Object,
	#instVars : [
		'sudokuBoard'
	],
	#category : #'M946-Sudoku2-Core'
}

{ #category : #'instance creation' }
BasicWay class >> new: sudokuBoard [

	| way |
	way := self new.
	way sudokuBoard: sudokuBoard .
	^ way
]

{ #category : #'private - helpers' }
BasicWay >> blankCell [ 

	^0
]

{ #category : #accessing }
BasicWay >> sudokuBoard [

	^sudokuBoard 
]

{ #category : #accessing }
BasicWay >> sudokuBoard: aBoard [

	sudokuBoard := aBoard 
]

{ #category : #creation }
BasicWay >> sudokuColumnAt: colIndex [

	^ SudokuColumn new: colIndex column: (sudokuBoard atColumn: colIndex) 
	
]

{ #category : #accessing }
BasicWay >> sudokuRowAt: rowIndex [

	^SudokuRow new: rowIndex row: (sudokuBoard atRow: rowIndex)
]
