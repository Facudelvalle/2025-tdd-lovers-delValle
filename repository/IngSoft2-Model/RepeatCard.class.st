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
RepeatCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: aTargetShip in: aGame [

	[ aGame applyLastEffectTo: aTargetShip ]
		on: Error
		do: [ :anError |
			aTargetShip penalizeAndReturnTo: aTargetShip currentPosition ].
	aGame lastPlayedCard: self
]
