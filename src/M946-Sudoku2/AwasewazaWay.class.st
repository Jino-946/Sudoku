"
合わせ技で数独問題を解決する。

AwaseWazaWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方」を組み合わせて数独問題を解きます。


"
Class {
	#name : #AwasewazaWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'sudoku - solution' }
AwasewazaWay >> solve: task [

	| blockenWay masumiWay letsmeWay gyomeWay |
	sudokuBoard := SudokuBoard2 new.
	sudokuBoard loadFromString: task.

	5 timesRepeat: [
		blockenWay := BlockenWay new: sudokuBoard.
		blockenWay solve.

		masumiWay := MasumiWay new: sudokuBoard.
		masumiWay solve.

		letsmeWay := LetsmeWay new: sudokuBoard.
		letsmeWay solve.

		gyomeWay := GyomeWay new: sudokuBoard.
		gyomeWay solve 

		].

	^ sudokuBoard completed
	
" 

wazaWay := AwasewazaWay new.
tasks :=  wazaWay intermediateEx  .
completed := 0.
uncompleted := OrderedCollection new.
tasks doWithIndex:  [ :task :i| 
	(wazaWay solve: task) 
	ifTrue: [ completed := completed + 1]
	ifFalse: [ uncompleted add: i ].
].

Transcript show: 'i solved '; show: completed ; show: ' out of '; show: tasks size ; show: ' tasks.';cr.
(completed = tasks size ) ifFalse: [  
	Transcript show: 'uncompleted tasks: '; show: uncompleted.
]

"
]
