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
		'maximumFuel',
		'cards',
		'ally',
		'rollPenalty'
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

{ #category : 'accessing' }
Ship >> addFuel: aFuelQuantity [

	fuel := fuel + aFuelQuantity
]

{ #category : 'as yet unclassified' }
Ship >> adjust: aRolledNumber [

	^ aRolledNumber + rollPenalty
]

{ #category : 'penalty' }
Ship >> applyGravityPenalty: aGravitySquare [

	gravityPenalty := aGravitySquare 
]

{ #category : 'as yet unclassified' }
Ship >> applyRollPenalty: aPenalty [

	rollPenalty := rollPenalty + aPenalty
]

{ #category : 'testing' }
Ship >> canPlay: rolledNumber [

	turnsLeftToWait > 0 ifTrue: [
		self reducePenalty.
		Error signal: 'The ship has a penalty of movement' ].
	gravityPenalty > rolledNumber ifTrue: [
		Error signal:
			'The number rolled is not enought to pass the gravity penalty' ]
]

{ #category : 'accessing' }
Ship >> cards [
		
	^ cards
]

{ #category : 'update' }
Ship >> consumeFuel: squaresToTravel [

	| fuelNeededToTravel |
	fuel := fuel - squaresToTravel.
	[ self hasEnoughFuelToTravel: squaresToTravel ]
		on: Error
		do: [
			fuelNeededToTravel := squaresToTravel - (fuel + squaresToTravel).
			ally consumeFuelByAlly: fuelNeededToTravel.
			fuel := 0 ]
]

{ #category : 'update' }
Ship >> consumeFuelByAlly: fuelToConsume [

	fuel := fuel - fuelToConsume.
	self hasEnoughFuelToTravel: fuelToConsume
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

	ally := aShip
]

{ #category : 'accessing' }
Ship >> fuel: aFuelQuantity [

	fuel := aFuelQuantity.
	
	maximumFuel := aFuelQuantity.
]

{ #category : 'comparing' }
Ship >> fuelEquals: aFuelQuantity [ 
	
	^ fuel = aFuelQuantity 
]

{ #category : 'testing' }
Ship >> hasAFuelPenalty [

	^ turnsLeftToWait > 0
]

{ #category : 'testing' }
Ship >> hasEnoughFuelToTravel: squaresToTravel [

	(fuel + squaresToTravel) < squaresToTravel ifTrue: [
		Error signal: 'Ship does not have enough fuel to move.' ]
]

{ #category : 'accessing' }
Ship >> increaseMaxFuel: aMagnitude [

	maximumFuel := maximumFuel + aMagnitude
]

{ #category : 'initialization' }
Ship >> initializeCalled: aName [

	name := aName.
	position := Position at: 0 in: 1.
	fuel := 0.
	turnsLeftToWait := 0.
	gravityPenalty := 0.
	cards := OrderedCollection new.
	rollPenalty := 0.
	ally := NullShip new
]

{ #category : 'penalty' }
Ship >> losesTwoTurns [

	turnsLeftToWait := 2
]

{ #category : 'update' }
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
	ally losesTwoTurns.
	ally restoreFuel
]

{ #category : 'penalty' }
Ship >> reducePenalty [

	turnsLeftToWait := turnsLeftToWait - 1
]

{ #category : 'removing' }
Ship >> remove: aCard [

	| indexOfCard |
	indexOfCard := cards
		               indexOf: aCard
		               ifAbsent: [ Error signal: 'Card is not in hand.' ].

	cards removeIndex: indexOfCard
]

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuel := maximumFuel
]
