"
This class represents a hyper jump square
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Square',
	#instVars : [
		'parsecs',
		'ratio'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
HyperJumpSquare class >> with: anArrayLength and: aRatio [
	
	^ self new initializeWith: anArrayLength and: aRatio
]

{ #category : 'effect' }
HyperJumpSquare >> applyOn: aShip and: aPosition in: aGame [

	| actualParsec positionAfterJump squaresToMove |
	actualParsec := parsecs removeFirst.
	
	squaresToMove := self normalize: actualParsec.

	positionAfterJump := aGame jump: squaresToMove from: aPosition .

	parsecs add: actualParsec.

	^ positionAfterJump
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWith: someParsecs and: aRatio [

	parsecs := someParsecs sort: [ :aParsec :nextParsec | aParsec > nextParsec ].
	ratio := aRatio
]

{ #category : 'private' }
HyperJumpSquare >> normalize: aParsec [

	^ aParsec * ratio
]

{ #category : 'as yet unclassified' }
HyperJumpSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ self applyOn: aShip and: aPosition in: aGame
]

{ #category : 'validation' }
HyperJumpSquare >> toParsecs: aBoardLenght [

	^ aBoardLenght // ratio
]

{ #category : 'validation' }
HyperJumpSquare >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	| parsecsSum boardInParsecs |
	parsecsSum := parsecs sum: [ :aParsec | aParsec ].
	
	boardInParsecs := self toParsecs: aBoardLenght.

	parsecsSum / boardInParsecs ~= 1 ifTrue: [
		Error signal:
			'The magnitude of the Hyper Jump Square Parsecs is not valid.' ]
]
