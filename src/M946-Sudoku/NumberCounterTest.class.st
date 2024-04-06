Class {
	#name : #NumberCounterTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku-Tests'
}

{ #category : #tests }
NumberCounterTest >> testBoardOf [

	|example sb   nc1 nc2 |
	example := 
	#(  #(1 9 7  0 0 4  2 0 5) 
		#(6 8 0  5 3 0  9 0 0) 
		#(5 0 3  0 7 2  1 6 8)
	
		#(0 6 0  4 0 9  7 0 2) 
		#(0 7 5  0 1 0  6 8 0) 
		#(2 0 9  8 0 7  0 4 0) 
	
		#(7 5 6  3 2 0  4 0 1) 
		#(0 0 1  0 4 5  0 2 6) 
		#(8 0 4  1 0 0  3 5 7)).
	
	
	sb := SudokuBoard new.
	sb loadExample: example.

	nc1 := sb numberCounter .
	
	nc2 := NumberCounter new.
	nc2 at: 1 put: 6;
		at: 2 put: 6;
		at: 3 put: 4;
		at: 4 put: 6;
		at: 5 put: 7;
		at: 6 put: 6;
		at: 7 put: 7;
		at: 8 put: 5;
		at: 9 put: 4.
		
	self assert: nc1 equals: nc2 .
	
	sb setDummy .
	nc1 := sb numberCounter .
	nc2 at: 1 put: 9;
		at: 2 put: 9;
		at: 3 put: 9;
		at: 4 put: 9;
		at: 5 put: 9;
		at: 6 put: 9;
		at: 7 put: 9;
		at: 8 put: 9;
		at: 9 put: 9.
	

	
]

{ #category : #tests }
NumberCounterTest >> testIncompleteNumbers [

	| nc sb |
	nc := NumberCounter new.
	
	self assert: nc incompleteNumbers size equals: 9.
	
	nc numberCount at: 2 put: 9.
	nc numberCount at: 5 put: 9.
	self assert: nc incompleteNumbers size equals: 7.
	
	sb := SudokuBoard new.
	sb setDummy .
	nc := sb numberCounter .
	self assert: nc incompleteNumbers size equals: 0.	
	
	

]

{ #category : #tests }
NumberCounterTest >> testIncrementAt [

	| nc |
	nc := NumberCounter new.
	nc incrementAt: 3.	
	self assert: (nc at: 3) equals: 1.
	
	"NumberCounter を再初期化する"
	nc  at: 1 put: 6;
		at: 2 put: 6;
		at: 3 put: 4;
		at: 4 put: 6;
		at: 5 put: 7;
		at: 6 put: 6;
		at: 7 put: 7;
		at: 8 put: 5;
		at: 9 put: 4.		
	nc incrementAt: 1.
	self assert: (nc at: 1) equals: 7.
		
	nc incrementAt: 8.
	self assert: (nc at: 8) equals: 6
]
