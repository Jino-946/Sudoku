Class {
	#name : 'BilateralAllianceTest',
	#superclass : 'TestCase',
	#category : 'M946-Sudoku2-Tests',
	#package : 'M946-Sudoku2',
	#tag : 'Tests'
}

{ #category : 'tests' }
BilateralAllianceTest >> testTreatAsAsymmetricPair1 [
	"
	thisCellの予約数が2種類、otherCellの予約数が1種類の非対称ペア 

	block 7
	---------	
	2  1  $38   <= thisCell
	4  5  $8
	9  4  $3	
	"
	| thisCell otherCell ba |
	"セル初期化"
	thisCell := SudokuCell row: 7 column: 3 element: 0.
	thisCell addPossibleNumber: 3; addPossibleNumber: 8.
	otherCell := SudokuCell row: 8 column: 3 element: 0.
	otherCell addPossibleNumber: 8.

	"thisCell の3が確定"
	thisCell element: 3.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsAsymmetricPair1   .
	self assert: thisCell equals: ((SudokuCell row: 7 column: 3 element: 3) addPossibleNumber: 3; addPossibleNumber: 8).
	self assert: thisCell possibleNumbers size equals: 2.
	self assert: otherCell equals: (SudokuCell row: 8 column: 3 element: 8).
	

	"セル初期化"
	thisCell := SudokuCell row: 7 column: 3 element: 0.
	thisCell addPossibleNumber: 3; addPossibleNumber: 8.
	otherCell := SudokuCell row: 9 column: 3 element: 0.
	otherCell addPossibleNumber: 3.

	"thisCell の8が確定"
	thisCell element: 8.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsAsymmetricPair1   .
	self assert: thisCell equals: ((SudokuCell row: 7 column: 3 element: 8) addPossibleNumber: 3; addPossibleNumber: 8).
	self assert: thisCell possibleNumbers size equals: 2.
	self assert: otherCell equals: (SudokuCell row: 9 column: 3 element: 3).
	self assert: otherCell possibleNumbers size equals: 0.	
		
	"セル初期化"
	thisCell := SudokuCell row: 7 column: 3 element: 0.
	thisCell addPossibleNumber: 3; addPossibleNumber: 8.
	otherCell := SudokuCell row: 9 column: 3 element: 0.
	otherCell addPossibleNumber: 3.

	"thisCellに1、8以外の数字が入るとエラーが送出される"
	thisCell element: 7.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	self should: [ba treatAsAsymmetricPair1 ] raise: Error.
		

]

{ #category : 'tests' }
BilateralAllianceTest >> testTreatAsAsymmetricPair2 [
	"
	thisCellの予約数が1種類、otherCellの予約数が2種類の非対称ペア 

	block 7
	---------	
	2  1  $38   <= otherCell
	4  5  $8
	9  4  $3	
	"
	| thisCell otherCell ba |
	"セル初期化"
	thisCell := SudokuCell row: 8 column: 3 element: 0.
	thisCell addPossibleNumber: 8.
	otherCell := SudokuCell row: 7 column: 3 element: 0.
	otherCell addPossibleNumber: 8; addPossibleNumber: 3.
	
	"thisCell の8が確定"
	thisCell element: 8.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsAsymmetricPair2.
	
	self assert: thisCell equals: (SudokuCell row: 8 column: 3 element: 8).
	self assert: otherCell equals: ((SudokuCell row: 7 column: 3  element: 0) addPossibleNumber: 3).

	"セル初期化"
	thisCell := SudokuCell row: 9 column: 3 element: 0.
	thisCell addPossibleNumber: 3.
	otherCell := SudokuCell row: 7 column: 3 element: 0.
	otherCell addPossibleNumber: 8; addPossibleNumber: 3.

	"thisCell の3が確定"
	thisCell element: 3.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsAsymmetricPair2.
	
	self assert: thisCell equals: (SudokuCell row: 9 column: 3 element: 3).
	self assert: otherCell equals: ((SudokuCell row: 7 column: 3  element: 0) addPossibleNumber: 8).

]

{ #category : 'tests' }
BilateralAllianceTest >> testTreatAsOnePair [

	| thisCell otherCell ba logger |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
	logger clearLog.
	
	thisCell := SudokuCell row: 3 column: 4  element: 0.
	thisCell addPossibleNumber: 2.
	otherCell := SudokuCell row: 3 column: 6 element: 0.
	otherCell addPossibleNumber: 2.

	"thisCell のブランクが確定"
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsOnePair .
	self assert: thisCell equals: (SudokuCell row: 3 column: 4 element: 0).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 3 column: 6 element: 2).
	self assert: otherCell possibleNumbers size equals: 0.	

	thisCell := SudokuCell row: 3 column: 4  element: 0.
	thisCell addPossibleNumber: 2.
	otherCell := SudokuCell row: 3 column: 6 element: 0.
	otherCell addPossibleNumber: 2.
	thisCell element: 2.
	"thisCell の予約数 2が確定"
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsOnePair .
	self assert: thisCell equals: (SudokuCell row: 3 column: 4 element: 2).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 3 column: 6 element: 0).
	self assert: otherCell possibleNumbers size equals: 0.	


	thisCell := SudokuCell row: 3 column: 4  element: 0.
	thisCell addPossibleNumber: 2.
	otherCell := SudokuCell row: 3 column: 6 element: 0.
	otherCell addPossibleNumber: 2.
	thisCell element: 7.
	"thisCell が予約数以外の7に確定"
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsOnePair .
	self assert: thisCell equals: (SudokuCell row: 3 column: 4 element: 7).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 3 column: 6 element: 2).
	self assert: otherCell possibleNumbers size equals: 0.	



]

{ #category : 'tests' }
BilateralAllianceTest >> testTreatAsTwoPairs [

	| thisCell otherCell ba |
	"セル初期化"
	thisCell := SudokuCell row: 4 column: 7 element: 0.
	thisCell addPossibleNumber: 1; addPossibleNumber: 8.
	otherCell := SudokuCell row: 6 column: 7 element: 0.
	otherCell addPossibleNumber: 1; addPossibleNumber: 8.
	
	"thisCell の1が確定"
	thisCell element: 1.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsTwoPairs  .
	self assert: thisCell equals: (SudokuCell row: 4 column: 7 element: 1).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 6 column: 7 element: 8).
	self assert: otherCell possibleNumbers size equals: 0.	

	"セル初期化"
	thisCell := SudokuCell row: 4 column: 7 element: 0.
	thisCell addPossibleNumber: 1; addPossibleNumber: 8.
	otherCell := SudokuCell row: 6 column: 7 element: 0.
	otherCell addPossibleNumber: 1; addPossibleNumber: 8.
	
	"thisCell の8が確定"
	thisCell element: 8.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	ba treatAsTwoPairs  .
	self assert: thisCell equals: (SudokuCell row: 4 column: 7 element: 8).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 6 column: 7 element: 1).
	self assert: otherCell possibleNumbers size equals: 0.	



	"セル初期化"
	thisCell := SudokuCell row: 4 column: 7 element: 0.
	thisCell addPossibleNumber: 1; addPossibleNumber: 8.
	otherCell := SudokuCell row: 6 column: 7 element: 0.
	otherCell addPossibleNumber: 1; addPossibleNumber: 8.
	
	"thisCellには1、8以外が入るとエラーが送出される"
	thisCell element: 7.
	ba := BilateralAlliance thisCell: thisCell otherCell: otherCell.
	self should: [ ba treatAsTwoPairs ] raise: Error .



]
