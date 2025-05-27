"
This class represent a Position in the game
"
Class {
	#name : 'Position',
	#superclass : 'Object',
	#instVars : [
		'square',
		'lap'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
Position class >> at: aSquare in: aLap [

	^ self new initializeAt: aSquare in: aLap
]

{ #category : 'comparing' }
Position >> actualLap [

	^ lap
]

{ #category : 'adding' }
Position >> add: aRolledNumber with: aBoardLength [

	| squaresMoved lapsToAdd newSquare newLap |
	squaresMoved := square + aRolledNumber.

	lapsToAdd := squaresMoved // aBoardLength.

	newSquare := squaresMoved % aBoardLength.
	
	newLap := lap + lapsToAdd.
	
	^ self class at: newSquare in: newLap.
]

{ #category : 'adding' }
Position >> addSquare: someSquares [

	| newSquare |
	newSquare := square + someSquares.
	
	^ self class at: newSquare in: lap
]

{ #category : 'adding' }
Position >> adjustSquare: aSquare [

	^ self class at: aSquare in: lap
]

{ #category : 'converting' }
Position >> asString [

	^ 'Lap: ' , lap asString , ' ' , 'Square: ' , square asString
]

{ #category : 'comparing' }
Position >> currentSquare [

	^ square
]

{ #category : 'comparing' }
Position >> equals: aPosition [

	^(aPosition squareEquals: square) and: (aPosition lapsEquals: lap)
]

{ #category : 'converting' }
Position >> goBackfourPlaces [

	| newSquare newLap |
	newSquare := square - 4.
	newLap := lap - 1.
	
	lap = 1
		ifTrue: [
			newLap := 1.
			square - 4 < 0 ifTrue: [ newSquare := 0 ] ]
		ifFalse: [
			square - 4 < 0 ifTrue: [ newSquare := 4 - square ] ].

	^ self class at: newSquare in: newLap
]

{ #category : 'testing' }
Position >> hasCompleted: someLaps [

	^ someLaps < lap
]

{ #category : 'initialization' }
Position >> initializeAt: aSquare in: aLap [

	square := aSquare.
	lap := aLap
]

{ #category : 'comparing' }
Position >> lapsEquals: aLap [

	^ lap = aLap
]

{ #category : 'comparing' }
Position >> squareEquals: aSquare [

	^ square = aSquare
]

{ #category : 'comparing' }
Position >> squaresAwayFrom: aPosition with: aBoardLength [

	| squaresTraveled |
	squaresTraveled := ((aPosition actualLap - 1) * aBoardLength
	                    + aPosition currentSquare
	                    - ((lap - 1) * aBoardLength + square)) abs.
	^ squaresTraveled
]
