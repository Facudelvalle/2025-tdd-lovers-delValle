"
This class represents a null ship
"
Class {
	#name : 'NullShip',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'update' }
NullShip >> consumeFuelByAlly: squaresTraveled [

	Error signal: 'Ship does not have enough fuel to move.'
]

{ #category : 'update' }
NullShip >> losesTwoTurns [

	
]

{ #category : 'accessing' }
NullShip >> name [

	^ 'There is not a winner yet'
]

{ #category : 'accessing' }
NullShip >> restoreFuel [

	
]
