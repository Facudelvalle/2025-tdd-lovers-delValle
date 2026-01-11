Class {
	#name : 'ShipFuelTest',
	#superclass : 'TestCase',
	#instVars : [
		'tenSquares',
		'sideToRoll',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aLoadedDice',
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
		'someDices',
		'aGameBuilder',
		'aGame'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ShipFuelTest >> setUp [
	super setUp.

	tenSquares := 10.
	sideToRoll := #(1) asOrderedCollection.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
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
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipDecideToPassThenItsFuellsToppedUp [

	| expectedFuelLeft |
	expectedFuelLeft := Fuel with: 2 upTo: 2 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipIsNoLongerPenalisedThenItsFuelIsToppedUp [

	| expectedFuelLeft |
	expectedFuelLeft := Fuel with: 2 upTo: 2 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesAfterPassItsTurnMovesAccordingly [

	| expectedPosition |
	expectedPosition := Position at: 3 in: 1.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesOneSquareThenItsFuelDecreasesAccordingly [

	| expectedFuelLeft |
	expectedFuelLeft := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesThroughAWormHoleThenItsFuelDecreasesAccordingly [

	| expectedFuelLeft |
	expectedFuelLeft := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipTriesToMoveMoreSquaresThanItsRemainingFuelThenItDoesNotMove [

	| expectedPosition |
	expectedPosition := Position at: 2 in: 1.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipTriesToMoveMoreSquaresThanItsRemainingFuelThenLosesTwoTurns [

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aBlueShip hasAFuelPenalty
]
