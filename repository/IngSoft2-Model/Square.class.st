"
This class represent a square
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Square >> = aSquare [

	^ self class = aSquare class
]

{ #category : 'effect' }
Square >> applyOn: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'assignments' }
Square >> assignToPosition: aNumber [

	position := Position at: aNumber in: 1
]

{ #category : 'transformations' }
Square >> invert [

	self subclassResponsibility
]

{ #category : 'validation' }
Square >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	^ true
]
