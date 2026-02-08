"
This class represents a moon walk square
"
Class {
	#name : 'MoonWalkSquare',
	#superclass : 'Square',
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
MoonWalkSquare >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	^ aGame move: aShip backwardsBy: magnitude
]

{ #category : 'effect' }
MoonWalkSquare >> applyRegularEffectOn: aShip and: aPosition in: aGame [ 
	
	aGame moveShipsBackwards: magnitude.
	^ aPosition 
]

{ #category : 'initialization' }
MoonWalkSquare >> initializeBetween: aMinimumMagnitude and: aMaximumMagnitude [

	super initialize.
	magnitude := (aMinimumMagnitude to: aMaximumMagnitude) atRandom
]

{ #category : 'effect' }
MoonWalkSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ aGame move: aShip backwardsBy: magnitude
]

{ #category : 'validation' }
MoonWalkSquare >> validateMagnitudeWith: aMaximumRoll and: aBoardLength [

	magnitude < 1 ifTrue: [
		Error signal:
			'The magnitude of the Moon Walk Square must be positive.' ]
]
