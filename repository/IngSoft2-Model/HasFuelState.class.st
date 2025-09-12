"
This class represents a fuel state
"
Class {
	#name : 'HasFuelState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'penalty' }
HasFuelState >> applyPenaltyTo: aShip thatStartedFrom: aPosition [
]

{ #category : 'borrowing' }
HasFuelState >> borrowBy: aShip [
]

{ #category : 'updating' }
HasFuelState >> updateFor: amount [

	amount < 0 ifTrue: [ ^ DoesntHaveFuelState new ]
	
		
	
]
