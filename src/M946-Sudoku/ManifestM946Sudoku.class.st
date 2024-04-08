"
数独パズルの課題を解くアプリケーション
"
Class {
	#name : #ManifestM946Sudoku,
	#superclass : #PackageManifest,
	#category : #'M946-Sudoku-Manifest'
}

{ #category : #'code-critics' }
ManifestM946Sudoku class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBoard #executeExample #false)) #'2024-04-06T23:29:16.359337+09:00') #(#(#RGMethodDefinition #(#SudokuBoard #beginersSolution: #false)) #'2024-04-07T15:10:25.333909+09:00') #(#(#RGMethodDefinition #(#SudokuBoard #beginnersSolution: #false)) #'2024-04-07T15:12:39.079178+09:00') #(#(#RGMethodDefinition #(#SudokuBoard #solution: #false)) #'2024-04-08T13:54:04.460098+09:00') )
]

{ #category : #'code-critics' }
ManifestM946Sudoku class >> ruleToDoWithIncrementRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#SudokuBlock #nonBlankCells #false)) #'2024-04-08T10:50:34.175608+09:00') #(#(#RGMethodDefinition #(#SudokuBlock #coordinatesOfBlankCells #false)) #'2024-04-08T10:50:54.061485+09:00') )
]
