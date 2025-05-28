"
This class represents a plain square
"
Class {
	#name : 'PlainSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
PlainSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aPosition
]

{ #category : 'validation' }
PlainSquare >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	^ true
]
