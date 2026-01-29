"
This is the representation of a black hole.
"
Class {
	#name : 'WormHole',
	#superclass : 'Object',
	#instVars : [
		'beginning',
		'end'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'validation' }
WormHole class >> beginning: aBeginning cannotBeLargerThan: anEnd [

	aBeginning > anEnd ifTrue: [
		Error signal:
			'A Worm Hole cannot be created with the beginning larger than the ending' ]
]

{ #category : 'creation' }
WormHole class >> between: aBeginning and: anEnd [

	self cannotBeginInANegative: aBeginning.
	self cannotEndInANegative: anEnd.
	self beginning: aBeginning cannotBeLargerThan: anEnd.
	^ self new initializeBetween: aBeginning and: anEnd
]

{ #category : 'validation' }
WormHole class >> cannotBeginInANegative: anEnd [

	anEnd < 0 ifTrue: [
		Error signal: 'A Worm Hole cannot begin in a negative square' ]
]

{ #category : 'validation' }
WormHole class >> cannotEndInANegative: anEnd [

	anEnd <= 0 ifTrue: [
		Error signal: 'A Worm Hole cannot end in a negative square' ]
]

{ #category : 'as yet unclassified' }
WormHole >> applyBeginningInvertedEffectOn: aPosition in: aGame [

	^ aPosition
]

{ #category : 'as yet unclassified' }
WormHole >> applyBeginningRegularEffectOn: aPosition [

	^ aPosition adjustSquare: end position currentSquare
]

{ #category : 'as yet unclassified' }
WormHole >> applyEndInvertedEffectOn: aPosition in: aGame [

	^ aPosition
]

{ #category : 'as yet unclassified' }
WormHole >> applyEndRegularEffectOn: aPosition [

	^ aPosition adjustSquare: beginning position currentSquare
]

{ #category : 'validation' }
WormHole >> endsBefore: aLength [

	end > aLength ifTrue: [
		Error signal:
			'A Board cannot end before the ending of its Worm Hole' ]
]

{ #category : 'validation' }
WormHole >> fallsInto: aLength [

	beginning > aLength ifTrue: [
		Error signal:
			'A Worm Hole cannot fall outside of its Boards length' ]
]

{ #category : 'accessing' }
WormHole >> hasBeginningAt: aSquare [

	^ beginning in: aSquare 
]

{ #category : 'accessing' }
WormHole >> hasEndingAt: aSquare [

	^ end in: aSquare 
]

{ #category : 'initialization' }
WormHole >> initializeBetween: aBeginning and: anEnd [

	beginning := WormHoleBeginning at: aBeginning in: self.
	end := WormHoleEnd at: anEnd in: self
]

{ #category : 'comparing' }
WormHole >> move: aShip ifEndPointAt: aPosition in: aGame [

	(aPosition squareEquals: beginning position currentSquare) ifTrue: [
		^ beginning move: aShip to: aPosition in: aGame ].

	(aPosition squareEquals: end position currentSquare) ifTrue: [
		^ end move: aShip to: aPosition in: aGame ].

	^ aPosition
]

{ #category : 'accessing' }
WormHole >> replace: aSquare in: anIndex [

	(self hasEndingAt: anIndex) ifTrue: [ ^ end ].
	(self hasBeginningAt: anIndex) ifTrue: [ ^ beginning ].
	^ aSquare
]
