"
This class represents a set hyper gravity square
"
Class {
	#name : 'SetHyperGravitySquare',
	#superclass : 'Object',
	#instVars : [
		'rollToContinue'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
SetHyperGravitySquare class >> with: aValue [

	| value |
	value := aValue .

	^ self new initializeWith: value
]

{ #category : 'effect' }
SetHyperGravitySquare >> applyOn: aShip and: aPosition in: aGame [

	aShip applyGravityPenalty: rollToContinue.
	^ aPosition
]

{ #category : 'initialization' }
SetHyperGravitySquare >> initializeWith: aValue [

	rollToContinue := aValue
]

{ #category : 'testing' }
SetHyperGravitySquare >> isGreaterThan: aRolledNumber [

	^ rollToContinue > aRolledNumber
]

{ #category : 'validating' }
SetHyperGravitySquare >> validateMagnitudeWith: aMagnitude and: aBoardLenght [

	^ true
]
