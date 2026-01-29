"
This class represent a worm hole end
"
Class {
	#name : 'WormHoleEnd',
	#superclass : 'WormHoleEndpoint',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
WormHoleEnd >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	^ wormHole applyEndInvertedEffectOn: aPosition in: aGame
]

{ #category : 'effect' }
WormHoleEnd >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	^ wormHole applyEndRegularEffectOn: aPosition
]
