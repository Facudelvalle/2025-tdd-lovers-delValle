"
This class represents a Redo Card
"
Class {
	#name : 'RedoCard',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
RedoCard >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [
	"This method is never reached but we consider its presence necessary because of the inherentance design."

	
]

{ #category : 'playing' }
RedoCard >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: aTargetShip and: anAffectedSquaresPosition in: aGame [

	aGame
		playLastCardBy: aPlayingShip
		affecting: anAffectedCard
		and: aTargetShip
		and: anAffectedSquaresPosition.
	aPlayingShip remove: self
]

{ #category : 'comparing' }
RedoCard >> compare: aShip and: anotherShip [

	^ false
]

{ #category : 'comparing' }
RedoCard >> equalsCard: aCard [

	^ aCard isRedoCard
]

{ #category : 'comparing' }
RedoCard >> isRedoCard [

	^ true
]
