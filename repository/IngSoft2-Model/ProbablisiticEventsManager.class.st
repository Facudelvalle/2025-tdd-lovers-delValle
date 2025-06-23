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
ProbablisiticEventsManager >> buildFor: aLength [

	| generatedSquares |
	generatedSquares := (0 to: aLength - 1) collect: [ :aNumber |
		                    (probabilityEvents atRandomWeighting: [
			                     :aProbabilisticEvent |
			                     aProbabilisticEvent probability ]) event ].
	^ generatedSquares asOrderedCollection
]

{ #category : 'initialization' }
ProbablisiticEventsManager >> initialize [

	probabilityEvents := OrderedCollection new
]
