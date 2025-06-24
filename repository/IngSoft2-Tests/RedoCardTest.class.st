Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
RedoCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAPermanentCardAndItsNotYourTurnThenItFails [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aRedoCard aRedoCardProbabilisticEvent someShips someDices aGameBuilder aGame anAccelerationCard aSetCardManager anAccelerationCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 5 in: 1.
	expectedFuel := 1.

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

	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aRedoCardProbabilisticEvent.

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

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterARedoCardAfterAnAccelerationCardThenTheEffectIsAppliedProperly [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aRedoCard aRedoCardProbabilisticEvent someShips someDices aGameBuilder aGame anAccelerationCard aSetCardManager anAccelerationCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 1 1 10 ) asOrderedCollection.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := 14.

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

	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aRedoCardProbabilisticEvent.

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
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnAccelerationCardThenTheEffectIsAppliedProperly [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aRedoCard aRedoCardProbabilisticEvent someShips someDices aGameBuilder aGame anAccelerationCard aSetCardManager anAccelerationCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 5 in: 1.
	expectedFuel := 1.

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

	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aRedoCardProbabilisticEvent.

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
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnAllyCardThenTheEffectIsAppliedProperly [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aRedoCard aRedoCardProbabilisticEvent someShips someDices aGameBuilder aGame aSetCardManager aRedShip aPinkShip anAllyCard anAllyCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 3 ) asOrderedCollection.

	expectedPosition := Position at: 9 in: 1.
	expectedFuel := 3.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aRedShip := Ship called: 'RedShip'.
	aPinkShip := Ship called: 'PinkShip'.
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

	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someShips add: aRedShip.
	someShips add: aPinkShip.
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
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame
		play: aRedoCard
		by: aRedShip
		affecting: aNullCard
		and: aPinkShip.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aRedShip currentPositionEquals: expectedPosition).
	self assert: (aPinkShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnOverloadCardThenTheEffectIsAppliedProperly [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aRedoCard aRedoCardProbabilisticEvent someShips someDices aGameBuilder aGame aSetCardManager anOverloadCard anOverloadCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 3 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := 2.

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

	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anOverloadCardProbabilisticEvent.
	aSetCardManager add: aRedoCardProbabilisticEvent.

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
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedBeforeAnyCardIsPlayedThenItFails [

	| twentySquares sideToRoll expectedPosition expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aDistributionManager aPlainSquareSquare aProbabilityOfOne aPlainSquareSquareProbabilisticEvent aDistribution aBoard aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aRedoCard aRedoCardProbabilisticEvent someShips someDices aGameBuilder aGame anAccelerationCard aSetCardManager anAccelerationCardProbabilisticEvent aNullCard |
	twentySquares := 20.
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 5 in: 1.
	expectedFuel := 1.

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

	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aRedoCardProbabilisticEvent.

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

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip ]
		raise: Error
		withMessageText:
		'A Redo card can not be played when there are no played cards yet.'
]
