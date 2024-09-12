"
ニコリのサイトで紹介されている[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)を実装する基底クラス


Instance Variables
- relatedVertBlocks    <Dictionary> 垂直方向で関連するブロック [1-4-7][2-5-8][3-6-9]
                                    ブロック番号をキーとし他の2のブロック番号の配列を値とするDictionary
- relatedHorBlocks     <Dictionary> 水平方向で関連するブロック [1-2-3][4-5-6][7-8-9]
                                    ブロック番号をキーとし他の2のブロック番号の配列を値とするDictionary

"
Class {
	#name : #NikoliWay,
	#superclass : #SudokuSolver,
	#category : #'M946-Sudoku2-Solution'
}
