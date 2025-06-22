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

	| expectedPosition aBlueShip twentySquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	expectedPosition := Position at: 0 in: 1.
	twentySquares := 20.
	sideToRoll := 5.
	oneLap := 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aMoonWalkSquare := MoonWalkSquare between: 7 and: 7.
	aProbabilityOfOne := 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionBuilder add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAMoonWalkSquareMagnitudeIsSmallerThanOneThenInvalid [

	| twentySquares sideToRoll oneLap aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aDistributionBuilder aFuelQuantity aMoonWalkSquare aProbabilityOfOne aMoonWalkSquareProbabilisticEvent aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 1.
	oneLap := 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aMoonWalkSquare := MoonWalkSquare between: -1 and: -1.
	aProbabilityOfOne := 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionBuilder add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	self
		should: [
			Game
				with: aBoard
				for: oneLap
				and: someShips
				and: someDices
				and: aFuelQuantity
				and: aRewardBuilder ]
		raise: Error
		withMessageText:
		'The magnitude of the Moon Walk Square must be positive.'
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareAndTheOtherShipsDoNotHaveEnoughFuelToGoBkacwardThenTheyDoNotMoveAndLoseTwoTurns [

	| expectedPosition aBlueShip twentySquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	expectedPosition := Position at: 8 in: 1.
	twentySquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aProbabilityOfOne := 1.
	aDistributionBuilder := DistributionBuilder new.
	aMoonWalkSquare := MoonWalkSquare between: 3 and: 3.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionBuilder add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.

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

	| expectedPosition aBlueShip twentySquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	expectedPosition := Position at: 6 in: 1.
	twentySquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aMoonWalkSquare := MoonWalkSquare between: 2 and: 2.
	aProbabilityOfOne := 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionBuilder add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareThenItDoesNotMove [

	| expectedPosition aBlueShip twentySquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aProbabilityOfOne aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	expectedPosition := Position at: 1 in: 1.
	twentySquares := 20.
	sideToRoll := 1.
	oneLap := 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aProbabilityOfOne := 1.
	aDistributionBuilder := DistributionBuilder new.
	aMoonWalkSquare := MoonWalkSquare between: 1 and: 2.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionBuilder add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
