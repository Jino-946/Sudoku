"
数独の解法の基底クラス


Instance Variables
- sudokuBoard          <SudokuBoard> パズルを解く対象の数独ボード
- relatedRowBlocks     <Dictionary> 垂直方向で関連するブロック [1-4-7][2-5-8][3-6-9]
                                    ブロック番号をキーとし他の2のブロック番号の配列を値とするDictionary
- relatedColumnBlocks  <Dictionary> 水平方向で関連するブロック [1-2-3][4-5-6][7-8-9]
                                    ブロック番号をキーとし他の2のブロック番号の配列を値とするDictionary

"
Class {
	#name : #BasicWay,
	#superclass : #Object,
	#instVars : [
		'sudokuBoard',
		'relatedRowBlocks',
		'relatedColumnBlocks'
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

{ #category : #initialization }
BasicWay >> initialize [ 
	
	relatedRowBlocks := Dictionary new.
	relatedRowBlocks  at: 1 put: #(4 7);
						at: 4 put: #(1 7);
						at: 7 put: #(1 4);
						at: 2 put: #(5 8);
						at: 5 put: #(2 8);
						at: 8 put: #(2 5);
						at: 3 put: #(6 9);
						at: 6 put: #(3 9);
						at: 9 put: #(3 6).
						
	relatedColumnBlocks := Dictionary new.
	relatedColumnBlocks   at: 1 put: #(2 3);
							at: 2 put: #(1 3);
							at: 3 put: #(1 2);
							at: 4 put: #(5 6);
							at: 5 put: #(4 6);
							at: 6 put: #(4 5);
							at: 7 put: #(8 9);
							at: 8 put: #(7 9);
							at: 9 put: #(7 8).
						
					
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
