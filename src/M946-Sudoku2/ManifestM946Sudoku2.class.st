"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestM946Sudoku2,
	#superclass : #PackageManifest,
	#category : #'M946-Sudoku2-Manifest'
}

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#BlockenWay #example #false)) #'2024-04-21T13:13:16.105442+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleReTestClassNotInPackageWithTestEndingNameRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGPackageDefinition #(#'M946-Sudoku2')) #'2024-04-20T20:34:12.520286+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku2 class >> ruleToDoWithIncrementRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBlock2 #blankCellsAsArray #false)) #'2024-04-22T11:09:08.16891+09:00') )
]
