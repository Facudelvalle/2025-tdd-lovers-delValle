"
This class represent a probabilistic event
"
Class {
	#name : 'ProbabilisticEvent',
	#superclass : 'Object',
	#instVars : [
		'event',
		'probability'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ProbabilisticEvent class >> for: anEvent with: aProbability [

	^ self new initializeFor: anEvent with: aProbability
]

{ #category : 'accessing' }
ProbabilisticEvent >> event [

	^ event
]

{ #category : 'initialization' }
ProbabilisticEvent >> initializeFor: anEvent with: aProbability [

	event := anEvent.
	probability := aProbability
]

{ #category : 'accessing' }
ProbabilisticEvent >> probability [

	^ probability
]
