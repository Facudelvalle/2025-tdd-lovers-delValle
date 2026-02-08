Class {
	#name : 'HyperGravityTest',
	#superclass : 'TestCase',
	#instVars : [
		'tenSquares',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aSetHyperGravitySquare',
		'aProbabilityOfOne',
		'aSetHyperGravitySquareProbabilisticEvent',
		'aDistribution',
		'aBoard',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'someDices'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
HyperGravityTest >> setUp [

	super setUp.

	tenSquares := 10.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aSetHyperGravitySquare := HyperGravitySquare between: 2 and: 2.
	aProbabilityOfOne := 1.
	aSetHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                            for:
		                                            aSetHyperGravitySquare
		                                            with: aProbabilityOfOne.
	aDistributionManager add: aSetHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager
]

{ #category : 'asserting' }
HyperGravityTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItDoesNotMove [

	| sideToRoll expectedPosition aLoadedDice aGame |
	sideToRoll := #( 2 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 2 in: 1.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItsFuelDoesNotChange [

	| sideToRoll expectedFuel aLoadedDice aGame |
	sideToRoll := #( 1 1 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedFuel := Fuel with: 3 upTo: 4 in: HasFuelState new.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRolledTheNecesaryNumberThenItCanMove [

	| sideToRoll expectedPosition aLoadedDice aGame |
	sideToRoll := #( 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 4 in: 1.

	someDices add: aLoadedDice.

	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenThereIsAHyperGravitySquareWithMagnitudeGreaterThanTheMaximumRollThenInvalid [

	| aHyperGravitySquare aHyperGravitySquareProbabilisticEvent sideToRoll aLoadedDice |
	sideToRoll := #( 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aHyperGravitySquare := HyperGravitySquare between: 10 and: 12.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with: aProbabilityOfOne.
	aDistributionManager add: aHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText:
		'The magnitude of the Hyper Gravity Square is grater than the maximum roll.'
]
