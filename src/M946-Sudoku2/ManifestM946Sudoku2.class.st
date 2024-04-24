"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestM946Sudoku2,
	#superclass : #PackageManifest,
	#category : #'M946-Sudoku2-Manifest'
}

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleAssignmentInIfTrueRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBlock2 #rowIndexOnBoard: #false)) #'2024-04-23T13:48:10.915472+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#BlockenWay #example #false)) #'2024-04-21T13:13:16.105442+09:00') #(#(#RGMethodDefinition #(#LetsmeWayTest #testLetsme #false)) #'2024-04-23T10:50:11.828391+09:00') #(#(#RGMethodDefinition #(#LetsmeWay #letsme: #false)) #'2024-04-23T11:18:34.14086+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleInconsistentMethodClassificationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBoard2 #asString #false)) #'2024-04-24T22:32:17.066595+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleReTestClassNotInPackageWithTestEndingNameRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'M946-Sudoku2')) #'2024-04-20T20:34:12.520286+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleStringConcatenationRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBoard2 #loadFromString: #false)) #'2024-04-24T22:20:52.263951+09:00') #(#(#RGMethodDefinition #(#SudokuBoard2 #asString #false)) #'2024-04-24T22:31:59.12461+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleToDoWithIncrementRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBlock2 #blankCellsAsArray #false)) #'2024-04-22T11:09:08.16891+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleUtilityMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#AwasewazaWay #solve: #false)) #'2024-04-24T11:28:18.427734+09:00') )
]
