"
This class represent the board
"
Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'length',
		'wormHole',
		'distribution'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'assignments' }
Board class >> assignPositionsToSquaresFrom: aDistribution [

	aDistribution withIndexCollect: [ :aSquare :index |
		aSquare assignToPosition: index - 1 ]
]

{ #category : 'validation' }
Board class >> lengthIsValid: aLength [

	aLength < 2 ifTrue: [
		Error signal: 'Board must have at least two squares' ]
]

{ #category : 'creation' }
Board class >> replace: aDistribution withEndPointsFrom: aWormHole [

	^ aDistribution withIndexCollect: [ :aSquare :index |
		  aWormHole replace: aSquare in: index ]
]

{ #category : 'validation' }
Board class >> validate: aWormHole fallsInto: aLength [

	aWormHole fallsInto: aLength
]

{ #category : 'validation' }
Board class >> validate: aLength isSmallerThanTheEndingOf: aWormHole [

	aWormHole endsBefore: aLength
]

{ #category : 'creation' }
Board class >> with: aLength and: aWormHole distributedBy: aDistribution [

	| newDistribution |
	self lengthIsValid: aLength.
	self validate: aWormHole fallsInto: aLength.
	self validate: aLength isSmallerThanTheEndingOf: aWormHole.
	newDistribution := self
		                   replace: aDistribution
		                   withEndPointsFrom: aWormHole.
	self assignPositionsToSquaresFrom: newDistribution.
	^ self new
		  initializeWith: aLength
		  and: aWormHole
		  distributedBy: newDistribution
]

{ #category : 'action' }
Board >> applyEffectOn: aShip with: aPosition in: aGame [

	| effect |
	effect := self effectIn: aPosition currentSquare + 1.
	aGame lastEffect: effect.
	^ effect applyOn: aShip and: aPosition in: aGame
]

{ #category : 'action' }
Board >> calculateDistanceBetween: aPosition and: anotherPostion [

	^ aPosition squaresAwayFrom: anotherPostion with: length
]

{ #category : 'compare' }
Board >> distributionEquals: aDistribution [ 
	| squares |
	squares := String cr join: (distribution collect: [ :aSquare| aSquare asString ]).
	^ squares = aDistribution 
]

{ #category : 'accessing' }
Board >> effectIn: aSquare [

	^ distribution at: aSquare
]

{ #category : 'initialization' }
Board >> initializeWith: aLength and: aWormHole distributedBy: aDistribution [ 

	length := aLength.
	wormHole := aWormHole.
	distribution := aDistribution
]

{ #category : 'changing state' }
Board >> invertSquareIn: anAffectedSquaresPosition [

	(distribution at: anAffectedSquaresPosition currentSquare + 1) invert
]

{ #category : 'testing' }
Board >> isEmpty [

	^ false
]

{ #category : 'action' }
Board >> jump: squaresToJump from: aPosition [ 
	
	^ aPosition add: squaresToJump with: length 
]

{ #category : 'accessing' }
Board >> move: aShip ifWormHoleAt: aPosition in: aGame [

	^ wormHole move: aShip ifEndPointAt: aPosition in: aGame
]

{ #category : 'updating' }
Board >> update: aPosition with: aMagnitude [

	| newPosition |
	newPosition := aPosition add: aMagnitude with: length.
	^ newPosition
]

{ #category : 'validation' }
Board >> validateSquaresWith: aMaximumRoll [

	distribution do: [ :aSquare |
		aSquare validateMagnitudeWith: aMaximumRoll and: length ]
]
