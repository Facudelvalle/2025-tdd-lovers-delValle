"
This class represents a distribution builder
"
Class {
	#name : 'ProbabilisiticEventsManager',
	#superclass : 'Object',
	#instVars : [
		'probabilityEvents'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
ProbabilisiticEventsManager >> add: anEvent [

	probabilityEvents add: anEvent
]

{ #category : 'building' }
ProbabilisiticEventsManager >> generateFor: aLength [

	| generatedEvents |
	generatedEvents := (0 to: aLength - 1) collect: [ :aNumber |
		                   (probabilityEvents atRandomWeighting: [
			                    :aProbabilisticEvent |
			                    aProbabilisticEvent probability ]) event ].
	^ generatedEvents asOrderedCollection
]

{ #category : 'building' }
ProbabilisiticEventsManager >> generateOne [

	^ (probabilityEvents atRandomWeighting: [ :aProbabilisticEvent |
		   aProbabilisticEvent probability ]) event
]

{ #category : 'initialization' }
ProbabilisiticEventsManager >> initialize [

	probabilityEvents := OrderedCollection new
]
