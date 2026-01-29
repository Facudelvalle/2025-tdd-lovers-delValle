"
This class represents the regular state of a square
"
Class {
	#name : 'RegularState',
	#superclass : 'SquareState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
RegularState >> applyEffectOf: aSquare on: aShip and: aPosition in: aGame [

	^ aSquare applyRegularEffectOn: aShip and: aPosition in: aGame
]

{ #category : 'transformations' }
RegularState >> invert [

	^ InvertedState new
]
