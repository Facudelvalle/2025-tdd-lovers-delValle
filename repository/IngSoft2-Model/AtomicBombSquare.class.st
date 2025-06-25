"
This class represents an atomic bomb square
"
Class {
	#name : 'AtomicBombSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
AtomicBombSquare >> applyOn: aShip and: aPosition in: aGame [ 
	
	| shipNewPosition squaresTraveled |
	aGame moveShipsToSquareZero.
	shipNewPosition := aPosition adjustSquare: 0.
	squaresTraveled := aGame calculateDistanceBetween: aPosition and: shipNewPosition.
	aShip addFuel: squaresTraveled. 
	^ shipNewPosition 
]

{ #category : 'effect' }
AtomicBombSquare >> repeatEffectFor: aShip on: aPosition in: aGame [

	| shipNewPosition squaresTraveled |
	shipNewPosition := aPosition adjustSquare: 0.
	squaresTraveled := aGame
		                   calculateDistanceBetween: aPosition
		                   and: shipNewPosition.
	aShip addFuel: squaresTraveled.
	^ shipNewPosition
]
