"
ニコリのサイトで紹介されている[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)を実装する基底クラス


Instance Variables
- sudokuBoard          <SudokuBoard> パズルを解く対象の数独ボード
- relatedVertBlocks    <Dictionary> 垂直方向で関連するブロック [1-4-7][2-5-8][3-6-9]
                                    ブロック番号をキーとし他の2のブロック番号の配列を値とするDictionary
- relatedHorBlocks     <Dictionary> 水平方向で関連するブロック [1-2-3][4-5-6][7-8-9]
                                    ブロック番号をキーとし他の2のブロック番号の配列を値とするDictionary

"
Class {
	#name : #NikoliWay,
	#superclass : #Object,
	#instVars : [
		'sudokuBoard',
		'relatedVertBlocks',
		'relatedHorBlocks'
	],
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #'instance creation' }
NikoliWay class >> new: sudokuBoard [

	| way |
	way := self new.
	way sudokuBoard: sudokuBoard .
	^ way
]

{ #category : #exercises }
NikoliWay >> beginnersEx [

	^ #(
'
906  824  350
012  030  006
503  960  287

291  300  760
000  049  803
380  000  000

100  490  000
620  100  005
058  000  009
'

'
026  350  800
700  060  100
849  007  603

060  005  300
000  291  507
517  830  092

601  004  038
070  003  940
300  982  010
'

'
081  570  060
400  800  010
060  020  003

009  000  305
050  200  089
040  007  000

007  080  051
000  000  000
893  140  002
'

'
004  032  000
007  010  904
200  005  000

410  306  078
000  000  000
830  400  090

500  070  682
091  020  407
008  504  030
'

'
0 0 7  0 3 2  8 0 0
8 3 0  0 6 0  0 1 5
5 0 0  0 4 0  0 7 0

0 0 9  0 1 6  0 0 0
2 6 0  0 0 4  3 9 1
0 4 3  0 5 9  7 8 6

4 0 0  8 0 1  9 3 7
0 0 1  6 7 0  0 0 8
0 0 8  0 0 0  0 6 2
'

'
0 4 0  0 0 6  2 3 7
3 0 2  0 9 0  0 0 1
1 0 0  3 2 0  4 8 0

7 0 1  6 0 0  9 4 0
5 0 3  0 0 9  0 2 8
4 2 0  8 7 3  1 5 0

6 9 0  2 0 5  0 1 4
0 0 5  7 3 4  6 0 0
0 3 0  0 0 0  0 0 5
'


'
8 0 0  0 0 1  0 0 2
0 1 4  0 5 7  0 0 6
0 0 0  0 0 0  0 0 4

0 3 0  5 0 0  0 1 0
7 5 8  0 0 0  0 0 0
0 0 0  0 7 0  9 6 5

2 4 0  6 0 0  0 0 0
9 0 3  7 0 0  0 2 0
0 0 5  0 9 2  4 0 0
'

'
3 0 6  0 0 7  0 0 2
0 0 4  0 0 5  0 8 0
0 8 0  6 0 0  7 0 0

0 0 9  0 5 4  0 1 0
1 0 0  0 0 0  3 5 0
0 6 0  0 8 0  2 0 9

0 0 0  0 0 0  0 0 8
0 1 0  0 6 2  0 4 0
5 0 2  7 9 8  0 0 3
'
)
]

{ #category : #'private - helpers' }
NikoliWay >> blankCell [ 

	^0
]

{ #category : #initialization }
NikoliWay >> initialize [

	relatedVertBlocks := Dictionary new.
	relatedVertBlocks
		at: 1 put: #( 4 7 );
		at: 4 put: #( 1 7 );
		at: 7 put: #( 1 4 );
		at: 2 put: #( 5 8 );
		at: 5 put: #( 2 8 );
		at: 8 put: #( 2 5 );
		at: 3 put: #( 6 9 );
		at: 6 put: #( 3 9 );
		at: 9 put: #( 3 6 ).

	relatedHorBlocks := Dictionary new.
	relatedHorBlocks
		at: 1 put: #( 2 3 );
		at: 2 put: #( 1 3 );
		at: 3 put: #( 1 2 );
		at: 4 put: #( 5 6 );
		at: 5 put: #( 4 6 );
		at: 6 put: #( 4 5 );
		at: 7 put: #( 8 9 );
		at: 8 put: #( 7 9 );
		at: 9 put: #( 7 8 )
]

{ #category : #exercises }
NikoliWay >> intermediateEx [

	^ #(
'
000 050 000
000 702 130
506 004 000

008 000 010
349 000 070
700 006 020

000 080 200
802 000 400
000 300 050
'

'
090 013 020
700 200 006
300 900 007

650 000 000
003 000 010
080 590 000

000 057 003
000 000 000
000 360 904
'

'
060 030 005
000 100 700
450 000 000

502 000 000
800 603 029
007 090 000

000 006 000
006 400 030
000 700 490
'

'
300 000 208
800 069 000
400 050 000

000 700 050
000 008 600
050 002 400

000 910 020
080 006 007
003 000 000
'

'
030 000 489
108 004 070
000 060 000

000 000 000
000 030 001
726 000 030

000 702 100
490 000 000
000 005 200
'

'
607 000 040
000 001 000
000 000 705

073 400 009
060 020 010
900 008 004

500 000 000
000 396 000
034 700 000
'

'
040 000 080
001 005 000
000 043 600

000 270 003
006 000 009
700 004 000

005 008 006
000 030 070
810 009 304
'

'
000 100 600
200 090 001
050 800 030

017 000 000
005 400 908
000 060 000

700 012 800
800 900 300
030 004 000
'
'
900 050 008
800 007 300
205 004 000

000 000 049
000 001 000
006 400 002

090 000 060
004 000 027
500 290 000
'

'
000 007 608
200 500 000
075 004 000

020 083 004
906 000 000
000 050 092

000 000 030
040 172 000
009 000 040
'

'
020 096 050
000 000 000
763 040 009

200 000 000
800 700 200
009 000 307

100 000 004
000 008 000
000 135 006
'

'
009 307 001
106 000 900
030 000 500

023 460 090
000 000 040
000 000 708

080 050 000
200 001 800
495 000 000
'

'
070 590 008
060 070 005
008 000 070

030 400 097
500 000 300
001 003 050

000 020 000
090 000 204
200 007 001
'

'
000 200 060
000 300 009
016 000 700

000 041 000
007 000 910
900 080 050

002 000 004
730 004 500
400 000 008
'
)
]

{ #category : #accessing }
NikoliWay >> sudokuBoard [

	^sudokuBoard 
]

{ #category : #accessing }
NikoliWay >> sudokuBoard: aBoard [

	sudokuBoard := aBoard 
]

{ #category : #creation }
NikoliWay >> sudokuColumnAt: colIndex [

	^ SudokuColumn new: colIndex column: (sudokuBoard atColumn: colIndex) 
	
]

{ #category : #accessing }
NikoliWay >> sudokuRowAt: rowIndex [

	^SudokuRow new: rowIndex row: (sudokuBoard atRow: rowIndex)
]

{ #category : #accessing }
NikoliWay >> tsumo: cell [

	cell class = SudokuCell 
	ifTrue: [ sudokuBoard map: cell ]
]
