Class {
	#name : 'BlackHoleTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndDoesNotHaveEnoughFuelThenItGoesBackToItsInitialPosition [

	| aDistribution tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionBuilder |
	tenSquares := 10.
	sideToRoll := 2.
	oneLap := 1.

	expectedPosition := Position at: 7 in: 1.

	aWormHole := WormHole between: 2 and: 7.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder blackHoleProbabilityIs: 1.
	aDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleAndHasEnoughFuelThenItGoesBackFourSquares [

	| aDistribution tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionBuilder |
	tenSquares := 10.
	sideToRoll := 4.
	oneLap := 1.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder blackHoleProbabilityIs: 1.
	aDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfALapThenItGoesBackALapAndToTheAccordingSquare [

	| aDistribution tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionBuilder |
	tenSquares := 10.
	sideToRoll := 4.
	oneLap := 1.

	expectedPosition := Position at: 9 in: 1.

	aWormHole := WormHole between: 4 and: 9.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder blackHoleProbabilityIs: 1.
	aDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
BlackHoleTest >> testWhenAShipLandsOnABlackHoleOnTheFirstThreeSquaresOfTheFirstLapItStaysOnTheFirstLap [

	| aDistribution tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionBuilder |
	tenSquares := 10.
	sideToRoll := 2.
	oneLap := 1.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder blackHoleProbabilityIs: 1.
	aDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
