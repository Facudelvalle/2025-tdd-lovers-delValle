"
This class represents a moon walk square
"
Class {
	#name : 'MoonWalkSquare',
	#superclass : 'Object',
	#instVars : [
		'magnitude'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
MoonWalkSquare class >> between: aMinimumMagnitude and: aMaximumMagnitude [

	^ self new
		  initializeBetween: aMinimumMagnitude
		  and: aMaximumMagnitude
]

{ #category : 'effect' }
MoonWalkSquare >> applyOn: aShip and: aPosition in: aGame [ 
	
	aGame moveShipsBackwards: magnitude.
	^ aPosition 
]

{ #category : 'initialization' }
MoonWalkSquare >> initializeBetween: aMinimumMagnitude and: aMaximumMagnitude [

	magnitude := (aMinimumMagnitude to: aMaximumMagnitude) atRandom
]

{ #category : 'validation' }
MoonWalkSquare >> validateMagnitudeWith: aMaximumRoll and: aBoardLength [

	magnitude < 1 ifTrue: [
		Error signal:
			'The magnitude of the Moon Walk Square must be positive.' ]
]
