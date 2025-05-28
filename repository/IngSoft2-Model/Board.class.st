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

{ #category : 'creation' }
Board class >> generateSquaresfrom: aDistribution with: aLength and: aWormHole [

	| generatedSquares |
	generatedSquares := (0 to: aLength - 1) collect: [ :aSquare |
		                    (aWormHole hasEndAt: aSquare)
			                    ifTrue: [ PlainSquare new ]
			                    ifFalse: [
				                    (aDistribution
					                     atRandom: Random new
					                     weighting: [ :aSquareProbability |
					                     aSquareProbability value ]) key value ] ].

	^ generatedSquares asOrderedCollection 
]

{ #category : 'validation' }
Board class >> lengthIsValid: aLength [

	aLength < 2 ifTrue: [
		Error signal: 'Board must have at least two squares' ]
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
 
	| generatedSquares |
	self lengthIsValid: aLength.
	self validate: aWormHole fallsInto: aLength.
	self validate: aLength isSmallerThanTheEndingOf: aWormHole.
	generatedSquares := self generateSquaresfrom: aDistribution with: aLength and: aWormHole.
	^ self new initializeWith: aLength and: aWormHole distributedBy: generatedSquares
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

{ #category : 'accessing' }
Board >> length [

	^ length
]

{ #category : 'accessing' }
Board >> moveIfWormHoleAt: aPosition [

	^ wormHole moveIfEndPointAt: aPosition
]

{ #category : 'accessing' }
Board >> showDistribution [
	
	| squares |
	squares := String cr join: (distribution collect: [ :aSquare| aSquare asString ]).

	^ squares
]

{ #category : 'updating' }
Board >> update: aPosition with: aRolledNumber [

	| newPosition |
	newPosition := aPosition add: aRolledNumber with: length.
	^ newPosition
]

{ #category : 'validation' }
Board >> validateSquaresWith: aMaximumRoll [

	distribution do: [ :aSquare |
		aSquare validateMagnitudeWith: aMaximumRoll and: length ]
]
