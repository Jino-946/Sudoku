"
行見方式を用い数独問題を解決する。(GyomeWayはLetsmeWayの90°回転バージョン)

LetsmeWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方②」の実装です。

"
Class {
	#name : #GyomeWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #logic }
GyomeWay >> gyome: block [
	"
	verifyNumberが含まれているブロックを処理の対象としている。
	ブロックのセルが含まれるSudokuColumnを検査し、verifyNumberを
	置くことが出来る時はSudokuBoardにマップする。	
	"

	| column row cell |
	1 to: 3 do: [ :ri |
		row := block rowsOnBoard at: ri. "<- aSudokuRow"
		(row includes: block verifyNumber) ifFalse: [ 
			"verifyNumberが含まれるブロックを検証の対象としているので
			ブロック内の列についてはブランクセルを全てマークすることができる"
			1 to: 3 do: [ :i |
				(row at: (block colIndexOnBoard: i)) = 0 ifTrue: [
					row at: (block colIndexOnBoard: i) put: $X ] ].

			"ブロック内の列もスキャンしているがブロック内はマーク済みのため影響はない"
			1 to: 9 do: [ :i |
				column := sudokuBoard atColumn: i. "<- anArray(SmallInteger)"
				(column includes: block verifyNumber) ifTrue: [
					(row at: i) = 0 ifTrue: [ row at: i put: $X ] ] ].

			cell := row tenpai.
			cell class = SudokuCell ifTrue: [
				cell element: block verifyNumber.
				self tsumo: cell ] ] ]
]

{ #category : #logic }
GyomeWay >> solve [
	"
	行見方式(LetsmeWayの90°回転バージョン)

	ブロックのセルが含まれるボード行(rowsOnBoard)に注目する。
    ボード行のブランクセルで重複のため検証数字を配置できないセルは$Xでマークする。
	配列のブランクセルが一つになったなら配備される数字は自動的に決定する。	
	"

	| block cell |
	cell := 0.
	block := 0.
	1 to: 9 do: [ :n |
		1 to: 9 do: [ :vNum |
			block := sudokuBoard getBlock: n verifyNumber: vNum.
			block includesVerifyNumber ifTrue: [ self gyome: block ] ].
		
		block := sudokuBoard getBlock: n verifyNumber: 0.	
		cell := block allGreen.
		cell class = SudokuCell ifTrue: [ sudokuBoard map: cell ] ]
]
