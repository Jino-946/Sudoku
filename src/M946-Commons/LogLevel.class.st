"
Enumを継承した列挙型クラス


メソッド定義)
```
M946Logger>>debug: anObject

	logLevel = LogLevel debug ifTrue: [ self record: anObject ].
	
	
M946Logger>>info: anObject

	logLevel = LogLevel info ifTrue: [ self record: anObject ]
```

利用例)
```
	| logger | 
	logger := M946Logger new: LogLevel debug.
	logger debug: thisContext.
		
```

"
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
