"
This Class represents an inverted Card Square
"
Class {
	#name : 'InvertedCardSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
InvertedCardSquare class >> in: aPosition [

	^ self new initializeIn: aPosition
]

{ #category : 'effect' }
InvertedCardSquare >> applyOn: aShip and: aPosition in: aGame [

	aGame giveAnotherCardToAllOtherShips.
	^ aPosition
]

{ #category : 'initialization' }
InvertedCardSquare >> initializeIn: aPosition [

	position := aPosition
]
