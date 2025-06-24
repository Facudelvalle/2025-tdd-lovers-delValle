"
This class represent a square
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
Square >> applyOn: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'validation' }
Square >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	^ true
]
