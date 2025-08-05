"
This class represent a unit of distance.
"
Class {
	#name : 'Unit',
	#superclass : 'Object',
	#instVars : [
		'measureOfDistance'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Unit class >> with: aMeasureOfDistance [


	^ self new initializeWith: aMeasureOfDistance 
]

{ #category : 'comparing' }
Unit >> > aUnitDistance [

	^ measureOfDistance > aUnitDistance measureOfDistance
]

{ #category : 'initialization' }
Unit >> initializeWith: aMeasureOfDistance [

	measureOfDistance := aMeasureOfDistance
]

{ #category : 'accessing' }
Unit >> measureOfDistance [

	^ measureOfDistance
]

{ #category : 'convertion' }
Unit >> toParsec [

	self subclassResponsibility
]
