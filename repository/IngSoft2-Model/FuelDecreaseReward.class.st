"
This class represent a fuel decrese reward
"
Class {
	#name : 'FuelDecreaseReward',
	#superclass : 'Object',
	#instVars : [
		'magnitude'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
FuelDecreaseReward class >> of: aMagnitude [

	^ self new initializeOf: aMagnitude
]

{ #category : 'operations' }
FuelDecreaseReward >> applyTo: aShip [

	aShip addFuel: magnitude
]

{ #category : 'initialization' }
FuelDecreaseReward >> initializeOf: aMagnitude [

	magnitude := aMagnitude
]
