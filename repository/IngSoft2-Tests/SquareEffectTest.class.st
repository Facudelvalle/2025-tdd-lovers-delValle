Class {
	#name : 'SquareEffectTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SquareEffectTest >> testWhenAllTheSquaresDoNotHaveAnEffectThenTheGameIsPlayedRegularly [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap expectedPosition aDistributionBuilder aDefaultDistribution aFuelQuantity |
	fiveSquares := 5.
	sideToRoll := 4.
	oneLap := 1.

	expectedPosition := Position at: 4 in: 1.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.

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
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
