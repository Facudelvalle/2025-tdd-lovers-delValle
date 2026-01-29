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
RepeatCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	aGame applyLastEffectTo: anAffectedShip.
	aGame lastPlayedCard: self
]

{ #category : 'playing' }
RepeatCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		and: anAffectedSquaresPosition
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'comparing' }
RepeatCard >> compare: aShip and: anotherShip [

	^ false
]

{ #category : 'comparing' }
RepeatCard >> equalsCard: aCard [

	^ aCard isRepeatCard
]

{ #category : 'comparing' }
RepeatCard >> isRepeatCard [

	^ true
]
