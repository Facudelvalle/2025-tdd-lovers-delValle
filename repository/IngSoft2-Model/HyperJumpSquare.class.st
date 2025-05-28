"
This class represents a hyper jump square
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'parsecs'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperJumpSquare class >> with: aCollectionOfParsecs [

	^ self new initializeWith: aCollectionOfParsecs
]

{ #category : 'effect' }
HyperJumpSquare >> applyOn: aShip and: aPosition in: aGame [

	| actualParsec positionAfterJump |
	actualParsec := parsecs removeFirst.

	positionAfterJump := aPosition
		                     add: actualParsec
		                     with: aGame boardLength.

	parsecs add: actualParsec.

	^ positionAfterJump
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWith: aCollectionOfParsecs [

	parsecs := aCollectionOfParsecs
]

{ #category : 'validation' }
HyperJumpSquare >> validateMagnitudeWith: aMagnitude and: aBoardLenght [

	| parsecsLarge |
	parsecsLarge := parsecs sum: [ :aParsec | aParsec ].

	parsecsLarge / aBoardLenght ~= 1 ifTrue: [
		Error signal:
			'The magnitude of the Hyper Jump Square Parsecs is not valid.' ]
]
