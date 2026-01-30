Class {
	#name : 'OverloadCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aWormHole',
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
		'anOverloadCard',
		'anOverloadCardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'aNullCard',
		'anAffectedSquaresPosition',
		'aDistribution',
		'aBoard',
		'someDices',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
OverloadCardTest >> setUp [

	super setUp.

	twentySquares := 20.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

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
	anOverloadCard := OverloadCard new.
	anOverloadCardProbabilisticEvent := ProbabilisticEvent
		                                    for: anOverloadCard
		                                    with: aProbabilityOfOne.
	aCardManager add: anOverloadCardProbabilisticEvent.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	someDices := OrderedCollection new.
	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setBoard: aBoard.

	aNullCard := NullCard new
]

{ #category : 'asserting' }
OverloadCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
OverloadCardTest >> testWhenAShipPlaysAnOverloadCardAndTheRolledNumberIsSmallerThanTwoThenTheShipMovesBackwards [

	| aGame sideToRoll aLoadedDice expectedPosition expectedFuel |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 0 upTo: 2 in: HasFuelState new.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame
		play: anOverloadCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
OverloadCardTest >> testWhenAShipPlaysAnOverloadCardThenItIsNoLongerInItsHand [

	| aGame sideToRoll aLoadedDice expectedCards |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aCardManager := SetProbablisiticEventsManager new.
	aCardManager add: anOverloadCardProbabilisticEvent.
	aCardManager add: anAccelerationCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.
	expectedCards add: anAccelerationCard.

	aGame
		play: anOverloadCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
OverloadCardTest >> testWhenAShipPlaysAnOverloadCardThenTheRolledNumberOfTheTargetShipIsReducedByTwo [

	| aGame sideToRoll aLoadedDice expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 4 in: 1.
	expectedFuel := Fuel with: 2 upTo: 6 in: HasFuelState new.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame
		play: anOverloadCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
OverloadCardTest >> testWhenAShipTriesToPlayAnOverloadCardThatIsNotInItsHandThenInvalid [

	| aGame sideToRoll aLoadedDice |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aCardManager := ProbablisiticEventsManager new.
	aCardManager add: anAllyCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: anOverloadCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]

{ #category : 'tests' }
OverloadCardTest >> testWhenAShipTriesToPlayAnOverloadCardWhenItIsNotItsTurnThenInvalid [

	| aGame sideToRoll aLoadedDice |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: anOverloadCard
				by: aBlackShip
				affecting: aNullCard
				and: aBlueShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]
