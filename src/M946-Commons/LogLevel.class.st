Class {
	#name : #LogLevel,
	#superclass : #Enum,
	#category : #'M946-Commons-Enum'
}

{ #category : #debugging }
LogLevel class >> debug [

	^self new value: #debug
]

{ #category : #accessing }
LogLevel class >> info [

	^self new value: #info
]
