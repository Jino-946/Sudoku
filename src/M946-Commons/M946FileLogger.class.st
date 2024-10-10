"
TinyLoggerを継承し日付形式をISOにしたFileLoggerのインスタンスを生成するクラス。

想定する使用法:
LogLevelは実行するスクリプトの先頭でM946FileLoggerのクラス変数として指定する。
```smalltalk
|logger|
M946FileLogger logLevel: LogLevel debug.
logger := M946FileLogger new.
logger clearLog .
...
```

ログにはグローバルなloggerを使わずメソッド内でloggerインスタンスを生成して使用する。
``` smalltalk
SomeClass>>someMethod
| logger |
logger := M946FileLogger new: thisContext.

logger debug: someObject.
```

主なメソッド
- info:   LogLevelがoff以外の時、ログを出力する。
- debug:  LogLevelがdebug,traceの時、ログを出力する。
- trace:  LogLevelがtraceの時、ログを出力する。
- record: LogLevelに拘わらずログを出力する。

"
Class {
	#name : 'M946FileLogger',
	#superclass : 'TinyLogger',
	#instVars : [
		'context'
	],
	#classVars : [
		'LOGLevel'
	],
	#category : 'M946-Commons-Logger',
	#package : 'M946-Commons',
	#tag : 'Logger'
}

{ #category : 'class initialization' }
M946FileLogger class >> initialize [ 

	LOGLevel := LogLevel info.
	
]

{ #category : 'accessing' }
M946FileLogger class >> logLevel [

	^LOGLevel 
]

{ #category : 'logging' }
M946FileLogger class >> logLevel: level [

	LOGLevel := level.
]

{ #category : 'instance creation' }
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

{ #category : 'instance creation' }
M946FileLogger class >> new [

	| logger |
	logger := self named: 'log/default.log'.
	^logger
]

{ #category : 'instance creation' }
M946FileLogger class >> new: context [

	| logger |
	logger := self named: 'log/default.log'.
	logger context: context asString.
	logger debug: 'Hello!!' .
	^logger
]

{ #category : 'accessing' }
M946FileLogger >> context [

	^context 
]

{ #category : 'accessing' }
M946FileLogger >> context: aContext [

	context := aContext
]

{ #category : 'logging' }
M946FileLogger >> debug: anObject [

	(self logLevel = LogLevel debug or: [ self logLevel = LogLevel trace ])
		ifTrue: [ self record: ('{1} 
debug: {2}

' format: {context . anObject})]
]

{ #category : 'logging' }
M946FileLogger >> debug: anObject message: message [

	(self logLevel = LogLevel debug or: [ self logLevel = LogLevel trace ])
		ifTrue: [ self record: ('{1}  debug: {2} {3}{4}' format: 
			  {context . message . anObject . Character cr})]
]

{ #category : 'logging' }
M946FileLogger >> debug: anObject messageWithCR: message [

	(self logLevel = LogLevel debug or: [ self logLevel = LogLevel trace ])
		ifTrue: [ self record: ('{1}  debug: {2} {3}{4} {5}' format: 
			  {context . message . Character cr. anObject . Character cr})]
]

{ #category : 'logging' }
M946FileLogger >> info: anObject [

	self logLevel ~= LogLevel off ifTrue: [ self record: ('info: {1}' format: {anObject})]
]

{ #category : 'logging' }
M946FileLogger >> info: anObject message: message [

	self logLevel ~= LogLevel off 
		ifTrue: [ self record: ('{1}  info: {2} {3}{4}' format: 
			  {context . message . anObject . Character cr})]
]

{ #category : 'logging' }
M946FileLogger >> info: anObject messageWithCR: message [

	self logLevel ~= LogLevel off
		ifTrue: [ self record: ('{1}  info: {2} {3}{4} {5}' format: 
			  {context . message . Character cr. anObject . Character cr})]
]

{ #category : 'accessing' }
M946FileLogger >> logLevel [
.
	^self class  logLevel
]

{ #category : 'logging' }
M946FileLogger >> trace: anObject [

	(self logLevel = LogLevel trace )
		ifTrue: [ self record: ('{1} 
trace: {2}

' format: {context . anObject})]
]

{ #category : 'logging' }
M946FileLogger >> trace: anObject message: message [

	(self logLevel = LogLevel trace )
		ifTrue: [ self record: ('{1}  trace: {2} {3}{4}' format: 
			  {context . message . anObject . Character cr})]
]

{ #category : 'logging' }
M946FileLogger >> trace: anObject messageWithCR: message [

	(self logLevel = LogLevel trace)
		ifTrue: [ self record: ('{1}  trace: {2} {3}{4} {5}' format: 
			  {context . message . Character cr. anObject . Character cr})]
]
