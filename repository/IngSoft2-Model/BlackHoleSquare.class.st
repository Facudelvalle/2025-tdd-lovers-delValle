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
BlackHoleSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aGame goBackFourSquares: aShip from: aPosition
]

{ #category : 'transformations' }
BlackHoleSquare >> invert [

	^ InvertedBlackHoleSquare in: position
]

{ #category : 'effect' }
BlackHoleSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ self applyOn: aShip and: aPosition in: aGame
]
