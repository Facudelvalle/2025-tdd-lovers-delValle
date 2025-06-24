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

	beginning := WormHoleEndpoint at: aBeginning.
	end := WormHoleEndpoint at: anEnd 
]

{ #category : 'comparing' }
WormHole >> moveIfEndPointAt: aPosition [


	(aPosition squareEquals: beginning) ifTrue: [^ aPosition adjustSquare: end position ].
	(aPosition squareEquals: end) ifTrue: [ ^ aPosition adjustSquare: beginning position ].

	^ aPosition
]

{ #category : 'accessing' }
WormHole >> replace: aSquare in: anIndex [

	(self hasEndingAt: anIndex) ifTrue: [ ^ end ].
	(self hasBeginningAt: anIndex) ifTrue: [ ^ beginning ].
	^ aSquare
]
