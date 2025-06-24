"
This class represent an acceleration card
"
Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AccelerationCard >> bePlayedBy: aPlayingShip for: anAllyShip in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aGame applyRollPenalty: 1.
	
]
