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

	| aBoard aBlueShip aBlackShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder expectedPosition aPlainSquare aProbability aPlainSquareProbabilisticEvent aDistribution oneLap someShips someDices aFuelQuantity aGame |
	twentySquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	expectedPosition := Position at: 10 in: 1.

	aWormHole := WormHole between: 2 and: 10.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aSetDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheEndOfAWormHoleThenItEndsUpAtTheBeginningOfIt [

	| aBoard twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDistribution expectedPosition aPlainSquare aProbability aPlainSquareProbabilisticEvent oneLap aBlueShip aBlackShip someShips someDices aFuelQuantity aGame |
	twentySquares := 20.
	sideToRoll := 5.
	oneLap := 1.

	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 2 and: 5.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aSetDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
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
