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
		'maximumFuel'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Ship class >> called: aName [

	^ self new initializeCalled: aName
]

{ #category : 'accessing' }
Ship >> addFuel: aFuelQuantity [

	fuel := fuel + aFuelQuantity
]

{ #category : 'penalty' }
Ship >> applyGravityPenalty: aGravitySquare [

	gravityPenalty := aGravitySquare 
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

{ #category : 'update' }
Ship >> consumeFuel: squaresTraveled [
	
	self hasEnoughFuelToTravel: squaresTraveled.
	fuel := fuel - squaresTraveled
]

{ #category : 'accessing' }
Ship >> currentPosition [

	^ position
]

{ #category : 'compare' }
Ship >> currentPositionEquals: aPosition [ 
	
	^ position equals: aPosition 
]

{ #category : 'accessing' }
Ship >> details [

	^ name , ': ' , position asString
]

{ #category : 'accessing' }
Ship >> fuel: aFuelQuantity [

	fuel := aFuelQuantity.
	
	maximumFuel := aFuelQuantity.
]

{ #category : 'compare' }
Ship >> fuelEquals: aFuelQuantity [ 
	
	^ fuel = aFuelQuantity 
]

{ #category : 'testing' }
Ship >> hasEnoughFuelToTravel: squaresToTravel [

	fuel < squaresToTravel ifTrue: [
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
Ship >> reducePenalty [

	turnsLeftToWait := turnsLeftToWait - 1
]

{ #category : 'accessing' }
Ship >> restoreFuel [

	fuel := maximumFuel
]
