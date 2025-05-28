"
This class represents a hyper gravity square
"
Class {
	#name : 'HyperGravitySquare',
	#superclass : 'Object',
	#instVars : [
		'rollToContinue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
HyperGravitySquare class >> between: aMinimumMagnitude and: aMaximumMagnitude [

	^ self new
		  initializeBetween: aMinimumMagnitude
		  and: aMaximumMagnitude
]

{ #category : 'effect' }
HyperGravitySquare >> applyOn: aShip and: aPosition in: aGame [

	aShip applyGravityPenalty: rollToContinue.
	^ aPosition
]

{ #category : 'initialization' }
HyperGravitySquare >> initializeBetween: aMinimumMagnitude and: aMaximumMagnitude [

	rollToContinue := (aMinimumMagnitude to: aMaximumMagnitude) atRandom
]

{ #category : 'testing' }
HyperGravitySquare >> isGreaterThan: aRolledNumber [

	^ rollToContinue > aRolledNumber
]

{ #category : 'validation' }
HyperGravitySquare >> validateMagnitudeWith: aMagnitude and: aBoardLenght [

	rollToContinue > aMagnitude ifTrue: [
		Error signal:
			'The magnitude of the Hyper Gravity Square is grater than the maximum roll.' ]
]
