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

{ #category : 'creation' }
Game class >> with: aBoard for: someLaps and: someShips and: someDices [

	self hasDices: someDices.
	self hasShips: someShips.
	self hasLaps: someLaps.
	self fuel: someShips with: (self maximumRoll: someDices) * 2. 
	^ self new initializeWith: aBoard for: someLaps and: someShips and: someDices
]

{ #category : 'as yet unclassified' }
Game >> applyEffect: aShip and: aPosition [

	| effect |
	effect := board effectIn: aPosition currentSquare.

	^ effect applyOn: aShip and: aPosition 
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

	| shipInitialPosition shipPositionBeforeSquareEffect shipFinalPosition squaresTraveled |
	shipInitialPosition := aShip currentPosition.
	shipPositionBeforeSquareEffect := board
		                                  update: shipInitialPosition
		                                  with: rolledNumber.
	(shipPositionBeforeSquareEffect hasCompleted: laps) ifTrue: [
		self finish ].
	shipFinalPosition := self applyEffect: aShip and: shipPositionBeforeSquareEffect.  "Aca iria un mensaje al propio game que sea algo asi como aplicarEfectoDeLaSquare: shipPositionBeforeSquareEffect. y eso es lo que hace es mandar un mensaje polimorfico a la square que corresponda y retorna la posicion final, para esto deberiamos tener un array que tenga el efecto de cada square y lo comparamos con eso"
	squaresTraveled := shipInitialPosition  "Este se llamaria: squaresTraveledBeforeSquareEffect"
		                   squaresAwayFrom: shipPositionBeforeSquareEffect
		                   with: board length.
	"squaresTraveledAfterSquareEffect := shipPositionBeforeSquareEffect squaresAwayFrom: shipFinalPosition with: board length"
	"squaresTraveled := squaresTraveledBeforeSquareEffect + squaresTraveledAfterSquareEffect"
	aShip moveTo: shipFinalPosition.
	[ aShip consumeFuel: squaresTraveled ]
		on: Error
		do: [
			aShip moveTo: shipInitialPosition.
			aShip losesTwoTurns.
			aShip fuel: (self class maximumRoll: dices) * 2 ]
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
