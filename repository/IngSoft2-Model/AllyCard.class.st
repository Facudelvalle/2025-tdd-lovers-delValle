"
This Class Represents an All Card
"
Class {
	#name : 'AllyCard',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'playing' }
AllyCard >> bePlayedBy: aPlayingShip for: anAllyShip in: aGame [

	aGame validateNextPlayer: aPlayingShip.
	aPlayingShip remove: self.
	aPlayingShip formAllianceWith: anAllyShip.
	anAllyShip formAllianceWith: aPlayingShip
]
