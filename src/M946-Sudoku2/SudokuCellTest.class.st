Class {
	#name : #SudokuCellTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
SudokuCellTest >> testBlockNumber [

	| cell |
	1 to: 3 do: [ :y |
		1 to: 3 do: [ :x |
			cell := SudokuCell	row: y column: x  element: 0 .
			self assert: 1 equals: cell blockNumber ].
		4 to: 6 do: [ :x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: 2 equals: cell blockNumber ].
		7 to: 9 do: [ : x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: 3 equals: cell blockNumber ]].
	
	4 to: 6 do: [ :y |
		1 to: 3 do: [ :x |
			cell := SudokuCell	row: y column: x  element: 0 .
			self assert: 4 equals: cell blockNumber ].
		4 to: 6 do: [ :x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: 5 equals: cell blockNumber ].
		7 to: 9 do: [ : x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: 6 equals: cell blockNumber ]].		
		
	7 to: 9 do: [ :y |
		1 to: 3 do: [ :x |
			cell := SudokuCell	row: y column: x  element: 0 .
			self assert: 7 equals: cell blockNumber ].
		4 to: 6 do: [ :x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: 8 equals: cell blockNumber ].
		7 to: 9 do: [ : x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: 9 equals: cell blockNumber ]].		
		
		
		
			 
		
		 
	
]
