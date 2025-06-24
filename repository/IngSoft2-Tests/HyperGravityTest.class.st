Class {
	#name : 'HyperGravityTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItDoesNotMove [

	| aDistribution tenSquares sideToRoll expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager aSetHyperGravitySquare aProbabilityOfOne aSetHyperGravitySquareProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 1.

	expectedPosition := Position at: 1 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aSetHyperGravitySquare := SetHyperGravitySquare with: 2.
	aProbabilityOfOne := 1.
	aSetHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                            for:
		                                            aSetHyperGravitySquare
		                                            with: aProbabilityOfOne.
	aDistributionManager add: aSetHyperGravitySquareProbabilisticEvent.
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

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItsFuelDoesNotChange [

	| aDistribution tenSquares sideToRoll expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager aSetHyperGravitySquare aProbabilityOfOne aSetHyperGravitySquareProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 1.

	expectedFuel := 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aSetHyperGravitySquare := SetHyperGravitySquare with: 2.
	aProbabilityOfOne := 1.
	aSetHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                            for:
		                                            aSetHyperGravitySquare
		                                            with: aProbabilityOfOne.
	aDistributionManager add: aSetHyperGravitySquareProbabilisticEvent.
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

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRolledTheNecesaryNumberThenItCanMove [

	| aDistribution tenSquares sideToRoll expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager aHyperGravitySquare aProbabilityOfOne aHyperGravitySquareProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 1.

	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperGravitySquare := HyperGravitySquare between: 1 and: 1.
	aProbabilityOfOne := 1.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with: aProbabilityOfOne.
	aDistributionManager add: aHyperGravitySquareProbabilisticEvent.
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

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
