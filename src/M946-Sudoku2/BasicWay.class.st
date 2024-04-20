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

{ #category : #'private - helpers' }
BasicWay >> blankCell [ 

	^0
]

{ #category : #'as yet unclassified' }
BasicWay >> boardAt: rowIndex at: colIndex [
	"
	ボードのrowIndex,colIndex位置のセルの値を返す
	"
]

{ #category : #'as yet unclassified' }
BasicWay >> boardAt: rowIndex at: colIndex put: number [
	"
	ボードのrowIndex,colIndex位置のセルにnumberをセットする
	"
]

{ #category : #accessing }
BasicWay >> sudokuBoard: aBoard [

	sudokuBoard := aBoard 
]
