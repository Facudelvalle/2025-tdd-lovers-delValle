Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'aDistribution',
		'aBoard',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'aGame'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ShipTest >> setUp [
	super setUp.
	twentySquares := 20.

	aWormHole := WormHole between: 3 and: 10.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesOneMoveOfTwoSquaresThenItsPositionIsTwo [

	| sideToRoll aSetDice expectedPosition someDices |
	sideToRoll := #( 2 ) asOrderedCollection.
	aSetDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aSetDice.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 2 in: 1.

	aGame nextTurnPlay.
	
	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesTwoMovesOfOneSquareThenItsPositionIsTwo [

	| sideToRoll aSetDice expectedPosition someDices |
	sideToRoll := #( 1 ) asOrderedCollection.
	aSetDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aSetDice.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 2 in: 1.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesOneSquareThenItsPositionIsOne [

	| sideToRoll aSetDice expectedPosition someDices |
	sideToRoll := #( 1 ) asOrderedCollection.
	aSetDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aSetDice.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 1 in: 1.

	aGame nextTurnPlay.
	
	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
