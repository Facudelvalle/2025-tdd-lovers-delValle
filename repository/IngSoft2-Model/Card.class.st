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

{ #category : 'testing' }
Card >> isAccelerationCard [

	^ false
]

{ #category : 'testing' }
Card >> isAllyCard [

	^ false
]

{ #category : 'testing' }
Card >> isCancellationCard [

	^ false
]

{ #category : 'testing' }
Card >> isOverloadCard [

	^ false
]

{ #category : 'testing' }
Card >> isRedoCard [

	^ false
]

{ #category : 'testing' }
Card >> isRepeatCard [

	^ false
]

{ #category : 'testing' }
Card >> isReversePolarityCard [

	^ false
]
