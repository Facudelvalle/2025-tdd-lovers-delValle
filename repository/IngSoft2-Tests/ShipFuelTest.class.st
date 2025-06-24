Class {
	#name : 'ShipFuelTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipDecideToPassThenItsFuellsToppedUp [

	| tenSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedFuelLeft aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(1) asOrderedCollection.

	expectedFuelLeft := 2.

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

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipIsNoLongerPenalisedThenItsFuelIsToppedUp [

	| tenSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedFuelLeft aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(1) asOrderedCollection.

	expectedFuelLeft := 2.

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

	| tenSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedPosition aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := #(1) asOrderedCollection.

	expectedPosition := Position at: 3 in: 1.

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

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedFuelLeft aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := #(1) asOrderedCollection.

	expectedFuelLeft := 1.

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

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipMovesThroughAWormHoleThenItsFuelDecreasesAccordingly [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedFuelLeft aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := #(1) asOrderedCollection.
	expectedFuelLeft := 1.

	aWormHole := WormHole between: 1 and: 2.
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

	self assert: (aBlueShip fuelEquals: expectedFuelLeft)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipTriesToMoveMoreSquaresThanItsRemainingFuelThenItDoesNotMove [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices expectedPosition aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := #(1) asOrderedCollection.

	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 3 and: 4.
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
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ShipFuelTest >> testWhenAShipTriesToMoveMoreSquaresThanItsRemainingFuelThenLosesTwoTurns [

	| tenSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aDistribution aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
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
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aBlueShip hasAFuelPenalty
]
