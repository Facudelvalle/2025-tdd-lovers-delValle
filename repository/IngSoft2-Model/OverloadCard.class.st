"
This class represents an overload Card
"
Class {
	#name : 'OverloadCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
OverloadCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: aTargetShip in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aTargetShip applyRollPenalty: -2.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
]

{ #category : 'cancelling' }
OverloadCard >> cancelEffectIn: aGame [

	aGame applyRollPenalty: 2
]
