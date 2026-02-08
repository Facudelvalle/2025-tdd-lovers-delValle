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
		'fuelQuantity',
		'cardsManager'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'building' }
GameBuilder >> build [

	self validateBoard.
	self validateDices.
	self validateLaps.
	self validateShips.
	self validateSquares.

	^ Game
		  with: board
		  for: laps
		  and: ships
		  and: dices
		  and: fuelQuantity
		  and: rewardsManager
		  and: cardsManager
]

{ #category : 'initialization' }
GameBuilder >> initialize [

	laps := 1.
	board := OrderedCollection new.
	ships := OrderedCollection new.
	dices := OrderedCollection new.
	
]

{ #category : 'accessing' }
GameBuilder >> maximumRoll [

	^ dices sum: [ :aDice | aDice rollMaximum ]
]

{ #category : 'initialization' }
GameBuilder >> setAvailableCards: aCardManager [ 
	
	cardsManager := aCardManager 
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

{ #category : 'testing' }
GameBuilder >> validateDices [

	dices size < 1 ifTrue: [
		Error signal: 'The Game needs at least one dice to start.' ]
]

{ #category : 'testing' }
GameBuilder >> validateLaps [

	laps < 1 ifTrue: [
		Error signal: 'The Game needs at least one lap to start.' ]
]

{ #category : 'testing' }
GameBuilder >> validateShips [

	ships size < 2 ifTrue: [
		Error signal: 'The Game needs at least two ship to start.' ]
]

{ #category : 'accessing' }
GameBuilder >> validateSquares [

	board validateSquaresWith: self maximumRoll
]
