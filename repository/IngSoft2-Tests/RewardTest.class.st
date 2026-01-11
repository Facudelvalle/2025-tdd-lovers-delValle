Class {
	#name : 'RewardTest',
	#superclass : 'TestCase',
	#instVars : [
		'fiveSquares',
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
RewardTest >> setUp [

	super setUp.

	fiveSquares := 5.
	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 0 and: 3.
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
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
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

	aGameBuilder setAvailableCards: aCardManager
]

{ #category : 'tests' }
RewardTest >> testWhenAPlayerRolledTheMaximumRollThenItsRewardIsAnIncreseOfOneInItsMaxiumFuell [

	| expectedFuelLeft aRewardManager plusOneReward plusOneRewardProbabilisticEvent aGame |
	expectedFuelLeft := Fuel with: 3 upTo: 3 in: HasFuelState new.
	
	aRewardManager := ProbablisiticEventsManager new.
	plusOneReward := MaximumFuelReward of: 1.

	plusOneRewardProbabilisticEvent := ProbabilisticEvent
		                                   for: plusOneReward
		                                   with: aProbabilityOfOne.
	aRewardManager add: plusOneRewardProbabilisticEvent.
	
	aGameBuilder setRewards: aRewardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
RewardTest >> testWhenAPlayerRolledTheMaximumRollThenItsRewardIsOneLessFuel [

	| expectedFuelLeft aRewardManager minusOneReward minusOneRewardProbabilisticEvent aGame |
	expectedFuelLeft := Fuel with: 0 upTo: 2 in: HasFuelState new.

	aRewardManager := ProbablisiticEventsManager new.
	minusOneReward := FuelDecreaseReward of: -1.

	minusOneRewardProbabilisticEvent := ProbabilisticEvent
		                                   for: minusOneReward
		                                   with: aProbabilityOfOne.
	aRewardManager add: minusOneRewardProbabilisticEvent.

	aGameBuilder setRewards: aRewardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]
