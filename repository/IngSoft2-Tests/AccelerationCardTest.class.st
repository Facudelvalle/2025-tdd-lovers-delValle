Class {
	#name : 'AccelerationCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
AccelerationCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenAShipPlaysAnAccelerationCardThenAllRolledNumbersAreIncreasedByOne [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aPlainSquare aPlainSquareProbabilisticEvent anAccelerationCard anAccelerationCardProbabilisticEvent expectedPosition expectedFuel |
	twentySquares := 20.
	sideToRoll := 1.

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
	aDistribution := aDistributionManager generateFor: twentySquares .

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
	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAccelerationCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAccelerationCardProbabilisticEvent.

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
	
	aGame play: anAccelerationCard by: aBlueShip for: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	
	expectedPosition := Position at: 2 in: 1.
	expectedFuel := 0.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert:  (aBlueShip fuelEquals: expectedFuel).
	self assert: (aBlackShip currentPositionEquals: expectedPosition).
	self assert:  (aBlackShip fuelEquals: expectedFuel).
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenAShipTriesToPlayAnAccelerationCardWhenItIsNotItsTurnThenInvalid [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aPlainSquare aPlainSquareProbabilisticEvent anAccelerationCard anAccelerationCardProbabilisticEvent |
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
	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAccelerationCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAccelerationCardProbabilisticEvent.

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
		should: [ aGame play: anAccelerationCard by: aBlackShip for: aBlueShip ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]
