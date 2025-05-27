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

{ #category : 'as yet unclassified' }
HyperGravitySquare >> applyOn: aShip and: aPosition [

	aShip applyGravityPenalty: rollToContinue.
	^ aPosition
]

{ #category : 'as yet unclassified' }
HyperGravitySquare >> assigned: someDices [

	rollToContinue := 1 to:
	                  (someDices sum: [ :aDice | aDice rollMaximum ])
		                  atRandom
]

{ #category : 'testing' }
HyperGravitySquare >> isGreaterThan: aRolledNumber [

	^ rollToContinue > aRolledNumber
]
