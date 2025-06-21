"
This class represents a black hole square
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
BlackHoleSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aGame goBackFourSquares: aShip from: aPosition
]
