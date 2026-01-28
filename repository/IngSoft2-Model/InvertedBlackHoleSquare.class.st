"
This class represents an inverted black hole square
"
Class {
	#name : 'InvertedBlackHoleSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
InvertedBlackHoleSquare class >> in: aPosition [

	^ self new initializeIn: aPosition
]

{ #category : 'effect' }
InvertedBlackHoleSquare >> applyOn: aShip and: aPosition in: aGame [

	aGame moveAllOtherShipsBackFourSquares.
	^ aPosition
]

{ #category : 'initialization' }
InvertedBlackHoleSquare >> initializeIn: aPosition [

	position := aPosition
]
