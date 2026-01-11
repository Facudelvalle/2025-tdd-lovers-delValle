Class {
	#name : 'AccelerationCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'fiveSquares',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aCardManager',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'aSetCardManager',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aNullCard',
		'expectedCards'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
AccelerationCardTest >> setUp [

	super setUp.

	twentySquares := 20.
	fiveSquares := 5.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	aSetCardManager := SetProbablisiticEventsManager new.
	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	aGameBuilder := GameBuilder new.
	aNullCard := NullCard new.
	expectedCards := OrderedCollection new
]

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

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution expectedPosition expectedFuel |
	sideToRoll := #( 1 ) asOrderedCollection.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 0 upTo: 2 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager add: anAccelerationCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel).
	self assert: (aBlackShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenAShipPlaysAnAccelerationCardThenItIsNoLongerInItsHand [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 10 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: anAllyCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards add: anAllyCard.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenAShipTriesToPlayAnAccelerationCardThatIsNotInItsHandThenInvalid [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 10 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: anAccelerationCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]

{ #category : 'tests' }
AccelerationCardTest >> testWhenAShipTriesToPlayAnAccelerationCardWhenItIsNotItsTurnThenInvalid [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager add: anAccelerationCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: anAccelerationCard
				by: aBlackShip
				affecting: aNullCard
				and: aBlueShip ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]
