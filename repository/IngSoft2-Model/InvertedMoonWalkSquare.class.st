"
This class represents an inverted moon walk square
"
Class {
	#name : 'InvertedMoonWalkSquare',
	#superclass : 'Square',
	#instVars : [
		'magnitude'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
InvertedMoonWalkSquare class >> in: aPosition with: aMagnitude [

	^ self new initializeIn: aPosition with: aMagnitude
]

{ #category : 'effect' }
InvertedMoonWalkSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aGame move: aShip backwardsBy: magnitude
]

{ #category : 'initialization' }
InvertedMoonWalkSquare >> initializeIn: aPosition with: aMagnitude [

	position := aPosition.
	magnitude := aMagnitude
]
