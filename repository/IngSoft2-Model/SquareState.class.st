"
This class represents the state of a square
"
Class {
	#name : 'SquareState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
SquareState >> applyEffectOf: aSquare on: aShip and: aPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'transformations' }
SquareState >> invert [

	self subclassResponsibility
]
