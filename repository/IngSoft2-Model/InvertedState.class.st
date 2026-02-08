"
This class represents the inverted state of a square
"
Class {
	#name : 'InvertedState',
	#superclass : 'SquareState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
InvertedState >> applyEffectOf: aSquare on: aShip and: aPosition in: aGame [

	^ aSquare applyInvertedEffectOn: aShip and: aPosition in: aGame
]

{ #category : 'transformations' }
InvertedState >> invert [

	^ RegularState new
]
