"
This class represent a worm hole beginning
"
Class {
	#name : 'WormHoleBeginning',
	#superclass : 'WormHoleEndpoint',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
WormHoleBeginning >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	^ wormHole applyBeginningInvertedEffectOn: aPosition in: aGame
]

{ #category : 'effect' }
WormHoleBeginning >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	^ wormHole applyBeginningRegularEffectOn: aPosition
]
