Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#instVars : [
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aProbabilityOfOne',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'aBlueShip',
		'aBlackShip',
		'someShips',
		'someDices',
		'aGameBuilder',
		'fiveSquares',
		'twentySquares',
		'aDistributionManager',
		'aPlainSquare',
		'aPlainSquareProbabilisticEvent',
		'aBlackHoleSquare',
		'aBlackHoleSquareProbabilisticEvent',
		'aCardSquare',
		'aCardSquareProbabilisticEvent',
		'aParsecJumpOfFive',
		'aParsecJumpOfSix'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameTest >> setUp [

	super setUp.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aProbabilityOfOne := 1.
	fiveSquares := 5.
	twentySquares := 20.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.

	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.

	aCardSquare := CardSquare new.
	aCardSquareProbabilisticEvent := ProbabilisticEvent
		                                 for: aCardSquare
		                                 with: aProbabilityOfOne.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfSix := Parsec with: 6
]

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
GameTest >> testWhenAPlayerTriesToRollTheDicesWhenTheGameHasFinishedThenItFails [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 5 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self
		should: [ aGame nextTurnPlay ]
		raise: Error
		withMessageText: 'The game has finished.'
]

{ #category : 'tests' }
GameTest >> testWhenAShipCompletesTheRequiredAmountOfLapsThenItwinsTheGame [

	| aWormHole aGame expectedDetails sideToRoll aLoadedDice aBoard fourLaps aDistribution |
	sideToRoll := #( 10 ) asOrderedCollection.
	fourLaps := 4.

	expectedDetails := 'Winner: BlueShip' , String cr
	                   , 'BlueShip: Lap: 5 Square: 0' , String cr
	                   , 'BlackShip: Lap: 3 Square: 0'.

	aWormHole := WormHole between: 2 and: 3.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: fourLaps.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aGame printBoard equals: expectedDetails
]

{ #category : 'tests' }
GameTest >> testWhenAShipGoesThroughTheLastSquareButLandsOnABlackHoleSquareThenTheEffectIsAppliedAndTheGameDoesNotEnd [

	| expectedPosition sideToRoll twoLaps aWormHole aLoadedDice aDistribution aBoard aGame |
	sideToRoll := #( 4 ) asOrderedCollection.
	twoLaps := 2.

	expectedPosition := Position at: 18 in: 1.

	aWormHole := WormHole between: 4 and: 18.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self deny: aGame hasFinished.
	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
GameTest >> testWhenAShipLandsOnACardSquareThenACardIsAssignedToIt [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution expectedCards |
	sideToRoll := #( 1 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	expectedCards := OrderedCollection new.
	expectedCards add: anAllyCard.
	expectedCards add: anAllyCard.
	expectedCards add: anAllyCard.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
GameTest >> testWhenAShipMakesOneLapOnTheBoardThenThePositionChangesAccordingly [

	| aWormHole aBoard aLoadedDice twoLaps sideToRoll aGame expectedPosition aDistribution |
	sideToRoll := #( 6 ) asOrderedCollection.
	twoLaps := 2.

	expectedPosition := Position at: 1 in: 2.

	aWormHole := WormHole between: 2 and: 3.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: twoLaps.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
GameTest >> testWhenAShipMovesOneSquareThenTheBoardIsPrintedCorrectly [

	| aWormHole aGame expectedDetails sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 1 ) asOrderedCollection.

	expectedDetails := 'Winner: There is not a winner yet' , String cr
	                   , 'BlueShip: Lap: 1 Square: 1' , String cr
	                   , 'BlackShip: Lap: 1 Square: 0'.

	aWormHole := WormHole between: 2 and: 3.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: aGame printBoard equals: expectedDetails
]

{ #category : 'tests' }
GameTest >> testWhenAShipReachesTheFinalSquareThenTheGameEnds [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 2 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> testWhenAShipTakesAHyperJumpThenItsMovesAccordingly [

	| aWormHole aBoard aLoadedDice sideToRoll aDistribution someParsecs aRatio aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 2 ) asOrderedCollection.
	aRatio := 2.

	aWormHole := WormHole between: 17 and: 18.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.
		
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText:
		'The magnitude of the Hyper Jump Square Parsecs is not valid.'
]

{ #category : 'tests' }
GameTest >> testWhenTheGameEndsThenTheWinnerIsShownOnTheLeaderBoard [

	| aWormHole aGame expectedDetails sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 3 ) asOrderedCollection.

	expectedDetails := 'Winner: BlueShip' , String cr
	                   , 'BlueShip: Lap: 2 Square: 0' , String cr
	                   , 'BlackShip: Lap: 1 Square: 2'.

	aWormHole := WormHole between: 2 and: 3.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aGame printBoard equals: expectedDetails
]

{ #category : 'tests' }
GameTest >> testWhenTheGameIsCreatedWithOneDiceThenAllTheShipsFuelEqualsToTheMaximumRolledNumberTimesTwo [

	| aWormHole aBoard twoSides aTwoSidedDice aDistribution aGame expectedFuel |
	twoSides := 2.

	expectedFuel := Fuel with: 4 upTo: 4 in: HasFuelState new.

	aWormHole := WormHole between: 1 and: 2.

	aTwoSidedDice := Dice with: twoSides.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aTwoSidedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	self assert: (aBlueShip fuelEquals: expectedFuel).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
GameTest >> testWhenTheGameIsCreatedWithTwoDicesThenAllTheShipsFuelEqualsToTheMaximumRolledNumberTimesTwo [

	| aWormHole aBoard oneLap twoSides aTwoSidedDice aFourSidedDice fourSides aDistribution aGame expectedFuel |
	twoSides := 2.
	fourSides := 4.
	oneLap := 1.

	expectedFuel := Fuel with: 12 upTo: 12 in: HasFuelState new.

	aWormHole := WormHole between: 1 and: 2.

	aTwoSidedDice := Dice with: twoSides.
	aFourSidedDice := Dice with: fourSides.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aTwoSidedDice.
	someDices add: aFourSidedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	self assert: (aBlueShip fuelEquals: expectedFuel).
	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
GameTest >> testWhenTheGameStartsThenAllTheShipsHaveTwoCards [

	| aWormHole aGame sideToRoll aLoadedDice aBoard aDistribution expectedCards |
	sideToRoll := #( 5 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.
	expectedCards add: anAllyCard.
	expectedCards add: anAllyCard.

	self assert: aBlueShip cards equals: expectedCards.
	self assert: aBlackShip cards equals: expectedCards
]
