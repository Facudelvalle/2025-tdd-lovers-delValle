Class {
	#name : 'RepeatCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
RepeatCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsABackHoleEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aBlackHoleSquare aBlackHoleSquareProbabilisticEvent expectedPosition expectedFuel |
	twentySquares := 20.
	sideToRoll := 10.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := 2.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aBlackHoleSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
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

	aCardManager := ProbablisiticEventsManager new.
	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                for: aRepeatCard
		                                with: aProbabilityOfOne.
	aCardManager add: aRepeatCardProbabilisticEvent.

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
	aGame play: aRepeatCard by: aBlackShip for: aBlueShip.
	aGame nextTurnPass.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAHyperGavityEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aHyperGavitySquare aBlackHoleSquareProbabilisticEvent expectedPosition expectedFuel |
	twentySquares := 20.
	sideToRoll := 5.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := 2.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperGavitySquare := SetHyperGravitySquare with: 4.
	aProbabilityOfOne := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperGavitySquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
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

	aCardManager := ProbablisiticEventsManager new.
	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                for: aRepeatCard
		                                with: aProbabilityOfOne.
	aCardManager add: aRepeatCardProbabilisticEvent.

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
	aGame play: aRepeatCard by: aBlackShip for: aBlueShip.
	aGame nextTurnPass.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsANullEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aPlainSquare aPlainSquareProbabilisticEvent expectedPosition expectedFuel |
	twentySquares := 20.
	sideToRoll := 3.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := 0.

	aWormHole := WormHole between: 18 and: 19.
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

	aCardManager := ProbablisiticEventsManager new.
	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                for: aRepeatCard
		                                with: aProbabilityOfOne.
	aCardManager add: aRepeatCardProbabilisticEvent.

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
	aGame play: aRepeatCard by: aBlackShip for: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipTriesToPlayARepeatCardWhenItIsNotItsTurnThenInvalid [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager anRepeatCard anRepeatCardProbabilisticEvent aPlainSquare aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 1.

	aWormHole := WormHole between: 2 and: 3.
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
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anRepeatCard := RepeatCard new.
	anRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                for: anRepeatCard
		                                with: aProbabilityOfOne.
	aCardManager add: anRepeatCardProbabilisticEvent.

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

	self
		should: [ aGame play: anRepeatCard by: aBlackShip for: aBlueShip ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]
