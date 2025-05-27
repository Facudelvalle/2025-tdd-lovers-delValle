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

{ #category : 'as yet unclassified' }
SetHyperGravitySquare >> applyOn: aShip and: aPosition [

	aShip applyGravityPenalty: rollToContinue.
	^ aPosition
]

{ #category : 'as yet unclassified' }
SetHyperGravitySquare >> assigned: someDices [

	^ true
]

{ #category : 'initialization' }
SetHyperGravitySquare >> initializeWith: aValue [

	rollToContinue := aValue
]

{ #category : 'testing' }
SetHyperGravitySquare >> isGreaterThan: aRolledNumber [

	^ rollToContinue > aRolledNumber
]
