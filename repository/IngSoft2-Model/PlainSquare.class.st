"
This class represents a plain square
"
Class {
	#name : 'PlainSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
PlainSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aPosition
]

{ #category : 'effect' }
PlainSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ self applyOn: aShip and: aPosition in: aGame
]
