Class {
	#name : #Enum,
	#superclass : #Object,
	#instVars : [
		'value'
	],
	#category : #'M946-Commons-Enum'
}

{ #category : #comparing }
Enum >> = anEnum [	

	^self class = anEnum class and: [ self value = anEnum value ]
]

{ #category : #comparing }
Enum >> hash [ 

	^self class hash bitXor: self value hash
	
]

{ #category : #printing }
Enum >> printOn: aStream [

	super printOn: aStream .
	aStream << '(' << self value asString << ')'
]

{ #category : #evaluating }
Enum >> value [ 

	^value
]

{ #category : #accessing }
Enum >> value: aValue [

	value := aValue
]
