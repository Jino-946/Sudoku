Class {
	#name : #SudokuCellTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #private }
SudokuCellTest >> performTest [ 

    | logger |
    logger := TinyLogger new addTranscriptLogger ; yourself .
    logger  timestampFormatBlock: [ :aStream :timestamp |
            timestamp asDate yyyymmdd printOn: aStream.
            aStream << ' '.
            timestamp asTime print24: true on: aStream ].
    logger clearLog.
    
    TinyCurrentLogger value: logger during: [ super performTest ]
]

{ #category : #tests }
SudokuCellTest >> testBlockNumber [

	| cell |
	1 to: 3 do: [ :y |
		1 to: 3 do: [ :x |
			cell := SudokuCell	row: y column: x  element: 0 .
			self assert: cell blockNumber equals: 1 ].
		4 to: 6 do: [ :x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: cell blockNumber equals: 2 ].
		7 to: 9 do: [ : x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: cell blockNumber equals: 3 ]].
	
	4 to: 6 do: [ :y |
		1 to: 3 do: [ :x |
			cell := SudokuCell	row: y column: x  element: 0 .
			self assert: cell blockNumber equals: 4  ].
		4 to: 6 do: [ :x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: cell blockNumber equals: 5 ].
		7 to: 9 do: [ : x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: cell blockNumber equals: 6 ]].		
		
	7 to: 9 do: [ :y |
		1 to: 3 do: [ :x |
			cell := SudokuCell	row: y column: x  element: 0 .
			self assert: cell blockNumber equals: 7 ].
		4 to: 6 do: [ :x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: cell blockNumber equals: 8 ].
		7 to: 9 do: [ : x |
			cell := SudokuCell row: y column: x element: 0.
			self assert: cell blockNumber equals: 9 ]].		
		
		
		
			 
		
		 
	
]
