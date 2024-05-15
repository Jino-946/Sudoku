"
『いずれにしても理論』を用い数独問題を解決する。

AnyWayは[数独のルールと解き方](https://www.nikoli.co.jp/ja/wp-content/uploads/2023/02/sd41_rule.pdf)で紹介されている「考え方④」の実装です。

"
Class {
	#name : #AnyWay,
	#superclass : #NikoliWay,
	#category : #'M946-Sudoku2-Solution'
}

{ #category : #logic }
AnyWay >> _markRow: sudokuRow [
	"
	sudokuRowのブランクセルに$Xをセットする
	"
	sudokuRow row doWithIndex: [ :item :i |
		(item = self blankCell) ifTrue: [ sudokuRow row at: i put: $X ]
	].
	sudokuBoard map: sudokuRow 
]

{ #category : #logic }
AnyWay >> allGreen: block group: group [
	"
	 引数blockに関連したブロックがallGreenの時にallGreen処理を行う
	"
	| otherBlock cell |
	(relatedHorBlocks at: block blockNumber) do: [ :i |
		otherBlock := group atBlock: i.
		cell := otherBlock allGreen.
		cell class = SudokuCell 
		ifTrue: [ sudokuBoard map: cell ]
 	]
	
	
]

{ #category : #logic }
AnyWay >> horGroupWay: horGroup [

	| reloadGroup groupNumber verifyNumber |
	
	groupNumber := horGroup groupNumber.
	verifyNumber :=  horGroup verifyNumber.
	1 to: 3 do: [ :i | 
		self markRow: horGroup blockNumber: i  .
		
		reloadGroup := sudokuBoard atHorGroup: groupNumber verifyNumber: verifyNumber.
		self markEishanteng: reloadGroup blockNumber: i.

		reloadGroup := sudokuBoard atHorGroup: groupNumber verifyNumber: verifyNumber.
		self setVerifyNumberToColumn: reloadGroup .

		reloadGroup := sudokuBoard atHorGroup: horGroup groupNumber verifyNumber: horGroup verifyNumber.	
		self processColumnTenpai: horGroup.
	
	
	]

]

{ #category : #logic }
AnyWay >> markEishanteng: group [
	"
	 引数blockに関連したブロックが「一向聴」の時の処理を行う
	
	 SudokuBoard のセルに sudokuCell の element を配置する
	"

	| block cells |
	1 to: 3 do: [ :i |
		block := group atBlock: i.
		block verifyNumber: group verifyNumber.

		cells := block eishanteng.
		cells class = Array ifTrue: [
			1 to: 3 do: [ :j |
				| sudokuRow |
				sudokuRow := group atSudokuRow: j.
				cells do: [ :cell |
					sudokuRow rowIndex = cell rowIndex ifTrue: [
						sudokuRow at: cell colIndex put: cell element.] ].
				sudokuBoard map: sudokuRow  ] ] ]
]

{ #category : #logic }
AnyWay >> markEishanteng: group blockNumber: number [
	"
	 引数blockに関連したブロックが「一向聴」の時の処理を行う
	
	 SudokuBoard のセルに sudokuCell の element を配置する
	"

	| block cells |
	block := group atBlock: number.
	block verifyNumber: group verifyNumber.

	cells := block eishanteng.
	cells class = Array ifTrue: [
		1 to: 3 do: [ :j |
			| sudokuRow |
			sudokuRow := group atSudokuRow: j.
			cells do: [ :cell |
				sudokuRow rowIndex = cell rowIndex ifTrue: [
					sudokuRow at: cell colIndex put: cell element ] ].
			sudokuBoard map: sudokuRow ] ]
]

{ #category : #logic }
AnyWay >> markRow: horGroup [


	1 to: 3 do: [ :i |	| block index row |
		block := horGroup atBlock: i.
		block includesVerifyNumber ifTrue: [ 
			index := block rowIndexOf: horGroup verifyNumber.
			row := horGroup atSudokuRow: index.
			self _markRow: row.
		].
	].
]

{ #category : #logic }
AnyWay >> markRow: horGroup blockNumber: number [

	| block index row |
	block := horGroup atBlock: number.
	block includesVerifyNumber ifFalse: [ ^ self ].
	index := block rowIndexOf: horGroup verifyNumber.
	row := horGroup atSudokuRow: index.
	self _markRow: row
]

{ #category : #logic }
AnyWay >> processColumnTenpai: group [
	"
	列がテンパイしているときはSudokuBoard2に検証値をマップする
	"
	group verifyNumber = 0 ifTrue: [ self error: 'verifyNumber must not be 0.' ].
	1 to: 9 do: [ :i | | sudokuColumn cell |
		sudokuColumn :=  group atSudokuColumn: i.
		
		cell := sudokuColumn allGreen.
		cell class = SudokuCell
		ifTrue: [ 
			sudokuBoard map: cell.
			^self.
		].
		
		cell := sudokuColumn tenpai .
		cell class = SudokuCell 
		ifTrue: [  
			cell element: group verifyNumber.
			sudokuBoard map: cell.
		]		
	] 
	
]

{ #category : #initialization }
AnyWay >> setVerifyNumberToColumn: horGroup [

	1 to: 3 do: [ :i | | sudokuRow eitherCells |
		sudokuRow := horGroup atSudokuRow: i.
		eitherCells := sudokuRow eitherCell .
		(eitherCells class = OrderedCollection and: [ eitherCells size = 2 ])
			ifTrue: [  | cell |
				cell := eitherCells at: 1.
				1 to: 9 do: [ :j | (sudokuRow at: j) = 0 ifTrue:[ sudokuRow at: j put: $X]].

				sudokuBoard map: sudokuRow .
		 ]].

]

{ #category : #logic }
AnyWay >> solve [

	| horGroup |
	1 to: 3 do: [ :groupNum |
		1 to: 9 do: [ :vNum |
			horGroup := sudokuBoard atHorGroup: groupNum.
			horGroup verifyNumber: vNum.
			self horGroupWay: horGroup.
			sudokuBoard clearMarks ] ]
]

{ #category : #logic }
AnyWay >> vertGroupWay: group [


]
