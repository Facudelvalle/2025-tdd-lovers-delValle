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
PlainSquare >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	^ aPosition
]

{ #category : 'effect' }
PlainSquare >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	^ aPosition
]
