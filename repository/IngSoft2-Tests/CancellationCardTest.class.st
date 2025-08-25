Class {
	#name : 'CancellationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
CancellationCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedAfterAnAccelerationCardThenTheEffectIsEliminated [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aCancellationCard aCancellationCardProbabilisticEvent someShips someDices aGameBuilder aGame anAccelerationCard aSetCardManager anAccelerationCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 3 in: 1.
	expectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquareSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aPlainSquareSquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

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
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame
		play: aCancellationCard
		by: aBlackShip
		affecting: anAccelerationCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedAfterAnAllyCardThenTheEffectIsEliminated [

	| twentySquares sideToRoll aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aCancellationCard aCancellationCardProbabilisticEvent someShips someDices aGameBuilder aGame anAllyCard aSetCardManager anAllyCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 1 1 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquareSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aPlainSquareSquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAllyCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

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
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame
		play: aCancellationCard
		by: aBlackShip
		affecting: anAllyCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: aBlueShip hasAFuelPenalty
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedAfterAnOverloadCardThenTheEffectIsEliminated [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aCancellationCard aCancellationCardProbabilisticEvent someShips someDices aGameBuilder aGame anOverloadCard aSetCardManager anOverloadCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 3 1 1 ) asOrderedCollection.

	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 5 upTo: 6 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquareSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aPlainSquareSquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	anOverloadCard := OverloadCard new.
	anOverloadCardProbabilisticEvent := ProbabilisticEvent
		                                    for: anOverloadCard
		                                    with: aProbabilityOfOne.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anOverloadCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

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
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.

	aGame
		play: anOverloadCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame
		play: aCancellationCard
		by: aBlackShip
		affecting: anOverloadCard
		and: aBlueShip.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedBeforeHavingAnActiveCardThenInvalid [

	| twentySquares sideToRoll aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aCancellationCard aCancellationCardProbabilisticEvent someShips someDices aGameBuilder aGame anAccelerationCard aSetCardManager anAccelerationCardProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquareSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aPlainSquareSquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

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
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aCancellationCard
				by: aBlackShip
				affecting: anAccelerationCard
				and: aBlueShip ]
		raise: Error
		withMessageText: 'The card is not active.'
]
