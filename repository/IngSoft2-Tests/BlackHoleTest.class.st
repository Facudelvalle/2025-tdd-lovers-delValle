Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#instVars : [
		'tenSquares',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aBlackHoleSquare',
		'aProbabilityOfOne',
		'aBlackHoleProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aDistributionWithBlackHolesSquares',
		'aReversePolarityCard',
		'aReversePolarityCardProbabilisticEvent',
		'aNullCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BlackHoleTest >> setUp [

	super setUp.

	tenSquares := 10.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	aBlackHoleProbabilisticEvent := ProbabilisticEvent
		                                for: aBlackHoleSquare
		                                with: aProbabilityOfOne.
	aDistributionManager add: aBlackHoleProbabilisticEvent.
	aDistributionWithBlackHolesSquares := aDistributionManager
		                                      generateFor: tenSquares.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.
	aCardManager add: aReversePolarityCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices := OrderedCollection new.

	aGameBuilder := GameBuilder new.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGameBuilder setShips: someShips.
	
	aNullCard := NullCard new
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndDoesNotHaveEnoughFuelThenItGoesBackToItsInitialPosition [

	| sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #( 4 ) asOrderedCollection.

	expectedPosition := Position at: 7 in: 1.

	aWormHole := WormHole between: 4 and: 7.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistributionWithBlackHolesSquares.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndHasEnoughFuelThenItGoesBackFourSquares [

	| sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #( 4 ) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistributionWithBlackHolesSquares.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfALapThenItGoesBackALapAndToTheAccordingSquare [

	| sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #( 4 ) asOrderedCollection.

	expectedPosition := Position at: 9 in: 1.

	aWormHole := WormHole between: 4 and: 9.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistributionWithBlackHolesSquares.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfTheFirstLapItStaysOnTheFirstLap [

	| sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame |
	sideToRoll := #( 2 ) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistributionWithBlackHolesSquares.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnAnInvertedBlackHoleAndOneOfTheOtherShipsDoesNotHaveEnoughFuelThenItGoesBackToItsInitialPosition [

	| sideToRoll expectedPosition aWormHole aLoadedDice aBoard aGame anAffectedSquaresPosition |
	sideToRoll := #( 4 4 1 ) asOrderedCollection.

	expectedPosition := Position at: 5 in: 1.

	anAffectedSquaresPosition := Position at: 6 in: 1.

	aWormHole := WormHole between: 4 and: 5.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistributionWithBlackHolesSquares.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]
