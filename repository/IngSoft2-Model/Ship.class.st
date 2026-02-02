"
This class represent a player
"
Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'fuel',
		'turnsLeftToWait',
		'gravityPenalty',
		'cards',
		'allies',
		'rollModifier',
		'turbines'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Ship class >> called: aName [

	^ self new initializeCalled: aName
]

{ #category : 'update' }
Ship >> addCards: someCards [
	
	someCards do: [ :aCard | cards add: aCard ]
]

{ #category : 'update' }
Ship >> adjust: aRolledNumber [

	^ aRolledNumber + rollModifier
]

{ #category : 'update' }
Ship >> adjustSquare: aSquare [

	position := position adjustSquare: aSquare
]

{ #category : 'accessing' }
Ship >> amountOfCards [

	^ cards size
]

{ #category : 'penalty' }
Ship >> applyGravityPenalty: aGravitySquare [

	gravityPenalty := aGravitySquare 
]

{ #category : 'penalty' }
Ship >> applyRollModifier: aModifier [

	rollModifier := rollModifier + aModifier
]

{ #category : 'move' }
Ship >> borrowFuelFromAllies [

	| fuelNeededToTravel lendingAlly updatedFuelState |
	fuelNeededToTravel := fuel amountOfFuelNeeded.
	lendingAlly := allies
		               detect: [ :anAlly |
		               anAlly canLendFuelFor: fuelNeededToTravel ]
		               ifNone: [ lendingAlly := NullShip new ].
	updatedFuelState := lendingAlly consumeFuelByAlly: fuelNeededToTravel.
	fuel := Fuel with: 0 upTo: fuel maximumFuel in: updatedFuelState
]

{ #category : 'testing' }
Ship >> canLendFuelFor: fuelNeededToTravel [

	^ fuel canLendFuelFor: fuelNeededToTravel
]

{ #category : 'testing' }
Ship >> canPlay: aRolledNumber [

	| hasToWait |
	hasToWait := turnsLeftToWait > 0.

	hasToWait ifTrue: [ self reducePenalty ].

	gravityPenalty > aRolledNumber ifTrue: [ self loseATurbine ].

	^ hasToWait not and: gravityPenalty <= aRolledNumber
]

{ #category : 'accessing' }
Ship >> cards [
		
	^ cards
]

{ #category : 'update' }
Ship >> consumeFuel: squaresToTravel from: initialPosition [

	fuel := fuel consume: squaresToTravel.
	fuel borrowBy: self.
	fuel applyPenaltyTo: self thatStartedFrom: initialPosition
]

{ #category : 'update' }
Ship >> consumeFuelByAlly: fuelToConsume [

	fuel := fuel consume: fuelToConsume.
	^ HasFuelState new
]

{ #category : 'accessing' }
Ship >> currentPosition [

	^ position
]

{ #category : 'testing' }
Ship >> currentPositionEquals: aPosition [ 
	
	^ position equals: aPosition 
]

{ #category : 'accessing' }
Ship >> details [

	^ name , ': ' , position asString
]

{ #category : 'comparing' }
Ship >> equals: aShip [

	^ name == aShip name
]

{ #category : 'update' }
Ship >> formAllianceWith: aShip [

	| aNullShip |
	allies add: aShip.
	aNullShip := NullShip new.
	allies remove: aNullShip ifAbsent: [ Error signal: 'pepe' ]
]

{ #category : 'update' }
Ship >> fuel: someFuel [
	
	fuel := fuel modifyMaximumAmountBy: someFuel.
	fuel := fuel restore.
]

{ #category : 'testing' }
Ship >> fuelEquals: someFuel [
	
	^ fuel equals: someFuel
]

{ #category : 'testing' }
Ship >> hasAFuelPenalty [

	^ turnsLeftToWait > 0
]

{ #category : 'testing' }
Ship >> hasEnoughTurbines [

	^ turbines > 0
]

{ #category : 'update' }
Ship >> increaseMaxFuel: aMagnitude [

	fuel := fuel modifyMaximumAmountBy: aMagnitude.
	
]

{ #category : 'initialization' }
Ship >> initializeCalled: aName [

	name := aName.
	position := Position at: 0 in: 1.
	fuel := Fuel with: 0 upTo: 0 in: DoesntHaveFuelState new.
	turnsLeftToWait := 0.
	gravityPenalty := 0.
	cards := OrderedCollection new.
	rollModifier := 0.
	allies := OrderedCollection new.
	allies add: NullShip new.
	turbines := 3
]

{ #category : 'move' }
Ship >> jump: squaresToMove on: aBoard [

	| positionAfterJump initialPosition squaresTraveledWithSquareEffect |
	initialPosition := position.
	positionAfterJump := aBoard jump: squaresToMove from: initialPosition.

	squaresTraveledWithSquareEffect := aBoard
		                                   calculateDistanceBetween:
		                                   initialPosition
		                                   and: positionAfterJump.

	self moveTo: positionAfterJump.
	self
		consumeFuel: squaresTraveledWithSquareEffect
		from: initialPosition.

	^ positionAfterJump
]

{ #category : 'penalty' }
Ship >> loseATurbine [

	turbines := turbines - 1
]

{ #category : 'penalty' }
Ship >> losesTwoTurns [

	turnsLeftToWait := 2
]

{ #category : 'update' }
Ship >> modifyFuelBy: aFuelAmount [

	fuel := fuel modifyBy: aFuelAmount
]

{ #category : 'move' }
Ship >> moveBackwards: aMagnitude in: aBoard [

	| shipNewPosition |
	shipNewPosition := aBoard update: position with: aMagnitude negated.

	self performMovementFrom: position to: shipNewPosition on: aBoard.
	^ shipNewPosition.
	
]

{ #category : 'move' }
Ship >> moveTo: aPosition [

	position := aPosition
]

{ #category : 'accessing' }
Ship >> name [

	^ name
]

{ #category : 'penalty' }
Ship >> penalizeAndReturnTo: shipInitialPosition [

	self moveTo: shipInitialPosition.
	self losesTwoTurns.
	self restoreFuel.
	allies first losesTwoTurns.
	allies first restoreFuel.
	self loseATurbine.
	allies first loseATurbine
]

{ #category : 'move' }
Ship >> performMovementFrom: anInitialPosition to: aFinalPosition on: aBoard [
	
	| squaresTraveled |
	squaresTraveled := aBoard
		                   calculateDistanceBetween: position
		                   and: aFinalPosition.

	self moveTo: aFinalPosition.
	self consumeFuel: squaresTraveled from: anInitialPosition
]

{ #category : 'move' }
Ship >> playTurnWith: aRolledNumber on: aBoard in: aGame [

	| adjustedRolledNumber positionBeforeWormHole squaresTraveledWithDice positionAfterWormHole initialPosition positionAfterSquareEffect squaresTraveledWithSquareEffect |
	self hasEnoughTurbines ifFalse: [
		Error signal:
			'This ship cannot keep playing because it ran out of turbines.' ].
	(self canPlay: aRolledNumber) ifFalse: [ ^ self ].


	initialPosition := position.
	adjustedRolledNumber := self adjust: aRolledNumber.

	positionBeforeWormHole := aBoard
		                          update: position
		                          with: adjustedRolledNumber.

	squaresTraveledWithDice := aBoard
		                           calculateDistanceBetween: position
		                           and: positionBeforeWormHole.

	positionAfterWormHole := aBoard
		                         move: self
		                         ifWormHoleAt: positionBeforeWormHole
		                         in: aGame.

	self moveTo: positionAfterWormHole.
	self consumeFuel: squaresTraveledWithDice from: initialPosition.

	positionAfterSquareEffect := aBoard
		                             applyEffectOn: self
		                             with: position
		                             in: aGame.

	squaresTraveledWithSquareEffect := aBoard
		                                   calculateDistanceBetween:
		                                   position
		                                   and: positionAfterSquareEffect.

	self moveTo: positionAfterSquareEffect.
	self
		consumeFuel: squaresTraveledWithSquareEffect
		from: initialPosition
]

{ #category : 'penalty' }
Ship >> reducePenalty [

	turnsLeftToWait := turnsLeftToWait - 1
]

{ #category : 'update' }
Ship >> remove: aCard [

	| indexOfCard |
	indexOfCard := cards indexOf: aCard.
	cards removeIndex: indexOfCard
]

{ #category : 'update' }
Ship >> removeAlly: anAlly [

	allies remove: anAlly.
	allies isEmpty ifTrue: [ allies add: NullShip new ]
]

{ #category : 'update' }
Ship >> restoreFuel [

	fuel := fuel restore.
]

{ #category : 'accessing' }
Ship >> turbines [

	^ turbines
]

{ #category : 'comparing' }
Ship >> validateCard: aCard [

	(cards includes: aCard) ifFalse: [
		Error signal: 'The ship does not have that card on its hand.' ]
]
