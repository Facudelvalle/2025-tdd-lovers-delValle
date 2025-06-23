"
This game represent a game builder
"
Class {
	#name : 'GameBuilder',
	#superclass : 'Object',
	#instVars : [
		'board',
		'laps',
		'ships',
		'dices',
		'rewardsManager',
		'fuelQuantity'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'building' }
GameBuilder >> build [

	self validateBoard.

	^ Game
		  with: board
		  for: laps
		  and: ships
		  and: dices
		  and: fuelQuantity
		  and: rewardsManager
]

{ #category : 'initialization' }
GameBuilder >> initialize [

	laps := 1.
	board := OrderedCollection new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	
]

{ #category : 'initialization' }
GameBuilder >> setBoard: aBoard [

	board := aBoard
]

{ #category : 'initialization' }
GameBuilder >> setDices: someDices [

	dices := someDices.

	fuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2
]

{ #category : 'initialization' }
GameBuilder >> setLaps: someLaps [

	laps := someLaps
]

{ #category : 'initialization' }
GameBuilder >> setRewards: aRewardsManager [

	rewardsManager := aRewardsManager
]

{ #category : 'initialization' }
GameBuilder >> setShips: someShips [

	ships := someShips
]

{ #category : 'building' }
GameBuilder >> validateBoard [

	board isEmpty ifTrue: [
		Error signal: 'The game must have a board to be created.' ]
]
