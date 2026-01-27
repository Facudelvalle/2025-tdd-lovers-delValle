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
ReversePolarityCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAllyShip in: aGame [

	aGame validateNextPlayer: aPlayingShip
]

{ #category : 'playing' }
ReversePolarityCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		in: aGame.
	aPlayingShip remove: self
]
