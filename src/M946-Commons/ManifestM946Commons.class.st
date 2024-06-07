"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestM946Commons,
	#superclass : #PackageManifest,
	#category : #'M946-Commons-Manifest'
}

{ #category : #'code-critics' }
ManifestM946Commons class >> ruleCodeCruftLeftInMethodsRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGClassDefinition #(#M946Logger)) #'2024-06-07T13:31:15.892153+09:00') )
]
