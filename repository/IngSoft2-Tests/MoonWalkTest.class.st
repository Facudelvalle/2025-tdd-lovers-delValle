Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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

	| expectedPosition aBlueShip twentySquares sideToRoll aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	expectedPosition := Position at: 0 in: 1.
	twentySquares := 20.
	sideToRoll := 5.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: 7 and: 7.
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

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
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

	| twentySquares sideToRoll aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aDistributionManager aMoonWalkSquare aProbabilityOfOne aMoonWalkSquareProbabilisticEvent aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: -1 and: -1.
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

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.

	self
		should: [ aGameBuilder build ]
		raise: Error
		withMessageText:
		'The magnitude of the Moon Walk Square must be positive.'
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareAndTheOtherShipsDoNotHaveEnoughFuelToGoBkacwardThenTheyDoNotMoveAndLoseTwoTurns [

	| expectedPosition aBlueShip twentySquares sideToRoll aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	expectedPosition := Position at: 8 in: 1.
	twentySquares := 20.
	sideToRoll := 2.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
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

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
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

	| expectedPosition aBlueShip twentySquares sideToRoll aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	expectedPosition := Position at: 6 in: 1.
	twentySquares := 20.
	sideToRoll := 2.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
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

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
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

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareThenItDoesNotMove [

	| expectedPosition aBlueShip twentySquares sideToRoll aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionManager aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardManager zeroReward zeroRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard anAllyCardProbabilisticEvent |
	expectedPosition := Position at: 1 in: 1.
	twentySquares := 20.
	sideToRoll := 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
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

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
