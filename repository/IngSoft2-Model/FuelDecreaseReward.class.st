"
This class represent a fuel decrese reward
"
Class {
	#name : 'FuelDecreaseReward',
	#superclass : 'Reward',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
FuelDecreaseReward class >> of: aMagnitude [

	^ self new initializeOf: aMagnitude
]

{ #category : 'operations' }
FuelDecreaseReward >> applyTo: aShip [

	aShip modifyFuelBy: magnitude
]

{ #category : 'initialization' }
FuelDecreaseReward >> initializeOf: aMagnitude [

	magnitude := aMagnitude
]
