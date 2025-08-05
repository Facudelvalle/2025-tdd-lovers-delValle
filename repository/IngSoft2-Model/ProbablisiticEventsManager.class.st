"
This class represents a distribution builder
"
Class {
	#name : 'ProbablisiticEventsManager',
	#superclass : 'Object',
	#instVars : [
		'probabilityEvents'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'adding' }
ProbablisiticEventsManager >> add: anEvent [

	probabilityEvents add: anEvent
]

{ #category : 'building' }
ProbablisiticEventsManager >> generateFor: aLength [

	| generatedEvents |
	generatedEvents := (0 to: aLength - 1) collect: [ :aNumber |
		                    (probabilityEvents atRandomWeighting: [
			                     :aProbabilisticEvent |
			                     aProbabilisticEvent probability ]) event ].
	^ generatedEvents asOrderedCollection
]

{ #category : 'building' }
ProbablisiticEventsManager >> generateOne [

	^ (probabilityEvents atRandomWeighting:
		  [ :aProbabilisticEvent | aProbabilisticEvent probability ]) event
]

{ #category : 'initialization' }
ProbablisiticEventsManager >> initialize [

	probabilityEvents := OrderedCollection new
]
