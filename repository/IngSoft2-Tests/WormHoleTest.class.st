Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
WormHoleTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheBeginningOfAWormHoleThenItEndsUpAtTheEndOfIt [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDefaultDistribution expectedPosition |
	twentySquares := 20.
	sideToRoll := 2.
	
	expectedPosition := 10.
	
	aWormHole := WormHole between: 2 and: 10.
	aShip := Ship called: 'BlueShip'.
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.

	
	aShip move: aSetDice roll.
	aShip moveTo: (aBoard moveIfWormHoleAt: aShip currentPosition).
	
	self assert: aShip currentSquare equals: expectedPosition
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheEndOfAWormHoleThenItEndsUpAtTheBeginningOfIt [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDefaultDistribution expectedPosition |
	twentySquares := 20.
	sideToRoll := 5.
	
	expectedPosition := 2.
	
	aWormHole := WormHole between: 2 and: 5.
	aShip := Ship called: 'BlueShip'.
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.

	
	aShip move: aSetDice roll.
	aShip moveTo: (aBoard moveIfWormHoleAt: aShip currentPosition).
	
	self assert: aShip currentSquare equals: expectedPosition
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithNegativeBeginningThenInvalid [

	self
		should: [ WormHole between: -2 and: 5 ]
		raise: Error
		withMessageText: 'A Worm Hole cannot begin in a negative square'
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithNegativeEndThenInvalid [

	self
		should: [ WormHole between: 2 and: -5 ]
		raise: Error
		withMessageText: 'A Worm Hole cannot end in a negative square'
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithTheBeginningLargerThanTheEndingThenInvalid [

	self
		should: [ WormHole between: 10 and: 5 ]
		raise: Error
		withMessageText:
		'A Worm Hole cannot be created with the beginning larger than the ending'
]
