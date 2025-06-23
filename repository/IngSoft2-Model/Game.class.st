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
		'laps',
		'rewards'
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

{ #category : 'accessing' }
Game class >> maximumRoll: someDices [

	^ someDices sum: [ :aDice | aDice rollMaximum ]
]

{ #category : 'validation' }
Game class >> validateSquaresFrom: aBoard with: someDices [

	aBoard validateSquaresWith: (self maximumRoll: someDices)
]

{ #category : 'creation' }
Game class >> with: aBoard for: someLaps and: someShips and: someDices and: aFuelQuantity [

	self hasDices: someDices.
	self hasShips: someShips.
	self hasLaps: someLaps.
	self fuel: someShips with: aFuelQuantity.
	self validateSquaresFrom: aBoard with: someDices.
	^ self new
		  initializeWith: aBoard
		  for: someLaps
		  and: someShips
		  and: someDices
]

{ #category : 'creation' }
Game class >> with: aBoard for: someLaps and: someShips and: someDices and: aFuelQuantity and: aRewardBuilder [

	self hasDices: someDices.
	self hasShips: someShips.
	self hasLaps: someLaps.
	self fuel: someShips with: aFuelQuantity.
	self validateSquaresFrom: aBoard with: someDices.
	^ self new
		  initializeWith: aBoard
		  for: someLaps
		  and: someShips
		  and: someDices
		  and: aRewardBuilder
]

{ #category : 'action' }
Game >> applyEffectOn: aShip with: aPosition [

	^ board applyEfectOn: aShip with: aPosition in: self.
]

{ #category : 'action' }
Game >> applyRewardTo: aShip for: aRolledNumber [

	| aReward |
	aReward := rewards buildFor: 1.

	aRolledNumber = self maximumRoll ifTrue: [
		(aReward at: 1) applyTo: aShip ]
]

{ #category : 'action' }
Game >> calculateDistanceBetween: aPosition and: anotherPosition [

	^ board calculateDistanceBetween: aPosition and: anotherPosition
]

{ #category : 'validation' }
Game >> canStillPlay [

	finished ifTrue: [ Error signal: 'The game has finished.' ]
]

{ #category : 'changing state' }
Game >> finish [

	finished := true
]

{ #category : 'action' }
Game >> goBackFourSquares: aShip from: aPosition [ 
	
	^ board goBackFourSquares: aShip from: aPosition 
]

{ #category : 'testing' }
Game >> hasFinished [

	^ finished
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard for: someLaps and: someShips and: someDices and: aRewardBuilder [

	board := aBoard.
	ships := someShips.
	dices := someDices.
	laps := someLaps.
	finished := false.
	rewards := aRewardBuilder.
	winner := NullShip new
]

{ #category : 'action' }
Game >> jump: squaresToJump from: aPosition [ 
	
	^ board jump: squaresToJump from: aPosition 
]

{ #category : 'accessing' }
Game >> maximumRoll [

	^ dices sum: [ :aDice | aDice rollMaximum ]
]

{ #category : 'action' }
Game >> move: aShip with: rolledNumber [

	| shipInitialPosition squaresTraveled shipPositionBeforeWormHole shipPositionAfterWormHole shipPositionAfterSquareEffect squaresTraveledWithDice squaresTraveledWithSquareEffect |
	aShip canPlay: rolledNumber.

	shipInitialPosition := aShip currentPosition.

	shipPositionBeforeWormHole := board
		                              update: shipInitialPosition
		                              with: rolledNumber.

	squaresTraveledWithDice := board
		                           calculateDistanceBetween:
		                           shipInitialPosition
		                           and: shipPositionBeforeWormHole.

	shipPositionAfterWormHole := board moveIfWormHoleAt:
		                             shipPositionBeforeWormHole.

	aShip moveTo: shipPositionAfterWormHole.
	aShip consumeFuel: squaresTraveledWithDice.

	shipPositionAfterSquareEffect := self
		                                 applyEffectOn: aShip
		                                 with: shipPositionAfterWormHole.

	squaresTraveledWithSquareEffect := board
		                                   calculateDistanceBetween:
		                                   shipPositionAfterWormHole
		                                   and:
		                                   shipPositionAfterSquareEffect.


	squaresTraveled := squaresTraveledWithSquareEffect.

	aShip moveTo: shipPositionAfterSquareEffect.
	aShip consumeFuel: squaresTraveled.

	shipPositionAfterSquareEffect hasCompleted: laps in: self
]

{ #category : 'action' }
Game >> moveShipsBackwards: aMagnitude [

	| shipInitialPosition shipNewPosition squaresTraveled |
	ships do: [ :aShip |
		shipInitialPosition := aShip currentPosition.
		shipNewPosition := board
			                   update: shipInitialPosition
			                   with: aMagnitude negated.

		squaresTraveled := board
			                   calculateDistanceBetween: shipInitialPosition
			                   and: shipNewPosition.

		aShip moveTo: shipNewPosition.
		[ aShip consumeFuel: squaresTraveled ]
			on: Error
			do: [
				aShip moveTo: shipInitialPosition.
				aShip losesTwoTurns.
				aShip fuel: (self class maximumRoll: dices) * 2 ] ]
]

{ #category : 'action' }
Game >> moveShipsToSquareZero [
	
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

	| shipToMove rolledNumber shipInitialPosition |
	self canStillPlay.
	shipToMove := ships removeFirst.
	rolledNumber := self rollDices.
	shipInitialPosition := shipToMove currentPosition.
	self applyRewardTo: shipToMove for: rolledNumber.
	[ self move: shipToMove with: rolledNumber ]
		on: Error
		do: [
			shipToMove moveTo: shipInitialPosition.
			shipToMove losesTwoTurns.
			shipToMove restoreFuel ].
	ships add: shipToMove.
	finished ifTrue: [ winner := shipToMove ]
]

{ #category : 'printing' }
Game >> printBoard [

	| positions results winnerShip sortedPositions |
	winnerShip := 'Winner: ' , winner name , String cr.
	sortedPositions := ships sorted: [ :aShip |
		                   board
			                   calculateDistanceBetween: (Position at: 0 in: 1)
			                   and: aShip currentPosition ] descending.
	positions := String cr join:
		             (sortedPositions collect: [ :aShip | aShip details ]).

	results := winnerShip , positions.
	^ results
]

{ #category : 'action' }
Game >> rollDices [

	| rolledNumber |
	rolledNumber := dices sum: [ :aDice | aDice roll ].

	^ rolledNumber
]
