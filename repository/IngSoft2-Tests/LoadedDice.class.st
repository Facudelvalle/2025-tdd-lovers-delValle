"
""This Class represents a Dice set to always roll a certain Side""
"
Class {
	#name : 'LoadedDice',
	#superclass : 'Object',
	#instVars : [
		'loadedSides'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'creation' }
LoadedDice class >> toRoll: someSide [

	^ self new initializeToRoll: someSide
]

{ #category : 'initialization' }
LoadedDice >> initializeToRoll: someSide [

	loadedSides := someSide.
]

{ #category : 'functions' }
LoadedDice >> roll [

	| sideRolled |
	sideRolled := loadedSides first.
	loadedSides removeFirst.
	loadedSides add: sideRolled.
	^ sideRolled.
	
]

{ #category : 'functions' }
LoadedDice >> rollMaximum [

	^ loadedSides max.
]
