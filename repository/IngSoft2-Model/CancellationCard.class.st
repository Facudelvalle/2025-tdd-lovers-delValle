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
CancellationCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame remove: anAffectedCard playedBy: anAffectedShip.
	aGame lastPlayedCard: self
]

{ #category : 'playing' }
CancellationCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	self applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame.
	aPlayingShip remove: self
]

{ #category : 'comparing' }
CancellationCard >> compare: aShip and: anotherShip [

	^ false
]
