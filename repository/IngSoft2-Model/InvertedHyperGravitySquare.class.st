"
This class represents an inverted hyper gravity square
"
Class {
	#name : 'InvertedHyperGravitySquare',
	#superclass : 'Square',
	#instVars : [
		'rollToContinue'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
InvertedHyperGravitySquare class >> in: aPosition with: aRollToContinueValue [

	^ self new initializeIn: aPosition with: aRollToContinueValue
]

{ #category : 'effect' }
InvertedHyperGravitySquare >> applyOn: aShip and: aPosition in: aGame [

	aGame applyToAllShipsGravityPenaltyOf: rollToContinue.
	^ aPosition
]

{ #category : 'initialization' }
InvertedHyperGravitySquare >> initializeIn: aPosition with: aRollToContinueValue [

	position := aPosition.
	rollToContinue := aRollToContinueValue
]
