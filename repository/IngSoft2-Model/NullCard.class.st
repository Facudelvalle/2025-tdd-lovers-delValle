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
NullCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	Error signal:
		'A Redo card can not be played when there are no played cards yet.'
]

{ #category : 'playing' }
NullCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [
	"This method is never reached but we consider its presence necessary because of the inherentance design."

	
]

{ #category : 'comparing' }
NullCard >> equalsCard: aCard [
	"This method is never reached but I consider its presence necessary because of the inheretance design."

	
]
