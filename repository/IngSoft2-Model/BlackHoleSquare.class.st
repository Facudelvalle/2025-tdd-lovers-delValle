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

	aGame moveAllOtherShipsBackFourSquares.
	^ aPosition
]

{ #category : 'effect' }
BlackHoleSquare >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	^ aGame goBackFourSquares: aShip from: aPosition
]
