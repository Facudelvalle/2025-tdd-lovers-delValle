"
This class represents a set moon walk square
"
Class {
	#name : 'SetMoonWalkSquare',
	#superclass : 'Object',
	#instVars : [
		'magnitude'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
SetMoonWalkSquare class >> with: aMagnitude [

	^ self new initializeWith: aMagnitude
]

{ #category : 'effect' }
SetMoonWalkSquare >> applyOn: aShip and: aPosition in: aGame [

	aGame moveShipsBackwards: magnitude.
	^ aPosition
]

{ #category : 'initialization' }
SetMoonWalkSquare >> initializeWith: aMagnitude [

	magnitude := aMagnitude
]

{ #category : 'validation' }
SetMoonWalkSquare >> validateMagnitudeWith: aMagnitude and: aBoardLength [

	magnitude < 1 ifTrue: [
		Error signal:
			'The magnitude of the Moon Walk Square must be positive.' ]
]
