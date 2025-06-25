"
This class represents a reward
"
Class {
	#name : 'Reward',
	#superclass : 'Object',
	#instVars : [
		'magnitude'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'creation' }
Reward class >> of: aMagnitude [ 
	^ self subclassResponsibility
]

{ #category : 'operations' }
Reward >> applyTo: aShip [

	self subclassResponsibility.
]

{ #category : 'initializacion' }
Reward >> initializeOf: aMagnitude [ 
	^ self subclassResponsibility
]
