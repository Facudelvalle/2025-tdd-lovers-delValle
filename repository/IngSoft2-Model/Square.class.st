"
This class represent a square
"
Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'position',
		'state'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Square >> = aSquare [

	^ self class = aSquare class
]

{ #category : 'effect' }
Square >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'effect' }
Square >> applyOn: aShip and: aPosition in: aGame [

	^ state
		  applyEffectOf: self
		  on: aShip
		  and: aPosition
		  in: aGame
]

{ #category : 'effect' }
Square >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'assignments' }
Square >> assignToPosition: aNumber [

	position := Position at: aNumber in: 1
]

{ #category : 'initialization' }
Square >> initialize [

	state := RegularState new
]

{ #category : 'transformations' }
Square >> invert [

	state := state invert
]

{ #category : 'effect' }
Square >> repeatEffectFor: aShip on: aPosition in: aGame [

	^ self applyOn: aShip and: aPosition in: aGame
]

{ #category : 'validation' }
Square >> validateMagnitudeWith: aMaximumRoll and: aBoardLenght [

	^ true
]
