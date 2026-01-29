Class {
	#name : 'CancellationCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'sideToRoll',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aLoadedDice',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareSquareProbabilisticEvent',
		'aDistribution',
		'aBoard',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'someShips',
		'someDices',
		'aNullCard',
		'aCancellationCard',
		'aCancellationCardProbabilisticEvent',
		'aGameBuilder',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'aSetCardManager'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
CancellationCardTest >> setUp [

	super setUp.

	twentySquares := 20.
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aPlainSquare
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

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.

	aNullCard := NullCard new.

	aSetCardManager := SetProbablisiticEventsManager new.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne
]

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

	| expectedPosition expectedFuel aGame |
	expectedPosition := Position at: 3 in: 1.
	expectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	aGame
		play: aCancellationCard
		by: aBlackShip
		affecting: anAccelerationCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedAfterAnAllyCardThenTheEffectIsEliminated [

	| aGame anAllyCard anAllyCardProbabilisticEvent sidesToRoll anotherLoadedDice someOtherDices |
	sidesToRoll := #( 1 1 ) asOrderedCollection.
	anotherLoadedDice := LoadedDice toRoll: sidesToRoll.

	someOtherDices := OrderedCollection new.
	someOtherDices add: anotherLoadedDice.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aSetCardManager add: anAllyCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGameBuilder setDices: someOtherDices.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	aGame
		play: aCancellationCard
		by: aBlackShip
		affecting: anAllyCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: aBlueShip hasAFuelPenalty
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedAfterAnOverloadCardThenTheEffectIsEliminated [

	| expectedPosition expectedFuel aGame anOverloadCard anOverloadCardProbabilisticEvent |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 5 upTo: 6 in: HasFuelState new.

	anOverloadCard := OverloadCard new.
	anOverloadCardProbabilisticEvent := ProbabilisticEvent
		                                    for: anOverloadCard
		                                    with: aProbabilityOfOne.

	aSetCardManager add: anOverloadCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

	aGameBuilder setAvailableCards: aSetCardManager.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anOverloadCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.
	aGame
		play: aCancellationCard
		by: aBlackShip
		affecting: anOverloadCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
CancellationCardTest >> testWhenACancellationCardIsUsedBeforeHavingAnActiveCardThenInvalid [

	| aGame |
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aCancellationCard
				by: aBlackShip
				affecting: anAccelerationCard
				and: aBlueShip
				and: aPlainSquare ]
		raise: Error
		withMessageText: 'The card is not active.'
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipPlaysAnCancelationCardThenItIsNoLongerInItsHand [

	| aGame expectedCards |
	aSetCardManager add: aCancellationCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.
	aGame
		play: aCancellationCard
		by: aBlueShip
		affecting: anAccelerationCard
		and: aBlackShip
		and: aPlainSquare.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
CancellationCardTest >> testWhenAShipTriesToPlayACancellationCardThatIsNotInItsHandThenInvalid [

	| aGame |
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aCancellationCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: aPlainSquare ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]
