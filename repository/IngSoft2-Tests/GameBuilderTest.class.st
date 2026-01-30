Class {
	#name : 'GameBuilderTest',
	#superclass : 'TestCase',
	#instVars : [
		'fiveSquares',
		'sideToRoll',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aLoadedDice',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameBuilderTest >> setUp [

	super setUp.

	fiveSquares := 5.

	sideToRoll := #( 2 ) asOrderedCollection.

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

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	aGameBuilder := GameBuilder new
]

{ #category : 'asserting' }
GameBuilderTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
GameBuilderTest >> testWhenThereAreLessThanTwoShipsThenTheGameIsInvalid [

	| aBoard aDistribution |
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips add: aBlueShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText: 'The Game needs at least two ship to start.'
]

{ #category : 'tests' }
GameBuilderTest >> testWhenThereAreNotAnyDicesThenTheGameIsInvalid [

	| aBoard aDistribution |
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText: 'The Game needs at least one dice to start.'
]

{ #category : 'tests' }
GameBuilderTest >> testWhenThereIsLessThanOneLapThenTheGameIsInvalid [

	| aBoard aDice twoSides zeroLaps aDistribution |
	twoSides := 2.
	zeroLaps := 0.

	aDice := Dice with: twoSides.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aDice.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: zeroLaps.
	aGameBuilder setDices: someDices.
	aGameBuilder setShips: someShips.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText: 'The Game needs at least one lap to start.'
]

{ #category : 'tests' }
GameBuilderTest >> testWhenTryingToCreateAGameWithoutABoardThenItFails [

	| aBoard aDistribution |
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText: 'The game must have a board to be created.'
]
