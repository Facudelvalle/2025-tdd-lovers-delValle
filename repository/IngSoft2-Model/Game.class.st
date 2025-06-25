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
Game >> applyEffectMovementFor: aShip from: shipPositionAfterWormHole to: shipPositionAfterSquareEffect [

	| squaresTraveledWithSquareEffect |
	squaresTraveledWithSquareEffect := board
		                                   calculateDistanceBetween:
		                                   shipPositionAfterWormHole
		                                   and:
		                                   shipPositionAfterSquareEffect.

	aShip moveTo: shipPositionAfterSquareEffect.
	aShip consumeFuel: squaresTraveledWithSquareEffect
]

{ #category : 'action' }
Game >> applyEffectOn: aShip with: aPosition [

	^ board applyEfectOn: aShip with: aPosition in: self.
]

{ #category : 'action' }
Game >> applyLastEffectTo: aShip [

	| shipInitialPosition shipPositionAfterEffect |
	shipInitialPosition := aShip currentPosition.

	shipPositionAfterEffect := lastEffect
		                           repeatEffectFor: aShip
		                           on: shipInitialPosition
		                           in: self.

	self
		applyEffectMovementFor: aShip
		from: shipInitialPosition
		to: shipPositionAfterEffect
]

{ #category : 'action' }
Game >> applyRewardTo: aShip for: aRolledNumber [

	aRolledNumber = self maximumRoll ifTrue: [
		rewards generateOne applyTo: aShip ]
]

{ #category : 'action' }
Game >> applyRollPenalty: aPenalty [

	ships do: [ :aShip | aShip applyRollPenalty: aPenalty ]
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
Game >> goBackFourSquares: aShip from: aPosition [ 
	
	^ board goBackFourSquares: aShip from: aPosition 
]

{ #category : 'testing' }
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

{ #category : 'action' }
Game >> jump: squaresToJump from: aPosition [ 
	
	^ board jump: squaresToJump from: aPosition 
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
Game >> move: aShip backward: aMagnitude [

	| shipInitialPosition shipNewPosition |
	shipInitialPosition := aShip currentPosition.
	shipNewPosition := board
		                   update: shipInitialPosition
		                   with: aMagnitude negated.
	^ shipNewPosition 
]

{ #category : 'action' }
Game >> move: aShip with: rolledNumber [

	| shipInitialPosition shipPositionBeforeWormHole shipPositionAfterWormHole shipPositionAfterSquareEffect squaresTraveledWithDice adjustedRolledNumber |
	aShip canPlay: rolledNumber.

	self applyRewardTo: aShip for: rolledNumber.

	shipInitialPosition := aShip currentPosition.

	adjustedRolledNumber := aShip adjust: rolledNumber.

	shipPositionBeforeWormHole := board
		                              update: shipInitialPosition
		                              with: adjustedRolledNumber.

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

	self
		applyEffectMovementFor: aShip
		from: shipPositionAfterWormHole
		to: shipPositionAfterSquareEffect.

	shipPositionAfterSquareEffect > raceGoal ifTrue: [ self finish ]
]

{ #category : 'action' }
Game >> moveShipsBackwards: aMagnitude [

	| shipInitialPosition shipNewPosition |
	ships do: [ :aShip |
		shipInitialPosition := aShip currentPosition.
		shipNewPosition := self move: aShip backward: aMagnitude.
		[
		self
			applyEffectMovementFor: aShip
			from: shipInitialPosition
			to: shipNewPosition ]
			on: Error
			do: [
				aShip moveTo: shipInitialPosition.
				aShip losesTwoTurns.
				aShip restoreFuel ] ]
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

	| shipToMove rolledNumber shipInitialPosition lastEffectBeforeMovement |
	self canStillPlay.
	shipToMove := ships removeFirst.
	rolledNumber := self rollDices.
	shipInitialPosition := shipToMove currentPosition.
	lastEffectBeforeMovement := lastEffect.
	[ self move: shipToMove with: rolledNumber ]
		on: Error
		do: [ :anError |
			anError messageText = 'Ship does not have enough fuel to move.'
				ifTrue: [
					shipToMove penalizeAndReturnTo: shipInitialPosition.
					lastEffect := lastEffectBeforeMovement ] ].
	ships add: shipToMove.
	finished ifTrue: [ winner := shipToMove ]
]

{ #category : 'action' }
Game >> play: aPlayedCard by: aPlayingShip affecting: anAffectedCard and: anAfectedShip [

	aPlayingShip validateCard: aPlayedCard.

	aPlayedCard
		bePlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAfectedShip
		in: self
]

{ #category : 'action' }
Game >> playLastCardBy: aPlayingShip affecting: anAffectedCard and: aTargetShip [

	lastPlayedCard
		bePlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: aTargetShip
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
