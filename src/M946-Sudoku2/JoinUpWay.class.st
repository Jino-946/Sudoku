"
合わせ技で数独問題を解決する。

JoinUpWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方」を組み合わせて数独問題を解きます。

Example
```
way := JoinUpWay new.
tasks :=  way intermediateEx.
completed := 0.
uncompleted := OrderedCollection new.
tasks doWithIndex:  [ :task :i| 
	(way solve: task) 
	ifTrue: [ completed := completed + 1]
	ifFalse: [ uncompleted add: i ].
].

Transcript cr; show: 'i solved  '; show: completed ; show: ' out of '; show: tasks size ; show: ' tasks.';cr.
(completed  = tasks size ) ifFalse: [  
	Transcript show: 'uncompleted tasks: '; show: uncompleted.
].

```

"
Class {
	#name : 'JoinUpWay',
	#superclass : 'NikoliWay',
	#category : 'M946-Sudoku2-Solution',
	#package : 'M946-Sudoku2',
	#tag : 'Solution'
}

{ #category : 'logic' }
JoinUpWay >> solve [
	|task  board logger timeToRun|
	M946FileLogger logLevel: LogLevel info.
	logger := M946FileLogger new.
	logger clearLog .
"
	task := '
0 3 0   0 4 0   0 2 1
5 0 0   0 0 0   0 0 9
0 0 0   8 2 3   0 0 0

0 0 3   9 0 7   8 0 0
4 0 8   0 0 0   6 0 5
0 0 9   4 0 5   1 0 0

0 0 0   2 7 1   0 0 0
9 0 0   0 0 0   0 0 7
2 1 0   0 9 0   0 3 0
'.
"
"2024/09/15 RF"
	task := '
0 4 0   0 2 0   0 1 0
5 1 0   0 0 0   0 7 6
0 0 0   5 0 8   0 0 0

0 0 4   9 0 0   7 0 0
3 0 0   0 4 0   0 0 2
0 0 2   0 0 3   5 0 0

0 0 0   6 0 1   0 0 0
1 3 0   0 0 0   0 5 4
0 6 0   0 5 0   0 8 0	
'.
	
	timeToRun := [
	board := self solve: task.
	logger info: board.
	board completed ifTrue: [  
		logger info: 'completed!!']] timeToRun .
	logger info: ('実行時間: {1}' format: { timeToRun }).

]

{ #category : 'sudoku - solution' }
JoinUpWay >> solve: taskOfString [

	"
	開発時の動作確認用のクラス
	"

	| blockenWay masumiWay letsmeWay gyomeWay eitherWay logger |
	logger := M946FileLogger new.
	sudokuBoard := SudokuBoard2 new.
	sudokuBoard loadFromString: taskOfString.
	logger info: sudokuBoard .
	 10 timesRepeat: [
		blockenWay := BlockenWay new: sudokuBoard.
		blockenWay solve.

		masumiWay := MasumiWay new: sudokuBoard.
		masumiWay solve.

		letsmeWay := LetsmeWay new: sudokuBoard.
		letsmeWay solve.

		gyomeWay := GyomeWay new: sudokuBoard.
		gyomeWay solve.
	
		eitherWay := EitherWay new: sudokuBoard .
		eitherWay solve].
	
		^sudokuBoard
"
	^ sudokuBoard completed.
"
	
" Example

way := JoinUpWay new.
tasks :=  way intermediateEx  .
completed := 0.
uncompleted := OrderedCollection new.
tasks doWithIndex:  [ :task :i| 
	(way solve: task) 
	ifTrue: [ completed := completed + 1]
	ifFalse: [ uncompleted add: i ].
].

Transcript show: 'i solved '; show: completed ; show: ' out of '; show: tasks size ; show: ' tasks.';cr.
(completed = tasks size ) ifFalse: [  
	Transcript show: 'uncompleted tasks: '; show: uncompleted.
]

"
]
