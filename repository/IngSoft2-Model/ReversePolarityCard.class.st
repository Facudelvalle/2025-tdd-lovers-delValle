"
This class represents a Reverse Polarity Card
"
Class {
	#name : 'ReversePolarityCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
ReversePolarityCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aGame invertSquareIn: anAffectedSquaresPosition
]

{ #category : 'playing' }
ReversePolarityCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		and: anAffectedSquaresPosition
		in: aGame.

	aPlayingShip remove: self
]

{ #category : 'comparing' }
ReversePolarityCard >> equalsCard: aCard [

	^ aCard isReversePolarityCard
]

{ #category : 'comparing' }
ReversePolarityCard >> isReversePolarityCard [

	^ true
]
