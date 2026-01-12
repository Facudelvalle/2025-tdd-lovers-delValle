Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#instVars : [
		'tenSquares',
		'twoLaps',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'anAtomicBombSquare',
		'aProbabilityOfOne',
		'anAtomicBombProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder',
		'twentySquares',
		'sideToRoll',
		'aLoadedDice',
		'aWormHole',
		'aDistribution',
		'aBoardWithAtomicBombSquares'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
AtomicBombTest >> setUp [

	super setUp.

	tenSquares := 10.
	twentySquares := 20.
	twoLaps := 2.

	sideToRoll := #( 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aWormHole := WormHole between: 7 and: 8.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombProbabilisticEvent.

	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoardWithAtomicBombSquares := Board
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
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenAllTheOtherShipsFuelDoesNotChange [

	| aGame expectedFuel |
	expectedFuel := Fuel with: 4 upTo: 4 in: HasFuelState new.

	aGameBuilder setBoard: aBoardWithAtomicBombSquares.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheBoard [

	| expectedPosition aGame |
	expectedPosition := Position at: 0 in: 1.

	aGameBuilder setBoard: aBoardWithAtomicBombSquares.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheCurrentLap [

	| expectedPosition anotherWormHole anotherBoard aGame |
	expectedPosition := Position at: 0 in: 2.

	anotherWormHole := WormHole between: 2 and: 8.

	anotherBoard := Board
		                with: tenSquares
		                and: anotherWormHole
		                distributedBy: aDistribution.

	aGameBuilder setBoard: anotherBoard.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItsFuelDoesNotChange [

	| aGame expectedFuel |
	expectedFuel := Fuel with: 2 upTo: 4 in: HasFuelState new.

	aGameBuilder setBoard: aBoardWithAtomicBombSquares.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenTheOtherShipsGoBackToTheFirstSquareOfTheirCurrentLap [

	| expectedPosition aGame |
	expectedPosition := Position at: 0 in: 1.

	aGameBuilder setBoard: aBoardWithAtomicBombSquares.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]
