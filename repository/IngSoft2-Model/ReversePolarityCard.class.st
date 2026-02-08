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
	aGame invertSquareIn: anAffectedSquaresPosition.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
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

{ #category : 'cancelling' }
ReversePolarityCard >> cancelEffectIn: aGame on: aPosition [

	aGame invertSquareIn: aPosition
]

{ #category : 'comparing' }
ReversePolarityCard >> equalsCard: aCard [

	^ aCard isReversePolarityCard
]

{ #category : 'comparing' }
ReversePolarityCard >> isReversePolarityCard [

	^ true
]
