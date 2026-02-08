Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aProbabilityOfOne',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'aWormHole',
		'aNullCard',
		'aReversePolarityCard',
		'aReversePolarityCardProbabilisticEvent',
		'aSetCardManagerWithReversePolarityCards',
		'someDices'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
MoonWalkTest >> setUp [

	super setUp.

	twentySquares := 20.

	aWormHole := WormHole between: 17 and: 18.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aProbabilityOfOne := 1.

	aDistributionManager := ProbablisiticEventsManager new.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.

	aNullCard := NullCard new.

	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.

	aSetCardManagerWithReversePolarityCards := ProbablisiticEventsManager
		                                           new.
	aSetCardManagerWithReversePolarityCards add:
		aReversePolarityCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards:
		aSetCardManagerWithReversePolarityCards
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
MoonWalkTest >> testWhenAMoonWalkSquareMagnitudeIsSmallerThanOneThenInvalid [

	| sideToRoll aLoadedDice aBoard aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution |
	sideToRoll := #( 1 ) asOrderedCollection.
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
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkEffectOnTheFirstLapTheMagnitudeOfWhichIsGreaterThanAnothersShipSquareThenThatShipGoesBackToTheFirstSquare [

	| expectedPosition sideToRoll aLoadedDice aBoard aGame aDistribution aMoonWalkSquare aMoonWalkSquareProbabilisticEvent |
	expectedPosition := Position at: 0 in: 1.

	sideToRoll := #( 5 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aWormHole := WormHole between: 5 and: 6.

	aMoonWalkSquare := MoonWalkSquare between: 7 and: 7.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.

	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareAndTheOtherShipsDoNotHaveEnoughFuelToGoBackwardsThenTheyDoNotMoveAndLoseTwoTurns [

	| expectedPosition sideToRoll aLoadedDice aBoard aGame aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution |
	expectedPosition := Position at: 8 in: 1.

	sideToRoll := #( 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aWormHole := WormHole between: 2 and: 8.

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

	| expectedPosition sideToRoll aLoadedDice aBoard aGame aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution |
	expectedPosition := Position at: 6 in: 1.

	sideToRoll := #( 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aWormHole := WormHole between: 2 and: 8.

	aMoonWalkSquare := MoonWalkSquare between: 2 and: 2.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.

	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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

	| expectedPosition sideToRoll aLoadedDice aBoard aGame aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution |
	expectedPosition := Position at: 1 in: 1.

	sideToRoll := #( 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

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

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAnInvertedMoonWalkEffectTheMagnitudeOfWhichIsGreaterThanTheSquareInTheFirstLapThenTheShipGoesBackToTheFirstSquare [

	| expectedPosition sideToRoll aLoadedDice aBoard aGame anAffectedSquaresPosition aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution |
	expectedPosition := Position at: 0 in: 1.

	sideToRoll := #( 4 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aWormHole := WormHole between: 4 and: 5.

	aMoonWalkSquare := MoonWalkSquare between: 7 and: 7.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.

	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	anAffectedSquaresPosition := Position at: 6 in: 1.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAnInvertedMoonWalkSquareThenTheOtherShipsDoNotMove [

	| aGame aBoard anAffectedSquaresPosition expectedPosition sideToRoll aLoadedDice aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution |
	expectedPosition := Position at: 9 in: 1.

	sideToRoll := #( 9 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aMoonWalkSquare := MoonWalkSquare between: 7 and: 7.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.

	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 7 in: 1.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
