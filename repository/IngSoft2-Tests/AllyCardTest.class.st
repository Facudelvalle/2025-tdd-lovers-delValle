Class {
	#name : 'AllyCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aSetCardManagerWithAllyCards',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aNullCard',
		'fiveSquares',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'expectedCards',
		'aRedShip',
		'sideToRoll',
		'aWormHole',
		'aLoadedDice',
		'aDistribution',
		'aBoard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
AllyCardTest >> setUp [

	super setUp.

	twentySquares := 20.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aRedShip := Ship called: 'RedShip'.
	expectedCards := OrderedCollection new.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.

	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

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

	aSetCardManagerWithAllyCards := ProbablisiticEventsManager new.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aSetCardManagerWithAllyCards add: anAllyCardProbabilisticEvent.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

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

	aNullCard := NullCard new
]

{ #category : 'asserting' }
AllyCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipPlaysAnAllyCardAndNeitherOfTheShipsHaveEnoughFuelThenBothArePenalized [

	| aGame |
	aGameBuilder setAvailableCards: aSetCardManagerWithAllyCards.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aBlueShip hasAFuelPenalty.
	self assert: aBlackShip hasAFuelPenalty
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipPlaysAnAllyCardThenItCanUseTheOtherShipsFuelWhenItHasNotEnoughFuelToMove [

	| aGame expectedPosition expectedFuel |
	expectedPosition := Position at: 3 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGameBuilder setAvailableCards: aSetCardManagerWithAllyCards.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipPlaysAnAllyCardThenItIsNoLongerInItsHand [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAllyCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards add: anAccelerationCard.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipPlaysAnAllyCardThenItsAllyCanUseTheShipsFuelWhenItHasNotEnoughFuelToMove [

	| aGame expectedPosition expectedFuel |
	expectedPosition := Position at: 3 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	aGameBuilder setAvailableCards: aSetCardManagerWithAllyCards.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame
		play: anAllyCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipPlaysTwoAllyCardsAndOneOfItsAlliesDoesNotHaveEnoughFuelToLendButTheOtherDoesThenTheShipMovesCorrectly [

	| aGame expectedPosition expectedFuel |
	expectedPosition := Position at: 3 in: 1.
	expectedFuel := Fuel with: 1 upTo: 2 in: HasFuelState new.

	someShips add: aRedShip.

	aGameBuilder setAvailableCards: aSetCardManagerWithAllyCards.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.
	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aRedShip.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aRedShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipTriesToPlayAnAllyCardThatIsNotInItsHandThenInvalid [

	| aGame aSetCardManager |
	aSetCardManager := SetProbablisiticEventsManager new.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: anAllyCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]

{ #category : 'tests' }
AllyCardTest >> testWhenAShipTriesToPlayAnAllyCardWhenItIsNotItsTurnThenInvalid [

	| aGame |
	aGameBuilder setAvailableCards: aSetCardManagerWithAllyCards.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: anAllyCard
				by: aBlackShip
				affecting: aNullCard
				and: aBlueShip ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]
