"
This class represents an overload Card
"
Class {
	#name : 'OverloadCard',
	#superclass : 'Card',
	#instVars : [
		'affectedShips'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
OverloadCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	anAffectedShip applyRollModifier: -2.
	affectedShips add: anAffectedShip.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
]

{ #category : 'playing' }
OverloadCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAffectedShip
		and: anAffectedSquaresPosition
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'cancelling' }
OverloadCard >> cancelEffectIn: aGame on: aPosition [

	affectedShips do: [ :aShip | aShip applyRollModifier: 2 ].
	affectedShips := OrderedCollection new
]

{ #category : 'comparing' }
OverloadCard >> compare: aShip and: anotherShip [

	^ false
]

{ #category : 'comparing' }
OverloadCard >> equalsCard: aCard [

	^ aCard isOverloadCard
]

{ #category : 'initialization' }
OverloadCard >> initialize [

	affectedShips := OrderedCollection new
]

{ #category : 'comparing' }
OverloadCard >> isOverloadCard [

	^ true
]
