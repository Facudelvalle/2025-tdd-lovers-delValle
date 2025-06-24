"
this class represents a cancellation card
"
Class {
	#name : 'CancellationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
CancellationCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame remove: anAffectedCard playedBy: anAffectedShip
]

{ #category : 'comparing' }
CancellationCard >> compare: aShip and: anotherShip [

	^ false
]
