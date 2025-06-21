Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesOneMoveOfTwoSquaresThenItsPositionIsTwo [

	| aBoard aBlueShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDistribution expectedPosition someShips someDices aFuelQuantity oneLap aGame aPlainSquare aProbability aPlainSquareProbabilisticEvent aBlackShip |
	twentySquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 3 and: 10.
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
ShipTest >> testWhenAShipMakesTwoMovesOfOneSquareThenItsPositionIsTwo [

	| aBoard twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder expectedPosition oneLap aBlueShip aBlackShip aPlainSquare aProbability aPlainSquareProbabilisticEvent aDistribution someShips someDices aFuelQuantity aGame |
	twentySquares := 20.
	sideToRoll := 1.
	oneLap := 1.

	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 3 and: 10.
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
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesOneSquareThenItsPositionIsOne [

	| aBoard twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder expectedPosition aBlueShip aBlackShip aPlainSquare aProbability aPlainSquareProbabilisticEvent aDistribution someShips someDices aFuelQuantity aGame oneLap |
	twentySquares := 20.
	sideToRoll := 1.
	oneLap := 1.

	expectedPosition := Position at: 1 in: 1.

	aWormHole := WormHole between: 3 and: 10.
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
