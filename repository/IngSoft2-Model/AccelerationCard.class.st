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
AccelerationCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAfectedShip in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aGame applyRollPenalty: 1.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
]

{ #category : 'cancelling' }
AccelerationCard >> cancelEffectIn: aGame [

	aGame applyRollPenalty: -1
]
