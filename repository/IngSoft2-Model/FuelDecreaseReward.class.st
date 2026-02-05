"
This class represent a fuel decrese reward
"
Class {
	#name : 'FuelDecreaseReward',
	#superclass : 'Reward',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
FuelDecreaseReward >> applyTo: aShip [

	aShip modifyFuelBy: magnitude
]
