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
		'twentySquares'
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

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbabilityOfOne.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	aGameBuilder := GameBuilder new.
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenAllTheOtherShipsFuelDoesNotChange [

	| sideToRoll aWormHole aLoadedDice aDistribution aBoard aGame expectedFuel |
	sideToRoll := #(2) asOrderedCollection.

	expectedFuel := Fuel with: 4 upTo: 4 in: HasFuelState new.

	aWormHole := WormHole between: 3 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	
	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheBoard [

	| expectedPosition sideToRoll aWormHole aLoadedDice aDistribution aBoard aGame |
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 7 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
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

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheCurrentLap [

	| expectedPosition sideToRoll aWormHole aLoadedDice aDistribution aBoard aGame |
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 0 in: 2.

	aWormHole := WormHole between: 2 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItsFuelDoesNotChange [

	| sideToRoll aWormHole aLoadedDice aDistribution aBoard aGame expectedFuel |
	sideToRoll := #(2) asOrderedCollection.

	expectedFuel := Fuel with: 2 upTo: 4 in: HasFuelState new.

	aWormHole := WormHole between: 3 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenTheOtherShipsGoBackToTheFirstSquareOfTheirCurrentLap [

	| expectedPosition sideToRoll aWormHole aLoadedDice aDistribution aBoard aGame |
	sideToRoll := #(2) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 2 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]
