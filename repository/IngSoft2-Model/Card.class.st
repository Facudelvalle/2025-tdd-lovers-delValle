"
this class represents a card
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'comparing' }
Card >> = aCard [

	^ aCard equalsCard: self
]

{ #category : 'playing' }
Card >> applyEffectPlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'playing' }
Card >> bePlayedBy: aPlayingShip affecting: anAffectedCard and: anAffectedShip and: anAffectedSquaresPosition in: aGame [

	self subclassResponsibility
]

{ #category : 'comparing' }
Card >> equalsCard: aCard [

	self subclassResponsibility
]

{ #category : 'comparing' }
Card >> isAccelerationCard [

	^ false
]

{ #category : 'comparing' }
Card >> isAllyCard [

	^ false
]

{ #category : 'comparing' }
Card >> isCancellationCard [

	^ false
]

{ #category : 'comparing' }
Card >> isOverloadCard [

	^ false
]

{ #category : 'comparing' }
Card >> isRedoCard [

	^ false
]

{ #category : 'comparing' }
Card >> isRepeatCard [

	^ false
]

{ #category : 'comparing' }
Card >> isReversePolarityCard [

	^ false
]
