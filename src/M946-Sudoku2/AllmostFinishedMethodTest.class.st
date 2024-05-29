Class {
	#name : #AllmostFinishedMethodTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #running }
AllmostFinishedMethodTest >> setUp [
	super setUp.

]

{ #category : #tests }
AllmostFinishedMethodTest >> testFindBlocks [

	| blocks solver board task|
	
	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AllmostFinishedMethod new: board.	
	blocks := solver findBlocks .
	
	self assert: 1 equals: blocks size.

	


]

{ #category : #tests }
AllmostFinishedMethodTest >> testFinishBlocks [

	| task board solver|

	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   0 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AllmostFinishedMethod new: board.
	solver finishBlocks .
	
	self assert: 4 equals: (board boardA2D at: 5 at: 4).
	self assert: 7 equals: (board boardA2D at: 5 at: 6).
	




"
	| ex sBoard allmostSolver |
	ex := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 3 2   0 1 7
0 0 0   4 8 0   0 0 0
6 7 0   9 1 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	sBoard := SudokuBoard2 new.
	sBoard loadFromString: ex.
	allmostSolver := AllmostFinishedMethod new: sBoard.
	allmostSolver finishBlocks .
	self assert: 7 equals: (sBoard boardA2D at: 5 at: 6)
"


]

{ #category : #tests }
AllmostFinishedMethodTest >> testFinishBlocks2 [

	| task board solver|

	task := '
3 6 9   8 0 1   5 0 0
0 2 0   5 0 6   0 0 0
0 0 0   0 7 0   0 0 8

0 9 8   6 0 2   0 1 7
0 0 0   4 8 7   0 0 0
6 7 0   9 0 5   8 2 0

9 0 0   0 5 0   0 0 0
0 0 0   2 0 4   0 8 0
0 0 1   7 0 8   9 5 2
'.

	board := SudokuBoard2 new.
	board loadFromString: task.
	solver := AllmostFinishedMethod new: board.
	solver finishBlocks .
	
	self assert: 3 equals: (board boardA2D at: 4 at: 5).
	self assert: 1 equals: (board boardA2D at: 6 at: 5).
	

]
