"
This class represents a black hole square
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
BlackHoleSquare >> applyOn: aShip and: aPosition in: aGame [

	^ aPosition goBackfourPlacesIn: aGame boardLength
]

{ #category : 'validation' }
BlackHoleSquare >> validateMagnitudeWith: aMagnitude and: aBoardLenght [

	^ true
]
