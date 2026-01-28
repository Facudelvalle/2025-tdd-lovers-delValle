"
This class represents an inverted atomic bomb square
"
Class {
	#name : 'InvertedAtomicBombSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'evaluating' }
InvertedAtomicBombSquare class >> in: aPosition [

	^ self new initializeIn: aPosition
]

{ #category : 'effect' }
InvertedAtomicBombSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aPosition
]

{ #category : 'initialization' }
InvertedAtomicBombSquare >> initializeIn: aPosition [

	position := aPosition
]
