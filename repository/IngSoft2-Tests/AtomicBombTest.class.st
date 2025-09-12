Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenAllTheOtherShipsFuelDoesNotChange [

	| tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame expectedFuel aDistributionManager anAtomicBombSquare aProbabilityOfOne anAtomicBombProbabilisticEvent zeroReward zeroRewardProbabilisticEvent aRewardManager aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(2) asOrderedCollection.
	twoLaps := 2.

	expectedFuel := Fuel with: 4 upTo: 4 in: HasFuelState new.

	aWormHole := WormHole between: 3 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
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
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheBoard [

	| expectedPosition twentySquares sideToRoll aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager anAtomicBombProbabilisticEvent anAtomicBombSquare aProbabilityOfOne aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 7 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombProbabilisticEvent.
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
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheCurrentLap [

	| expectedPosition tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager anAtomicBombSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(2) asOrderedCollection.
	twoLaps := 2.

	expectedPosition := Position at: 0 in: 2.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
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
	aGameBuilder setLaps: twoLaps.
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
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItsFuelDoesNotChange [

	| tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame expectedFuel aDistributionManager anAtomicBombSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(2) asOrderedCollection.
	twoLaps := 2.

	expectedFuel := Fuel with: 2 upTo: 4 in: HasFuelState new.

	aWormHole := WormHole between: 3 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
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
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenTheOtherShipsGoBackToTheFirstSquareOfTheirCurrentLap [

	| expectedPosition tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager anAtomicBombSquare aProbabilityOfOne anAtomicBombProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(2) asOrderedCollection.
	twoLaps := 2.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
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
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]
