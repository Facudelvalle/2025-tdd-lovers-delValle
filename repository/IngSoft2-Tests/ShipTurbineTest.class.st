Class {
	#name : 'ShipTurbineTest',
	#superclass : 'TestCase',
	#instVars : [
		'aDistributionManager',
		'aPlainSquareProbabilisticEvent',
		'tenSquares',
		'aWormHole',
		'someDices',
		'aGameBuilder',
		'aBlackShip',
		'aBlueShip',
		'aProbabilityOfOne',
		'aPlainSquare',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aCardManager',
		'aReversePolarityCard',
		'aReversePolarityCardProbabilisticEvent',
		'someShips',
		'aBlackHoleSquareProbabilisticEvent',
		'aBlackHoleSquare',
		'aNullCard',
		'aRepeatCard',
		'aRepeatCardProbabilisticEvent',
		'anAffectedSquaresPosition',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'aHyperGravitySquareOfTwoProbabilisticEvent',
		'aSetHyperGravitySquare'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ShipTurbineTest >> setUp [

	super setUp.

	tenSquares := 10.

	aDistributionManager := ProbablisiticEventsManager new.

	aWormHole := WormHole between: 8 and: 9.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aProbabilityOfOne := 1.

	aPlainSquare := PlainSquare new.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := SetProbablisiticEventsManager new.
	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.
	aCardManager add: aReversePolarityCardProbabilisticEvent.

	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                 for: aRepeatCard
		                                 with: aProbabilityOfOne.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	someDices := OrderedCollection new.
	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.
	aGameBuilder setAvailableCards: aCardManager.
	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.

	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.

	aSetHyperGravitySquare := HyperGravitySquare between: 2 and: 2.
	aHyperGravitySquareOfTwoProbabilisticEvent := ProbabilisticEvent
		                                              for:
		                                              aSetHyperGravitySquare
		                                              with:
		                                              aProbabilityOfOne.

	aNullCard := NullCard new.
	anAffectedSquaresPosition := Position at: 9 in: 1
]

{ #category : 'asserting' }
ShipTurbineTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
ShipTurbineTest >> testEachShipStartsTheGameWithThreeTurbines [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 3.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	self assert: aBlueShip turbines equals: expectedTurbines.
	self assert: aBlackShip turbines equals: expectedTurbines
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenAShipCannotGetOutOfAHyperGravitySquareThenItLosesATurbine [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 1 1 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 2.

	aDistributionManager add: aHyperGravitySquareOfTwoProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: aBlueShip turbines equals: expectedTurbines
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenAShipLandsOnABlackHoleSquareThenItLosesATurbine [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 2.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: aBlueShip turbines equals: expectedTurbines
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenAShipLandsOnAnInverseBlackHoleSquareThenEachOtherShipsLosesATurbine [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 2.
	anAffectedSquaresPosition := Position at: 1 in: 1.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aCardManager add: aReversePolarityCardProbabilisticEvent.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: aBlackShip turbines equals: expectedTurbines
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsABlackHoleThenTheTargetedShipLosesATurbine [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 1.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aCardManager add: aRepeatCardProbabilisticEvent.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	self assert: aBlueShip turbines equals: expectedTurbines
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenAShipRunsOutOfFuelThenItLosesATurbine [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 2.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: aBlueShip turbines equals: expectedTurbines.
	self assert: aBlueShip hasAFuelPenalty
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenAShipRunsOutOfTurbinesThenItCannotKeepPlaying [

	| sideToRoll aLoadedDice aDistribution aBoard aGame |
	sideToRoll := #( 1 1 1 1 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aHyperGravitySquareOfTwoProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.

	self
		should: [ aGame nextTurnPlay ]
		raise: Error
		withMessageText:
		'This ship cannot keep playing because it ran out of turbines.'
]

{ #category : 'tests' }
ShipTurbineTest >> testWhenTwoShipsAreAlliesAndNeitherHaveEnoughFuelForOneToMoveThenBothLoseATurbine [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedTurbines |
	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedTurbines := 2.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aCardManager add: anAllyCardProbabilisticEvent.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aBlueShip turbines equals: expectedTurbines.
	self assert: aBlackShip turbines equals: expectedTurbines
]
