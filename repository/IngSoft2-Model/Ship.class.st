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
		'rollModifier'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Ship class >> called: aName [

	^ self new initializeCalled: aName
]

{ #category : 'adding' }
Ship >> addCards: someCards [
	
	someCards do: [ :aCard | cards add: aCard ]
]

{ #category : 'update' }
Ship >> adjust: aRolledNumber [

	^ aRolledNumber + rollModifier
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

{ #category : 'testing' }
Ship >> canLendFuelFor: fuelNeededToTravel [

	^ fuel >= fuelNeededToTravel
]

{ #category : 'testing' }
Ship >> canPlay: aRolledNumber [

	| hasToWait |
	hasToWait := turnsLeftToWait > 0.
	
	hasToWait ifTrue: [
		self reducePenalty ].
	
	^  hasToWait not and: gravityPenalty <= aRolledNumber 
]

{ #category : 'accessing' }
Ship >> cards [
		
	^ cards
]

{ #category : 'update' }
Ship >> consumeFuel: squaresToTravel from: initialPosition [ 
	
	fuel := fuel consume: squaresToTravel by: self.
	fuel applyPenaltyTo: self thatStartedFrom: initialPosition.
	"[ self hasEnoughFuelToTravel: squaresToTravel ]
		on: Error
		do: [
			fuelNeededToTravel := fuel abs.
			lendingAlly := allies
				               detect: [ :anAlly |
				               anAlly canLendFuelFor: fuelNeededToTravel ]
				               ifNone: [ lendingAlly := NullShip new ].
			lendingAlly consumeFuelByAlly: fuelNeededToTravel.
			fuel := 0 ]"
]

{ #category : 'update' }
Ship >> consumeFuelByAlly: fuelToConsume [

	fuel := fuel - fuelToConsume
]

{ #category : 'accessing' }
Ship >> currentPosition [

	^ position
]

{ #category : 'comparing' }
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

{ #category : 'accessing' }
Ship >> fuel: someFuel [
	
	fuel := fuel modifyMaximumAmountBy: someFuel.
	fuel := fuel restore.
]

{ #category : 'comparing' }
Ship >> fuelEquals: someFuel [
	
	^ fuel equals: someFuel
]

{ #category : 'testing' }
Ship >> hasAFuelPenalty [

	^ turnsLeftToWait > 0
]

{ #category : 'testing' }
Ship >> hasEnoughFuelToTravel: squaresToTravel [

	fuel < 0 ifTrue: [
		Error signal: 'Ship does not have enough fuel to move.' ]
]

{ #category : 'accessing' }
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
	allies add: NullShip new
]

{ #category : 'penalty' }
Ship >> losesTwoTurns [

	turnsLeftToWait := 2
]

{ #category : 'accessing' }
Ship >> modifyFuelBy: aFuelAmount [

	fuel := fuel modifyBy: aFuelAmount
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
	allies first restoreFuel
]

{ #category : 'move' }
Ship >> playTurnWith: aRolledNumber on: aBoard [

	| adjustedRolledNumber positionBeforeWormHole squaresTraveledWithDice positionAfterWormHole initialPosition |
	(self canPlay: aRolledNumber) ifFalse: [ ^ self ].
	initialPosition := position.
	adjustedRolledNumber := self adjust: aRolledNumber.
	
	positionBeforeWormHole := aBoard
		                              update: position
		                              with: adjustedRolledNumber.
	squaresTraveledWithDice := aBoard
		                           calculateDistanceBetween: position
		                           and: positionBeforeWormHole.
	positionAfterWormHole := aBoard moveIfWormHoleAt:
		                             positionBeforeWormHole.
	self moveTo: positionAfterWormHole.
	self consumeFuel: squaresTraveledWithDice from: initialPosition.
]

{ #category : 'penalty' }
Ship >> reducePenalty [

	turnsLeftToWait := turnsLeftToWait - 1
]

{ #category : 'removing' }
Ship >> remove: aCard [

	| indexOfCard |
	indexOfCard := cards indexOf: aCard.
	cards removeIndex: indexOfCard
]

{ #category : 'removing' }
Ship >> removeAlly: anAlly [

	allies remove: anAlly.
	allies isEmpty ifTrue: [ allies add: NullShip new ]
]

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuel := fuel restore.
]

{ #category : 'comparing' }
Ship >> validateCard: aCard [ 
	
	(cards includes: aCard) ifFalse: [ Error signal: 'The ship does not have that card on its hand.' ] 
]
