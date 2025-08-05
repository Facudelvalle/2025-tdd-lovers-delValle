Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndDoesNotHaveEnoughFuelThenItGoesBackToItsInitialPosition [

	| aDistribution tenSquares sideToRoll expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager anBlackHoleSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 7 in: 1.

	aWormHole := WormHole between: 2 and: 7.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anBlackHoleSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombProbabilisticEvent.
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

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndHasEnoughFuelThenItGoesBackFourSquares [

	| aDistribution tenSquares sideToRoll expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager anBlackHoleSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(4) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anBlackHoleSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombProbabilisticEvent.
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

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfALapThenItGoesBackALapAndToTheAccordingSquare [

	| aDistribution tenSquares sideToRoll expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager anBlackHoleSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(4) asOrderedCollection.

	expectedPosition := Position at: 9 in: 1.

	aWormHole := WormHole between: 4 and: 9.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anBlackHoleSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombProbabilisticEvent.
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
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfTheFirstLapItStaysOnTheFirstLap [

	| aDistribution tenSquares sideToRoll expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionManager anBlackHoleSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anBlackHoleSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombProbabilisticEvent.
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

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
