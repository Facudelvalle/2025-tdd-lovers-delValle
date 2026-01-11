"
This class represent an acceleration card
"
Class {
	#name : 'AccelerationCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AccelerationCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aGame applyRollModifier: 1.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
]

{ #category : 'playing' }
AccelerationCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'cancelling' }
AccelerationCard >> cancelEffectIn: aGame [

	aGame applyRollModifier: -1
]

{ #category : 'comparing' }
AccelerationCard >> compare: firstAlly and: secondAlly [

	^ false
]
