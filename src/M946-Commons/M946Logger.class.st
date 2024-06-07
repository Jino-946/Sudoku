"
TinyLoggerを継承し日付形式をISOにしたTranscriptLoggerのインスタンスを生成するクラス。

想定する使用法:
グローバルなloggerを使わず一時的なログを記録するためメソッド内でloggerインスタンスを生成して使用する。

```
| logger |
logger := M946Logger new.

1 to: 10 do: [ :n |
	logger record: n asString.]
```


"
Class {
	#name : #M946Logger,
	#superclass : #TinyLogger,
	#instVars : [
		'logLevel'
	],
	#category : #'M946-Commons-Logger'
}

{ #category : #'instance creation' }
M946Logger class >> new [

	| logger |
	logger := super new addTranscriptLogger .

	logger timestampFormatBlock: [ :aStream :timestamp |
		timestamp asDate yyyymmdd printOn: aStream.
		aStream << ' '.
		timestamp asTime print24: true on: aStream ].
	
	logger logLevel: LogLevel info.
	
	^ logger 
]

{ #category : #'instance creation' }
M946Logger class >> new: aLogLevel [

	| logger |
	logger := self new.
	logger logLevel: aLogLevel.
	
	^logger
	
	
]

{ #category : #logging }
M946Logger >> clearLog [

	Transcript clear
	

]

{ #category : #printing }
M946Logger >> cr [

	Transcript cr
]

{ #category : #private }
M946Logger >> debug: anObject [
	(logLevel = LogLevel debug ) ifTrue:[self record: anObject]
]

{ #category : #'accessing - structure variables' }
M946Logger >> info: anObject [

	self record: anObject 
]

{ #category : #accessing }
M946Logger >> logLevel [

	^logLevel 
]

{ #category : #accessing }
M946Logger >> logLevel: aLogLevel [

	logLevel := aLogLevel
]

{ #category : #'public API' }
M946Logger >> record: anObject [	

	super record: anObject asString
]

{ #category : #printing }
M946Logger >> space [

	Transcript space
]

{ #category : #printing }
M946Logger >> tab [

	Transcript tab.
	^self
]
