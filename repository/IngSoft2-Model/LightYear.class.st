"
This class represent a Distance in Light Years
"
Class {
	#name : 'LightYear',
	#superclass : 'Unit',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'convertion' }
LightYear >> toParsec [

	^ measureOfDistance / 3
]
