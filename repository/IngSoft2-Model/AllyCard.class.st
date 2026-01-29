"
This Class Represents an All Card
"
Class {
	#name : 'AllyCard',
	#superclass : 'Card',
	#instVars : [
		'allyOne',
		'allyTwo'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
AllyCard >> = aCard [

	^ aCard compare: allyOne and: allyTwo
]

{ #category : 'playing' }
AllyCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAllyShip and: anAffectedSquaresPosition in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aPlayingShip formAllianceWith: anAllyShip.
	anAllyShip formAllianceWith: aPlayingShip.
	allyOne := aPlayingShip.
	allyTwo := anAllyShip.
	aGame lastPlayedCard: self.
	aGame addActiveCard: self
]

{ #category : 'playing' }
AllyCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAllyShip and: anAffectedSquaresPosition in: aGame [

	self
		applyEffectPlayedBy: aPlayingShip
		affecting: anAffectedCard
		and: anAllyShip
		and: anAffectedSquaresPosition
		in: aGame.
	aPlayingShip remove: self
]

{ #category : 'cancelling' }
AllyCard >> cancelEffectIn: aGame [

	allyOne removeAlly: allyTwo.
	allyTwo removeAlly: allyOne.
	allyOne := NullShip new.
	allyTwo := NullShip new
]

{ #category : 'comparing' }
AllyCard >> compare: firstAlly and: secondAlly [

	^ (firstAlly equals: allyOne) and: (secondAlly equals: allyTwo)
]

{ #category : 'comparing' }
AllyCard >> equalsCard: aCard [

	^ aCard isAllyCard
]

{ #category : 'initialization' }
AllyCard >> initialize [

	allyOne := NullShip new.
	allyTwo := NullShip new
]

{ #category : 'comparing' }
AllyCard >> isAllyCard [ 

	^ true
]
