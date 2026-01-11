Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#instVars : [
		'tenSquares',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aBlackHoleSquare',
		'aProbabilityOfOne',
		'aBlackHoleProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BlackHoleTest >> setUp [

	super setUp.

	tenSquares := 10.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	aBlackHoleProbabilisticEvent := ProbabilisticEvent
		                                for: aBlackHoleSquare
		                                with: aProbabilityOfOne.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	aGameBuilder := GameBuilder new
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndDoesNotHaveEnoughFuelThenItGoesBackToItsInitialPosition [

	| aDistribution sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 7 in: 1.

	aWormHole := WormHole between: 2 and: 7.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aBlackHoleProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndHasEnoughFuelThenItGoesBackFourSquares [

	| aDistribution sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #(4) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aBlackHoleProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfALapThenItGoesBackALapAndToTheAccordingSquare [

	| aDistribution sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #(4) asOrderedCollection.

	expectedPosition := Position at: 9 in: 1.

	aWormHole := WormHole between: 4 and: 9.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aBlackHoleProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfTheFirstLapItStaysOnTheFirstLap [

	| aDistribution sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aBlackHoleProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
