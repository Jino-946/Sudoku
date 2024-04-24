"
数独ボード(SudokuBoard2)の水平に並ぶ3つのブロックをグループとして表現するクラス

[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方④]」の実装に利用します。

	Instance Variables.
	groupNumber		<SmallInteger>		グループ番号
	rowsOnBoard		<Array>				ブロックの行インデックスに対応するボード上の行(SudokuRow)の配列
	verifyNumber	<SmallInteger>		検証数値
				
"
Class {
	#name : #HorBlockGroup,
	#superclass : #Object,
	#instVars : [
		'groupNumber',
		'rowsOnBoard'
	],
	#category : #'M946-Sudoku2-Core'
}
