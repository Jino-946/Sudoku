Class {
	#name : 'MDeserialize',
	#superclass : 'Object',
	#category : 'M946-Commons-Util',
	#package : 'M946-Commons',
	#tag : 'Util'
}

{ #category : 'instance creation' }
MDeserialize class >> fileNamed: pathToFile [

	^self path: pathToFile 
]

{ #category : 'accessing' }
MDeserialize class >> path: filePath [

	| flMateraializer |
	(File exists: filePath)
		ifTrue: [ 
			^flMateraializer :=  FLMaterializer new 
        			 filePath: filePath;
       	 			 materializeRoot]
		ifFalse: [ 
			self error: 'file not exist "', filePath, '"'].
			 
]
