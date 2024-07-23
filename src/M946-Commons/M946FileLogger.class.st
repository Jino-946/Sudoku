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
		'logLevel'
	],
	#category : #'M946-Commons-Logger'
}

{ #category : #'instance creation' }
M946FileLogger class >> named: pathToLogFile [

	| logger |
	logger := super new.
	logger ensureFileLoggerNamed: pathToLogFile  .

	 logger timestampFormatBlock: [ :aStream :timestamp |
		timestamp asDate yyyymmdd printOn: aStream.
		aStream << ' '.
		timestamp asTime print24: true on: aStream ].
	
	logger logLevel: LogLevel debug.
	
	^ logger 
]

{ #category : #'instance creation' }
M946FileLogger class >> named: pathToLogFile logLevel: level [

	| logger |
	logger := self named: pathToLogFile .
	logger logLevel: level.
	^logger
]

{ #category : #'instance creation' }
M946FileLogger class >> new [

	| logger |
	logger := self named: 'log/default.log'.
	^logger
]

{ #category : #'instance creation' }
M946FileLogger class >> new: aLogLevel [

	| logger |
	logger := self new.
	logger logLevel: aLogLevel.
	
	^logger
]

{ #category : #private }
M946FileLogger >> debug: anObject [

	logLevel = LogLevel debug ifTrue: [ self record: ('debug: {1}' format: {anObject})]
]

{ #category : #'accessing - structure variables' }
M946FileLogger >> info: anObject [

	logLevel = LogLevel info ifTrue: [ self record: ('info: {1}' format: {anObject})]
]

{ #category : #accessing }
M946FileLogger >> logLevel [

	^logLevel
]

{ #category : #logging }
M946FileLogger >> logLevel: aLogLevel [

	logLevel := aLogLevel 
]
