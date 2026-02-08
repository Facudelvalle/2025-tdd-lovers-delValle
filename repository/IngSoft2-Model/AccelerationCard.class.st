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
AccelerationCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aGame applyRollModifier: 1.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
]

{ #category : 'playing' }
AccelerationCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		and: anAffectedSquaresPosition
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'cancelling' }
AccelerationCard >> cancelEffectIn: aGame on: aPosition [

	aGame applyRollModifier: -1
]

{ #category : 'comparing' }
AccelerationCard >> compare: firstAlly and: secondAlly [

	^ false
]

{ #category : 'comparing' }
AccelerationCard >> equalsCard: aCard [

	^ aCard isAccelerationCard
]

{ #category : 'comparing' }
AccelerationCard >> isAccelerationCard [

	^ true
]
