"
""This class represents a Game""
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'ships',
		'dices',
		'finished',
		'winner',
		'laps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> fuel: someShips with: aFuelQuantity [

	someShips do: [ :aShip | aShip fuel: aFuelQuantity ]
]

{ #category : 'validation' }
Game class >> hasDices: someDices [

	someDices size < 1 ifTrue: [
		Error signal: 'The Game needs at least one dice to start.' ]
]

{ #category : 'validation' }
Game class >> hasLaps: someLaps [

	someLaps < 1 ifTrue: [
		Error signal: 'The Game needs at least one lap to start.' ]
]

{ #category : 'validation' }
Game class >> hasShips: someShips [

	someShips size < 2 ifTrue: [
		Error signal: 'The Game needs at least two ship to start.' ]
]

{ #category : 'creation' }
Game class >> maximumRoll: someDices [

	| rolledNumber |
	rolledNumber := someDices sum: [ :aDice | aDice rollMaximum ].
	^ rolledNumber
]

{ #category : 'validation' }
Game class >> validateSquaresFrom: aBoard and: someDices [

	aBoard validateSquaresWith: (self maximumRoll: someDices)
]

{ #category : 'creation' }
Game class >> with: aBoard for: someLaps and: someShips and: someDices [

	self hasDices: someDices.
	self hasShips: someShips.
	self hasLaps: someLaps.
	self fuel: someShips with: (self maximumRoll: someDices) * 2. 
	self validateSquaresFrom: aBoard and: someDices.
	^ self new initializeWith: aBoard for: someLaps and: someShips and: someDices
]

{ #category : 'action' }
Game >> applyEffect: aShip and: aPosition [

	| effect |
	effect := board effectIn: aPosition currentSquare + 1.

	^ effect applyOn: aShip and: aPosition in: self
]

{ #category : 'validation' }
Game >> boardLength [

	^ board length
]

{ #category : 'validation' }
Game >> canStillPlay [

	finished ifTrue: [ Error signal: 'The game has finished.' ]
]

{ #category : 'changing state' }
Game >> finish [

	finished := true
]

{ #category : 'testing' }
Game >> hasFinished [

	^ finished
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard for: someLaps and: someShips and: someDices [

	board := aBoard.
	ships := someShips.
	dices := someDices.
	laps := someLaps.
	finished := false.
	winner := NullShip new.
]

{ #category : 'action' }
Game >> move: aShip with: rolledNumber [

	| shipInitialPosition  squaresTraveled shipPositionBeforeWormHole shipPositionAfterWormHole shipPositionAfterSquareEffect squaresTraveledWithDice squaresTraveledWithSquareEffect |
	shipInitialPosition := aShip currentPosition.

	shipPositionBeforeWormHole := board
		                              update: shipInitialPosition
		                              with: rolledNumber.

	squaresTraveledWithDice := shipInitialPosition
		                           squaresAwayFrom:
		                           shipPositionBeforeWormHole
		                           with: board length.

	shipPositionAfterWormHole := board moveIfWormHoleAt:
		                             shipPositionBeforeWormHole.

	shipPositionAfterSquareEffect := self
		                         applyEffect: aShip
		                         and: shipPositionAfterWormHole.

	squaresTraveledWithSquareEffect := shipPositionAfterWormHole
		                                   squaresAwayFrom:
		                                   shipPositionAfterSquareEffect
		                                   with: board length.

	squaresTraveled := squaresTraveledWithDice
	                   + squaresTraveledWithSquareEffect.

	aShip moveTo: shipPositionAfterSquareEffect.
	[ aShip consumeFuel: squaresTraveled ]
		on: Error
		do: [
			aShip moveTo: shipInitialPosition.
			aShip losesTwoTurns.
			aShip fuel: (self class maximumRoll: dices) * 2 ].

	(shipPositionAfterSquareEffect hasCompleted: laps) ifTrue: [ self finish ]
]

{ #category : 'action' }
Game >> moveShipsBackwards: aMagnitude [

	| shipInitialPosition shipNewPosition squaresTraveled |
	ships do: [ :aShip |
		shipInitialPosition := aShip currentPosition.
		shipNewPosition := aShip currentPosition
			                   add: aMagnitude negated
			                   with: board length.
		squaresTraveled := shipInitialPosition
			                   squaresAwayFrom: shipNewPosition
			                   with: board length.
		aShip moveTo: shipNewPosition .
		[ aShip consumeFuel: squaresTraveled ]
			on: Error
			do: [
				aShip moveTo: shipInitialPosition.
				aShip losesTwoTurns.
				aShip fuel: (self class maximumRoll: dices) * 2 ] ]
]

{ #category : 'action' }
Game >> moveShipsToSquareCero [
	
	ships do: [ :aShip | aShip moveTo: (aShip currentPosition adjustSquare: 0) ]
]

{ #category : 'action' }
Game >> nextTurnPass [

	| shipToMove |
	self canStillPlay.
	shipToMove := ships removeFirst.
	shipToMove fuel: (self class maximumRoll: dices) * 2.
	ships add: shipToMove.
]

{ #category : 'action' }
Game >> nextTurnPlay [

	| shipToMove rolledNumber |
	self canStillPlay.
	shipToMove := ships removeFirst.
	rolledNumber := self rollDices.
	(shipToMove canPlay: rolledNumber) ifTrue: [ self move: shipToMove with: rolledNumber ].
	ships add: shipToMove.
	finished ifTrue: [ winner := shipToMove ]
]

{ #category : 'printing' }
Game >> printBoard [

	| positions results winnerShip sortedPositions |
	winnerShip := 'Winner: ' , winner name , String cr.
	sortedPositions := ships sorted: [ :aShip |
		                   aShip currentPosition
			                   squaresAwayFrom: (Position at: 0 in: 1)
			                   with: board length ] descending.
	positions := String cr join: (sortedPositions collect: [ :aShip | aShip details ]).
		            
	results := winnerShip , positions.
	^ results
]

{ #category : 'action' }
Game >> rollDices [

	| rolledNumber |
	rolledNumber := dices sum: [ :aDice | aDice roll ].

	^ rolledNumber
]
