"
This class represents a black hole square
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
BlackHoleSquare >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	aGame allOtherShipsLoseATurbine.
	aGame moveShipsBackwards: 4.
	^ aPosition
]

{ #category : 'effect' }
BlackHoleSquare >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	aShip loseATurbine.
	^ aGame move: aShip backwardsBy: 4
]
