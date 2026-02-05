"
This class represent a MAximum fuell reward
"
Class {
	#name : 'MaximumFuelReward',
	#superclass : 'Reward',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
MaximumFuelReward >> applyTo: aShip [

	aShip increaseMaxFuel: magnitude
]
