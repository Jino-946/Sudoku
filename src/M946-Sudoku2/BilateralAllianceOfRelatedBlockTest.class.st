Class {
	#name : #BilateralAllianceOfRelatedBlockTest,
	#superclass : #TestCase,
	#category : #'M946-Sudoku2-Tests'
}

{ #category : #tests }
BilateralAllianceOfRelatedBlockTest >> testTreatAsAsymmetricPair1 [
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

	"thisCell の同一行(列)上の他セルが3に確定"
	thisCell element: 0.
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 3.
	ba treatAsAsymmetricPair1   .
	self assert: thisCell equals: ((SudokuCell row: 7 column: 3 element: 0) addPossibleNumber: 8).
	self assert: otherCell equals: ((SudokuCell row: 8 column: 3 element: 0) addPossibleNumber: 8).
	
	"セル初期化"
	thisCell := SudokuCell row: 7 column: 3 element: 0.
	thisCell addPossibleNumber: 3; addPossibleNumber: 8.
	otherCell := SudokuCell row: 9 column: 3 element: 0.
	otherCell addPossibleNumber: 3.

	"thisCell の同一行(列)上の他セルが8に確定"
	thisCell element: 0.
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 8.
	ba treatAsAsymmetricPair1   .
	self assert: thisCell equals: ((SudokuCell row: 7 column: 3 element: 0) addPossibleNumber: 3).
	self assert: otherCell equals: ((SudokuCell row: 9 column: 3 element: 0) addPossibleNumber: 3).



]

{ #category : #tests }
BilateralAllianceOfRelatedBlockTest >> testTreatAsAsymmetricPair2 [
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
	
	"thisCell の同一行(列)上の他セルが8に確定"
	thisCell element: 0.
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 8.
	ba treatAsAsymmetricPair2.
	
	self assert: thisCell equals: (SudokuCell row: 8 column: 3 element: 0).
	self assert: otherCell equals: (SudokuCell row: 7 column: 3  element: 8).

	"セル初期化"
]

{ #category : #tests }
BilateralAllianceOfRelatedBlockTest >> testTreatAsOnePair [ 
	"
	同一行(列)の他セルがこのセルの予約数字と同じ数字に確定したワンペア
	"
	| thisCell otherCell ba logger |
	M946FileLogger logLevel: LogLevel debug.
	logger := M946FileLogger new.
	logger clearLog.
	
	thisCell := SudokuCell row: 3 column: 4  element: 0.
	thisCell addPossibleNumber: 2.
	otherCell := SudokuCell row: 3 column: 6 element: 0.
	otherCell addPossibleNumber: 2.

	"thisCell のブランクが確定"
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 2.
	ba treatAsOnePair .
	self assert: thisCell equals: (SudokuCell row: 3 column: 4 element: 0).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 3 column: 6 element: 2).
	self assert: otherCell possibleNumbers size equals: 0.	
]

{ #category : #tests }
BilateralAllianceOfRelatedBlockTest >> testTreatAsTwoPairs [
	"
	同一行(列)の他セルがこのセルの予約数字のいづれかと同じ数字に確定した
	"
	| thisCell otherCell ba |
	"セル初期化"
	thisCell := SudokuCell row: 4 column: 7 element: 0.
	thisCell addPossibleNumber: 1; addPossibleNumber: 8.
	otherCell := SudokuCell row: 6 column: 7 element: 0.
	otherCell addPossibleNumber: 1; addPossibleNumber: 8.
	
	"thisCell "
	thisCell element: 0.
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 1.
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
	
	"thisCell "
	thisCell element: 0.
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 8.
	ba treatAsTwoPairs  .
	self assert: thisCell equals: (SudokuCell row: 4 column: 7 element: 1).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 6 column: 7 element: 8).
	self assert: otherCell possibleNumbers size equals: 0.	
]

{ #category : #tests }
BilateralAllianceOfRelatedBlockTest >> testTreatAsTwoPairs2 [
	"
	同一行(列)の他セルがこのセルの予約数字のいづれかと同じ数字に確定した
	"
	| thisCell otherCell ba |
	"セル初期化"
	thisCell := SudokuCell row: 5 column: 4 element: 0.
	thisCell addPossibleNumber: 2; addPossibleNumber: 6.
	otherCell := SudokuCell row: 5 column: 6 element: 0.
	otherCell addPossibleNumber: 2; addPossibleNumber: 6.
	
	"thisCell "
	ba := BilateralAllianceOfRelatedBlock  thisCell: thisCell otherCell: otherCell confirmNumber: 6.
	ba treatAsTwoPairs  .
	self assert: thisCell equals: (SudokuCell row: 5 column: 4 element: 2).
	self assert: thisCell possibleNumbers size equals: 0.
	self assert: otherCell equals: (SudokuCell row: 5 column: 6 element: 6).
	self assert: otherCell possibleNumbers size equals: 0.	
	
]
