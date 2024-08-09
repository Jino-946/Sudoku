"
TinyLoggerを継承し日付形式をISOにしたFileLoggerのインスタンスを生成するクラス。

想定する使用法:
グローバルなloggerを使わず一時的なログを記録するためメソッド内でloggerインスタンスを生成して使用する。

``` smalltalk
| logger |
logger := M946FileLoggerNamed new: 'pathToLogfile' logLevel: LogLebel debug.
logger debug: thisContext.

1 to: 10 do: [ :n |
	logger debug: n asString.]
```

主なメソッド
- debug:  LogLevelがdebugの時,ログを出力する。
- info:   LogLevelがinfoの時,ログを出力する。
- record: LogLevelに拘わらずログを出力する。

"
Class {
	#name : #M946FileLogger,
	#superclass : #TinyLogger,
	#instVars : [
		'context'
	],
	#classVars : [
		'logLevel'
	],
	#category : #'M946-Commons-Logger'
}

{ #category : #'class initialization' }
M946FileLogger class >> initialize [ 

	logLevel := LogLevel info.
	
]

{ #category : #accessing }
M946FileLogger class >> logLevel [

	^logLevel 
]

{ #category : #logging }
M946FileLogger class >> logLevel: level [

	logLevel := level.
]

{ #category : #'instance creation' }
M946FileLogger class >> named: pathToLogFile [

	| logger |
	logger := super new.
	logger ensureFileLoggerNamed: pathToLogFile  .

	 logger timestampFormatBlock: [ :aStream :timestamp |
		timestamp asDate yyyymmdd printOn: aStream.
		aStream << ' '.
		timestamp asTime print24: true on: aStream ].
	
	logger context: ''.
	^ logger 
]

{ #category : #'instance creation' }
M946FileLogger class >> new [

	| logger |
	logger := self named: 'log/default.log'.
	^logger
]

{ #category : #'instance creation' }
M946FileLogger class >> new: context [

	| logger |
	logger := self named: 'log/default.log'.
	logger context: context asString.
	^logger
]

{ #category : #accessing }
M946FileLogger >> context [

	^context 
]

{ #category : #accessing }
M946FileLogger >> context: aContext [

	context := aContext
]

{ #category : #private }
M946FileLogger >> debug: anObject [

	(self logLevel = LogLevel debug or: [ self logLevel = LogLevel trace ])
		ifTrue: [ self record: ('{1} 
debug: {2}

' format: {context . anObject})]
]

{ #category : #'accessing - structure variables' }
M946FileLogger >> info: anObject [

	self logLevel ~= LogLevel off ifTrue: [ self record: ('info: {1}' format: {anObject})]
]

{ #category : #accessing }
M946FileLogger >> logLevel [

	^self class  logLevel
]

{ #category : #tracing }
M946FileLogger >> trace: anObject [

	self logLevel = LogLevel trace ifTrue: [ self record: ('trace: {1}' format: {anObject})]
]
