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
		'rewards',
		'cards',
		'lastEffect',
		'lastPlayedCard',
		'activePermanentCards',
		'raceGoal'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Game class >> assignCardsTo: someShips from: aCardsManager [

	| someCards |
	someCards := aCardsManager generateFor: 2.
	someShips do: [ :aShip | aShip addCards: someCards ]
]

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
Game class >> with: aBoard for: someLaps and: someShips and: someDices and: aFuelQuantity and: aRewardManager and: aCardsManager [

	self hasDices: someDices.
	self hasShips: someShips.
	self hasLaps: someLaps.
	self fuel: someShips with: aFuelQuantity.
	self assignCardsTo: someShips from: aCardsManager.
	self validateSquaresFrom: aBoard with: someDices.
	^ self new
		  initializeWith: aBoard
		  for: someLaps
		  and: someShips
		  and: someDices
		  and: aRewardManager
			and: aCardsManager
]

{ #category : 'accessing' }
Game >> addActiveCard: aCard [

	activePermanentCards add: aCard
]

{ #category : 'action' }
Game >> applyLastEffectTo: aShip [

	| shipInitialPosition shipPositionAfterEffect |
	shipInitialPosition := aShip currentPosition.

	shipPositionAfterEffect := lastEffect
		                           repeatEffectFor: aShip
		                           on: shipInitialPosition
		                           in: self.

	aShip performMovementFrom: shipInitialPosition to: shipPositionAfterEffect on: board
]

{ #category : 'action' }
Game >> applyRewardTo: aShip for: aRolledNumber [

	aRolledNumber = self maximumRoll ifTrue: [
		rewards generateOne applyTo: aShip ]
]

{ #category : 'action' }
Game >> applyRollModifier: aPenalty [

	ships do: [ :aShip | aShip applyRollModifier: aPenalty ]
]

{ #category : 'action' }
Game >> applyToAllShipsGravityPenaltyOf: aRollToContinueValue [

	ships do: [ :aShip | aShip applyGravityPenalty: aRollToContinueValue ]
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
Game >> generateCard [

	^ cards generateFor: 1.
]

{ #category : 'action' }
Game >> giveAnotherCardToAllOtherShips [

	ships do: [ :aShip | aShip addCards: self generateCard ]
]

{ #category : 'action' }
Game >> goBackFourSquares: aShip from: aPosition [ 
	
	^ board goBackFourSquares: aShip from: aPosition 
]

{ #category : 'validation' }
Game >> hasFinished [

	^ finished
]

{ #category : 'initialization' }
Game >> initializeWith: aBoard for: someLaps and: someShips and: someDices and: aRewardManager and: aCardMaganer [

	board := aBoard.
	ships := someShips.
	dices := someDices.
	laps := someLaps.
	finished := false.
	rewards := aRewardManager.
	cards := aCardMaganer.
	lastEffect := PlainSquare new.
	winner := NullShip new.
	lastPlayedCard := NullCard new.
	raceGoal := Position at: 0 in: someLaps.
	activePermanentCards := OrderedCollection new
]

{ #category : 'changing state' }
Game >> invertSquareIn: anAffectedSquaresPosition [

	board invertSquareIn: anAffectedSquaresPosition
]

{ #category : 'action' }
Game >> jump: squaresToJump from: aPosition [ 
	
	^ board jump: squaresToJump from: aPosition 
]

{ #category : 'as yet unclassified' }
Game >> jumpOtherShipsADistanceOf: squaresToMove [

	ships do: [ :aShip | aShip jump: squaresToMove on: board ]
]

{ #category : 'accessing' }
Game >> lastEffect: anEffect [

	lastEffect := anEffect
]

{ #category : 'accessing' }
Game >> lastPlayedCard: aCard [

	lastPlayedCard := aCard
]

{ #category : 'accessing' }
Game >> maximumRoll [

	^ dices sum: [ :aDice | aDice rollMaximum ]
]

{ #category : 'action' }
Game >> move: aShip backwardsBy: aMagnitude [

	^ aShip moveBackwards: aMagnitude in: board.
]

{ #category : 'action' }
Game >> move: aShip with: rolledNumber [

	self applyRewardTo: aShip for: rolledNumber.
	aShip playTurnWith: rolledNumber on: board in: self.
	aShip currentPosition > raceGoal ifFalse: [ ^ self ].
	self finish.
	winner := aShip
]

{ #category : 'action' }
Game >> moveAllOtherShipsBackFourSquares [

	self moveShipsBackwards: 4
]

{ #category : 'action' }
Game >> moveShipsBackwards: aMagnitude [

	ships do: [ :aShip | aShip moveBackwards: aMagnitude in: board ]
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
	shipToMove restoreFuel.
	ships add: shipToMove.
]

{ #category : 'action' }
Game >> nextTurnPlay [

	| shipToMove rolledNumber |
	self canStillPlay.
	shipToMove := ships removeFirst.
	rolledNumber := self rollDices.
	self move: shipToMove with: rolledNumber.
	ships add: shipToMove
]

{ #category : 'action' }
Game >> play: aPlayedCard by: aPlayingShip affecting: anAffectedCard and: anAfectedShip and: anAffectedSquare [

	aPlayingShip validateCard: aPlayedCard.

	aPlayedCard
		bePlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAfectedShip
		and: anAffectedSquare
		in: self
]

{ #category : 'action' }
Game >> playLastCardBy: aPlayingShip affecting: anAffectedCard and: aTargetShip and: anAffectedSquare [

	lastPlayedCard
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: aTargetShip
		and: anAffectedSquare
		in: self
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

{ #category : 'removing' }
Game >> remove: anAffectedCard playedBy: aShip [

	self validateIsActive: anAffectedCard.
	activePermanentCards remove: anAffectedCard.
	anAffectedCard cancelEffectIn: self
]

{ #category : 'action' }
Game >> rollDices [

	| rolledNumber |
	rolledNumber := dices sumNumbers: [ :aDice | aDice roll ].

	^ rolledNumber
]

{ #category : 'validation' }
Game >> validateIsActive: aCard [

	(activePermanentCards includes: aCard) ifFalse: [
		Error signal: 'The card is not active.' ]
]

{ #category : 'validation' }
Game >> validateNextPlayer: aShip [

	((ships at: 1) equals: aShip) ifFalse: [
		Error signal:
			'A permanent card cannot be played when it is not your turn.' ]
]
