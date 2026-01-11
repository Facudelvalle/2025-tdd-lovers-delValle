"
This class represents a Repeat Card
"
Class {
	#name : 'RepeatCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
RepeatCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame applyLastEffectTo: anAffectedShip.
	aGame lastPlayedCard: self
]

{ #category : 'playing' }
RepeatCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'comparing' }
RepeatCard >> compare: aShip and: anotherShip [

	^ false
]
