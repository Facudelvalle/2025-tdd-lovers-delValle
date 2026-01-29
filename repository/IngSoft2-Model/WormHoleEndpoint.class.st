"
This class represent a worm hole end point
"
Class {
	#name : 'WormHoleEndpoint',
	#superclass : 'Object',
	#instVars : [
		'position',
		'index',
		'state',
		'wormHole'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
WormHoleEndpoint class >> at: aPosition in: aWormHole [

	^ self new initializeAt: aPosition in: aWormHole
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
WormHoleEndpoint >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'effect' }
WormHoleEndpoint >> applyOn: aShip and: aPosition in: aGame [

	^ aPosition
]

{ #category : 'effect' }
WormHoleEndpoint >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'assignments' }
WormHoleEndpoint >> assignToPosition: aNumber [

]

{ #category : 'evaluating' }
WormHoleEndpoint >> in: aPosition [

	^ index = aPosition
]

{ #category : 'accessing' }
WormHoleEndpoint >> initializeAt: aPosition in: aWormHole [

	position := Position at: aPosition in: 1.
	index := aPosition + 1.
	wormHole := aWormHole.
	state := RegularState new
]

{ #category : 'transformations' }
WormHoleEndpoint >> invert [

	state := state invert
]

{ #category : 'effect' }
WormHoleEndpoint >> move: aShip to: aPosition in: aGame [

	^ state
		  applyEffectOf: self
		  on: aShip
		  and: aPosition
		  in: aGame
]

{ #category : 'accessing' }
WormHoleEndpoint >> position [

	^ position
]

{ #category : 'validation' }
WormHoleEndpoint >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	^ true
]
