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

{ #category : #'as yet unclassified' }
BasicWay >> tenpaiOnBlock: blockNumber [
	"
	ボードのblockNumberブロックでブランクセルが1つの時はtrue 
	"
]

{ #category : #'as yet unclassified' }
BasicWay >> tenpaiOnColumn: colIndex [
	"
	ボードのcolIndex列でブランクセルが1つの時はtrue 
	"
]

{ #category : #'as yet unclassified' }
BasicWay >> tenpaiOnRow: rowIndex [
	"
	ボードのrowIndex行でブランクセルが1つの時はtrue 
	"
]

{ #category : #'as yet unclassified' }
BasicWay >> tsumoOnBlock: blockNumber [
	"
	ブロックの9つのセルがブランクセル1つを残し,残りのセルがすべて数字で埋まったとき,ブランクセルに入る数字は
	自動的に決まるのでボードのセル位置にその数字を配置する。
	"

]

{ #category : #'as yet unclassified' }
BasicWay >> tsumoOnColumn: colIndex [
	"
	列の9つのセルがブランクセル1つを残し,残りのセルがすべて数字で埋まったとき,ブランクセルに入る数字は
	自動的に決まるのでボードのセル位置にその数字を配置する。
	"
]

{ #category : #'as yet unclassified' }
BasicWay >> tsumoOnRow: rowIndex [
	"
	行の9つのセルがブランクセル1つを残し,残りのセルがすべて数字で埋まったとき,ブランクセルに入る数字は
	自動的に決まるのでボードのセル位置にその数字を配置する。
	"
]
