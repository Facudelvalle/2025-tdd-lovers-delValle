Class {
	#name : 'RepeatCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
RepeatCard >> bePlayedBy: aPlayingShip for: aTargetShip in: aGame [

	[ aGame applyLastEffectTo: aTargetShip ]
		on: Error
		do: [ :anError |
			aTargetShip penalizeAndReturnTo: aTargetShip currentPosition ]
]
