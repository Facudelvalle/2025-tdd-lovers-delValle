"
This class represents the fuel
"
Class {
	#name : 'Fuel',
	#superclass : 'Object',
	#instVars : [
		'fuelState',
		'amount',
		'maximumAmount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creating' }
Fuel class >> with: anAmount upTo: aMaximumAmount in: aState [

	^ self new initializeWith: anAmount upTo: aMaximumAmount in: aState.
]

{ #category : 'comparing' }
Fuel >> amountEquals: aFuelAmount [ 
	
	^ amount = aFuelAmount.
]

{ #category : 'accessing' }
Fuel >> amountNeeded [

	^ amount abs
]

{ #category : 'accessing' }
Fuel >> amountOfFuelNeeded [

	^ fuelState amountOfFuelNeededBy: self
]

{ #category : 'penalty' }
Fuel >> applyPenaltyTo: aShip thatStartedFrom: aPosition [

	fuelState applyPenaltyTo: aShip thatStartedFrom: aPosition.
]

{ #category : 'consuming' }
Fuel >> borrowBy: aShip [

	fuelState borrowBy: aShip
]

{ #category : 'comparing' }
Fuel >> canLendFuelFor: aFuelAmount [

	^ amount >= aFuelAmount
]

{ #category : 'consuming' }
Fuel >> consume: aFuelAmount [

	| updatedAmount updatedFuelState |
	updatedAmount := amount - aFuelAmount.
	updatedFuelState := fuelState updateFor: updatedAmount.
	^ self class with: updatedAmount upTo: maximumAmount in: updatedFuelState.
]

{ #category : 'comparing' }
Fuel >> equals: someFuel [

	^ (someFuel amountEquals: amount) and:
		  (someFuel maximumEquals: maximumAmount)
]

{ #category : 'initialization' }
Fuel >> initializeWith: anAmount upTo: aMaximumAmount in: aState [ 

	fuelState := aState.
	amount := anAmount.
	maximumAmount := aMaximumAmount
	
]

{ #category : 'accessing' }
Fuel >> maximumEquals: aMaximumAmount [

	^ maximumAmount = aMaximumAmount.
]

{ #category : 'accessing' }
Fuel >> maximumFuel [

	^ maximumAmount
]

{ #category : 'adding' }
Fuel >> modifyBy: aFuelAmount [

	^ self class with: amount + aFuelAmount upTo: maximumAmount in: fuelState.
]

{ #category : 'accessing' }
Fuel >> modifyMaximumAmountBy: aFuelAmount [

	^ self class with: amount upTo: aFuelAmount + maximumAmount in: fuelState.
]

{ #category : 'restoring' }
Fuel >> restore [

	^ self class with: maximumAmount upTo: maximumAmount in: HasFuelState new.
]
