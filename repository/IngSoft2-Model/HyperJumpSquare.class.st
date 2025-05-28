"
This class represents a hyper jump square
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Object',
	#instVars : [
		'parsecs',
		'ratio'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperJumpSquare class >> with: aCollectionOfParsecs and: aRatio [

	^ self new initializeWith: aCollectionOfParsecs and: aRatio
]

{ #category : 'effect' }
HyperJumpSquare >> applyOn: aShip and: aPosition in: aGame [

	| actualParsec positionAfterJump squaresToMove |
	actualParsec := parsecs removeFirst.
	
	squaresToMove := self normalize: actualParsec.

	positionAfterJump := aPosition
		                     add: squaresToMove 
		                     with: aGame boardLength.

	parsecs add: actualParsec.

	^ positionAfterJump
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWith: aCollectionOfParsecs and: aRatio [

	parsecs := aCollectionOfParsecs sort: [:aParsec :nextParsec | aParsec > nextParsec ].
	ratio := aRatio
]

{ #category : 'private' }
HyperJumpSquare >> normalize: aParsec [

	^ aParsec * ratio
]

{ #category : 'validation' }
HyperJumpSquare >> toParsecs: aMagnitud [

	^ aMagnitud // ratio
]

{ #category : 'validation' }
HyperJumpSquare >> validateMagnitudeWith: aMagnitude and: aBoardLenght [

	| parsecsLarge boardInParsecs |
	parsecsLarge := parsecs sum: [ :aParsec | aParsec ].
	
	boardInParsecs := self toParsecs: aBoardLenght.

	parsecsLarge / boardInParsecs ~= 1 ifTrue: [
		Error signal:
			'The magnitude of the Hyper Jump Square Parsecs is not valid.' ]
]
