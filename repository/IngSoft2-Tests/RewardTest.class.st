Class {
	#name : 'RewardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RewardTest >> testWhenAPlayerRolledTheMaximumRollThenItsRewardIsAnIncreseOfOneInItsMaxiumFuell [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedFuelLeft aDistributionManager aPlainSquare aProbability aPlainSquareProbabilisticEvent aDistribution aRewardManager plusOneReward plusOneRewardProbabilisticEvent aGameBuilder |
	fiveSquares := 5.
	sideToRoll := 1.

	expectedFuelLeft := 7.

	aWormHole := WormHole between: 0 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager buildFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	plusOneReward := MaximumFuelReward of: 1.

	plusOneRewardProbabilisticEvent := ProbabilisticEvent
		                                   for: plusOneReward
		                                   with: 1.

	aRewardManager add: plusOneRewardProbabilisticEvent.


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
	aGame := aGameBuilder build.

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
RewardTest >> testWhenAPlayerRolledTheMaximumRollThenItsRewardIsOneLessFuel [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedFuelLeft aDistributionManager aPlainSquare aProbability aPlainSquareProbabilisticEvent aDistribution aRewardManager plusOneReward plusOneRewardProbabilisticEvent aGameBuilder |
	fiveSquares := 5.
	sideToRoll := 1.

	expectedFuelLeft := 0.

	aWormHole := WormHole between: 0 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager buildFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	plusOneReward := FuelDecreaseReward of: -1.

	plusOneRewardProbabilisticEvent := ProbabilisticEvent
		                                   for: plusOneReward
		                                   with: 1.

	aRewardManager add: plusOneRewardProbabilisticEvent.


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
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]
