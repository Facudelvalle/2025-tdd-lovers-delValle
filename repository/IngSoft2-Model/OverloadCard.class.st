Class {
	#name : 'OverloadCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
OverloadCard >> bePlayedBy: aPlayingShip for: aTargetShip in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aTargetShip applyRollPenalty: -2
]
