"
SudokuBoardに配置された1から9までの数字を数字毎に数えた値を保持する。


    Instance Variables
	numberCount:		<Dictionary>



hash method の実装は[Overriding Equality and Hash in Pharo](https://growi.cloud/blog/3044)を参照した。

"
Class {
	#name : #NumberCounter,
	#superclass : #Object,
	#instVars : [
		'numberCount'
	],
	#category : #'M946-Sudoku-Core'
}

{ #category : #comparing }
NumberCounter >> = aNumberCounter [

	^aNumberCounter class == self class
		and: [ aNumberCounter numberCount = self numberCount ]
		
]

{ #category : #accessing }
NumberCounter >> at: anInteger [

	^ numberCount at: anInteger
]

{ #category : #accessing }
NumberCounter >> at: anInteger put: count [

	numberCount at: anInteger put: count
]

{ #category : #utilities }
NumberCounter >> boardOf: board [
	"
	board上の1から9までの数字を数字毎にカウントしnumberCount<Dictionary>に保持する
	"

	numberCount :=  Dictionary new.
	1 to: 9 do: [ :n | numberCount at: n put: 0 ].

	board asArray do: [ :num |
		num class = SmallInteger
		ifTrue: [  
			num = 0
			ifFalse: [self incrementAt: num ]
		]
	]
]

{ #category : #comparing }
NumberCounter >> hash [ 

	^ numberCount hash
]

{ #category : #logic }
NumberCounter >> incompleteNumbers [
	
	^numberCount select:[ :each | each value < 9 ].
]

{ #category : #accessing }
NumberCounter >> incrementAt: number [
	"
	引数number で与えられた数字の個数をインクリメントする
	"
	| count |
	count := ( numberCount at: number) + 1 .
	numberCount at: number put: count
	
]

{ #category : #initialization }
NumberCounter >> initialize [ 

	super initialize .
	numberCount := Dictionary new.
	1 to: 9 do: [ :n | numberCount at: n put: 0 ]
	
]

{ #category : #accessing }
NumberCounter >> numberCount [

	^numberCount 


]
