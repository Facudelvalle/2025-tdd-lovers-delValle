"
This class represents a Null Card

"
Class {
	#name : 'NullCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
NullCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip in: aGame [

	Error signal:
		'A Redo card can not be played when there are no played cards yet.'
]
