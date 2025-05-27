"
This class represents a black hole square
"
Class {
	#name : 'BlackHoleSquare',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BlackHoleSquare >> applyOn: aShip and: aPosition [ 
	^ aPosition goBackfourPlaces
]

{ #category : 'as yet unclassified' }
BlackHoleSquare >> assigned: someDices [ 
]
