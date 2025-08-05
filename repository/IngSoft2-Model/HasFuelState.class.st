"
This class represents a fuel state
"
Class {
	#name : 'HasFuelState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HasFuelState >> applyPenaltyTo: aShip thatStartedFrom: aPosition [
]

{ #category : 'as yet unclassified' }
HasFuelState >> updateFor: amount [

	amount < 0 ifTrue: [ ^ DoesntHaveFuelState new ]
	
		
	
]
