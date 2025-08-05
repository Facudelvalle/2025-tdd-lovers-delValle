"
This class represent a MAximum fuell reward
"
Class {
	#name : 'MaximumFuelReward',
	#superclass : 'Reward',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MaximumFuelReward class >> of: aMagnitude [

	^ self new initializeOf: aMagnitude
]

{ #category : 'operations' }
MaximumFuelReward >> applyTo: aShip [

	aShip increaseMaxFuel: magnitude
]

{ #category : 'initialization' }
MaximumFuelReward >> initializeOf: aMagnitude [

	magnitude := aMagnitude
]
