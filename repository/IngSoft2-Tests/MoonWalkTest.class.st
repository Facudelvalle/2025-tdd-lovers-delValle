Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aMoonWalkSquare',
		'aProbabilityOfOne',
		'aMoonWalkSquareProbabilisticEvent',
		'aDistribution',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'aGameBuilder'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
MoonWalkTest >> setUp [

	super setUp.

	twentySquares := 20.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: 7 and: 7.
	aProbabilityOfOne := 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.


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
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
]

{ #category : 'asserting' }
MoonWalkTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAMoonWalkEffectWhichMagnitudeIsGreaterThanAShipSquareInTheFirstLapThenTheShipGoesBackToTheFirstSquare [

	| expectedPosition sideToRoll aWormHole aLoadedDice someDices aBoard aGame|
	expectedPosition := Position at: 0 in: 1.
	sideToRoll := #(5) asOrderedCollection.

	aWormHole := WormHole between: 5 and: 6.
	aLoadedDice := LoadedDice toRoll: sideToRoll.


	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAMoonWalkSquareMagnitudeIsSmallerThanOneThenInvalid [

	| sideToRoll aWormHole  aLoadedDice aBoard someDices |
	sideToRoll := #(1) asOrderedCollection.

	aWormHole := WormHole between: 17 and: 18.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aMoonWalkSquare := MoonWalkSquare between: -1 and: -1.

	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText:
		'The magnitude of the Moon Walk Square must be positive.'
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareAndTheOtherShipsDoNotHaveEnoughFuelToGoBkacwardThenTheyDoNotMoveAndLoseTwoTurns [

	| expectedPosition sideToRoll aWormHole aLoadedDice aBoard someDices aGame  |
	expectedPosition := Position at: 8 in: 1.
	sideToRoll := #(2) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aProbabilityOfOne := 1.
	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: 3 and: 3.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.


	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareThenAllTheOtherShipsMoveAccordingWithTheSquareMagnitude [

	| expectedPosition sideToRoll aWormHole aLoadedDice aBoard someDices aGame |
	expectedPosition := Position at: 6 in: 1.
	sideToRoll := #(2) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 8.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: 2 and: 2.
	aProbabilityOfOne := 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareThenItDoesNotMove [

	| expectedPosition sideToRoll aWormHole  aLoadedDice aBoard someDices aGame  |
	expectedPosition := Position at: 1 in: 1.
	twentySquares := 20.
	sideToRoll := #(1) asOrderedCollection.

	aWormHole := WormHole between: 17 and: 18.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aProbabilityOfOne := 1.
	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: 1 and: 2.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
