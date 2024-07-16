Class {
	#name : #EitherCellTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
EitherCellTest >> testDeterminTheNumber [

	| logger  board  thisCell otherCell eitherCell resultCell |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/forRemovePossibleNumbers.fuel';
        materializeRoot .
	logger info: board .

	logger info: 'Testing One Pair...'.
	thisCell := board boardA2D at: 4 at: 5.
	thisCell element: 1.
	otherCell := board boardA2D at: 6 at: 5.
	eitherCell := EitherCell thisCell: thisCell otherCell: otherCell.
	resultCell := eitherCell determineTheNumber .
	self assert: resultCell element equals: 0.

	logger info: 'Testing Two Pairs...'.
	thisCell := board boardA2D at: 7 at: 3.
	thisCell element: 7.
	otherCell := board boardA2D at: 9 at: 3.
	eitherCell := EitherCell thisCell: thisCell otherCell: otherCell.
	resultCell := eitherCell determineTheNumber .
	self assert: resultCell element equals: 3.

]

{ #category : #tests }
EitherCellTest >> testDeterminTheNumber2 [

	| logger  board  thisCell otherCell eitherCell resultCell |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/forRemovePossibleNumbers.fuel';
        materializeRoot .
	logger info: board .


	logger info: 'Testing Asymmetric Pair1-1 ...'.
	thisCell := board boardA2D at: 3 at: 2.
	thisCell element: 3.
	otherCell := board boardA2D at: 2 at: 2.
	eitherCell := EitherCell thisCell: thisCell otherCell: otherCell.
	resultCell := eitherCell determineTheNumber .
	self assert: resultCell element equals: 5.
	self assert: resultCell possibleNumbers isEmpty equals: true.


]

{ #category : #tests }
EitherCellTest >> testDeterminTheNumber3 [

	| logger  board  thisCell otherCell eitherCell resultCell |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/forRemovePossibleNumbers.fuel';
        materializeRoot .
	logger info: board .

	logger info: 'Testing Asymmetric Pair1-2 ...'.
	thisCell := board boardA2D at: 3 at: 2.
	thisCell element: 5.
	otherCell := board boardA2D at: 2 at: 2.
	eitherCell := EitherCell thisCell: thisCell otherCell: otherCell.
	resultCell := eitherCell determineTheNumber .
	self assert: resultCell element equals: 0.
	self assert: resultCell possibleNumbers isEmpty equals: true.



]

{ #category : #tests }
EitherCellTest >> testDeterminTheNumber4 [

	| logger  board  thisCell otherCell eitherCell resultCell |
	logger := M946Logger new: LogLevel info.
	logger clearLog .
	logger info: thisContext.

	board := FLMaterializer new 
        filePath: 'fuel/forRemovePossibleNumbers.fuel';
        materializeRoot .
	logger info: board .

	logger info: 'Testing Asymmetric Pair1-2 ...'.
	thisCell := board boardA2D at: 2 at: 2.
	thisCell element: 5.
	otherCell := board boardA2D at: 3 at: 2.
	eitherCell := EitherCell thisCell: thisCell otherCell: otherCell.
	resultCell := eitherCell determineTheNumber .
	self assert: resultCell element equals: 0.
	self assert: resultCell possibleNumbers size equals: 1.
	self assert: (resultCell possibleNumbers at: 1) equals: 3



]
