Class {
	#name : 'HyperGravityTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItDoesNotMove [

	| aDistribution hyperGravitySquareProbability tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame |
	tenSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	
	expectedPosition := Position at: 1 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	
	hyperGravitySquareProbability := 1.

	aDistribution := {
		                 ([ SetHyperGravitySquare with: 2 ]
		                  -> hyperGravitySquareProbability).}.
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
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItsFuelDoesNotChange [

	| aDistribution hyperGravitySquareProbability tenSquares sideToRoll oneLap expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame |
	tenSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	
	expectedFuel := 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	
	hyperGravitySquareProbability := 1.

	aDistribution := {
		                 ([ SetHyperGravitySquare with: 2 ]
		                  -> hyperGravitySquareProbability).}.
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

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRolledTheNecesaryNumberThenItCanMove [

	| aDistribution hyperGravitySquareProbability tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionBuilder |
	tenSquares := 10.
	sideToRoll := 1.
	oneLap := 1.
	
	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	
	hyperGravitySquareProbability := 1.

	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder hyperGravityProbabilityIs: 1.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder hyperGravitySquareBetween: 1 and: 1.
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
