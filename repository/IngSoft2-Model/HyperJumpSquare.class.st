"
This class represents a hyper jump square
"
Class {
	#name : 'HyperJumpSquare',
	#superclass : 'Square',
	#instVars : [
		'units',
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

	| aUnitDistance positionAfterJump squaresToMove |
	aUnitDistance := units removeFirst.
	
	squaresToMove := self normalize: aUnitDistance.

	positionAfterJump := aGame jump: squaresToMove from: aPosition .

	units add: aUnitDistance.

	^ positionAfterJump
]

{ #category : 'initialization' }
HyperJumpSquare >> initializeWith: someUnits and: aRatio [

	units := someUnits sort: [ :aUnit :nextUnit | aUnit > nextUnit ].
	ratio := aRatio
]

{ #category : 'private' }
HyperJumpSquare >> normalize: aUnitDistance [

	^ aUnitDistance toParsec * ratio
]

{ #category : 'effect' }
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
	parsecsSum := units sumNumbers: [ :aUnitDistance | aUnitDistance toParsec ].
	
	boardInParsecs := self toParsecs: aBoardLenght.

	parsecsSum / boardInParsecs ~= 1 ifTrue: [
		Error signal:
			'The magnitude of the Hyper Jump Square Parsecs is not valid.' ]
]
