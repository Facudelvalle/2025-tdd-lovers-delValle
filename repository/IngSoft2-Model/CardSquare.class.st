"
This Class represents a Card Square

"
Class {
	#name : 'CardSquare',
	#superclass : 'Square',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effect' }
CardSquare >> applyInvertedEffectOn: aShip and: aPosition in: aGame [

	aGame giveAnotherCardToAllOtherShips.
	^ aPosition
]

{ #category : 'effect' }
CardSquare >> applyRegularEffectOn: aShip and: aPosition in: aGame [

	aShip addCards: (aGame generateCard).
	^ aPosition.
]
