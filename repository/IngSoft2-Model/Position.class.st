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
Position >> > aRaceGoal [

	^ aRaceGoal currentLap < lap
]

{ #category : 'adding' }
Position >> add: aRolledNumber with: aBoardLength [

	| squaresMoved lapsToAdd newSquare newLap |
	squaresMoved := square + aRolledNumber.

	lapsToAdd := squaresMoved // aBoardLength.

	newSquare := squaresMoved % aBoardLength.

	newLap := lap + lapsToAdd.

	newLap = 0 ifTrue: [
		newLap := 1.
		newSquare := 0 ].

	^ self class at: newSquare in: newLap
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
Position >> currentLap [

	^ lap
]

{ #category : 'comparing' }
Position >> currentSquare [

	^ square
]

{ #category : 'comparing' }
Position >> equals: aPosition [

	^(aPosition squareEquals: square) and: (aPosition lapsEquals: lap)
]

{ #category : 'adding' }
Position >> goBackFourSquaresIn: aBoardLength [
 
	^ self add: -4 with: aBoardLength
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

	^ aSquare = square
]

{ #category : 'comparing' }
Position >> squaresAwayFrom: aPosition with: aBoardLength [

	| squaresTraveled |
	squaresTraveled := ((aPosition currentLap - 1) * aBoardLength
	                    + aPosition currentSquare
	                    - ((lap - 1) * aBoardLength + square)) abs.
	^ squaresTraveled
]
