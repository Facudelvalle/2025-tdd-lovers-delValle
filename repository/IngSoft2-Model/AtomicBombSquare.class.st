"
This class represents an atomic bomb square
"
Class {
	#name : 'AtomicBombSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
AtomicBombSquare >> applyOn: aShip and: aPosition in: aGame [ 
	
	| shipNewPosition squaresTraveled |
	aGame moveShipsToSquareCero.
	shipNewPosition := aPosition adjustSquare: 0.
	squaresTraveled := shipNewPosition squaresAwayFrom: aPosition with: aGame boardLength.
	aShip fuel: squaresTraveled + aShip fuelLeft. 
	^ shipNewPosition 
]

{ #category : 'validation' }
AtomicBombSquare >> validateMagnitudeWith: aMagnitude and: aBoardLrngth [ 
	
	^ true.
]
