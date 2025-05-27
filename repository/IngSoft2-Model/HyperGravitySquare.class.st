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

{ #category : 'instance creation' }
HyperGravitySquare class >> with: someDices [

	| maximumRoll |
	maximumRoll := someDices.

	^ self new initializeWith: maximumRoll
]

{ #category : 'as yet unclassified' }
HyperGravitySquare >> applyOn: aShip and: aPosition [

	aShip applyGravityPenalty: rollToContinue.
	^ aPosition
]

{ #category : 'initialization' }
HyperGravitySquare >> initializeWith: aMaximumRoll [

	rollToContinue := aMaximumRoll
]

{ #category : 'testing' }
HyperGravitySquare >> isGreaterThan: aRolledNumber [

	^ rollToContinue > aRolledNumber
]
