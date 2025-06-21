"
This class represent a worm hole end point
"
Class {
	#name : 'WormHoleEndpoint',
	#superclass : 'Object',
	#instVars : [
		'position',
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
WormHoleEndpoint class >> at: aPosition [

	^ self new initializeAt: aPosition
]

{ #category : 'comparing' }
WormHoleEndpoint >> = aPosition [

	^ position = aPosition
]

{ #category : 'comparing' }
WormHoleEndpoint >> > aLength [

	^ index > aLength
]

{ #category : 'effect' }
WormHoleEndpoint >> applyOn: aShip and: aPosition in: aGame [

	^ aPosition
]

{ #category : 'evaluating' }
WormHoleEndpoint >> in: aPosition [

	^ index = aPosition
]

{ #category : 'accessing' }
WormHoleEndpoint >> initializeAt: aPosition [

	position := aPosition.
	index := aPosition + 1
]

{ #category : 'accessing' }
WormHoleEndpoint >> position [

	^ position
]

{ #category : 'validation' }
WormHoleEndpoint >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	^ true
]
