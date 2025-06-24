"
This class represents a set probabilistic events manager
"
Class {
	#name : 'SetProbablisiticEventsManager',
	#superclass : 'Object',
	#instVars : [
		'probabilityEvents'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'adding' }
SetProbablisiticEventsManager >> add: anEvent [

	probabilityEvents add: anEvent
]

{ #category : 'building' }
SetProbablisiticEventsManager >> generateFor: aLength [

	| generatedEvents generatedEvent |
	generatedEvents := OrderedCollection new.
	0 to: aLength - 1 do: [ :anIteration |
		generatedEvent := probabilityEvents removeFirst.
		generatedEvents add: generatedEvent event.
		probabilityEvents add: generatedEvent ].
	^ generatedEvents
]

{ #category : 'initialization' }
SetProbablisiticEventsManager >> initialize [

	probabilityEvents := OrderedCollection new
]
