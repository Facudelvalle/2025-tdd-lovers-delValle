Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesOneMoveOfTwoSquaresThenItsPositionIsTwo [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDefaultDistribution expectedSquare |
	twentySquares := 20.
	sideToRoll := 2.
	
	expectedSquare := 2.
	
	aWormHole := WormHole between: 3 and: 10.
	aShip := Ship called: 'BlueShip'.	
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.
	
	aShip move: aSetDice roll.
	
	self assert: aShip currentSquare equals: expectedSquare
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMakesTwoMovesOfOneSquareThenItsPositionIsTwo [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDefaultDistribution expectedSquare |
	twentySquares := 20.
	sideToRoll := 1.

	expectedSquare := 2.

	aWormHole := WormHole between: 3 and: 10.
	aShip := Ship called: 'BlueShip'.
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.

	aShip move: aSetDice roll.
	aShip move: aSetDice roll.

	self assert: aShip currentSquare equals: expectedSquare
]

{ #category : 'tests' }
ShipTest >> testWhenAShipMovesOneSquareThenItsPositionIsOne [

	| aBoard aShip twentySquares aSetDice aWormHole sideToRoll aDistributionBuilder aDefaultDistribution expectedSquare |
	twentySquares := 20.
	sideToRoll := 1.
	
	expectedSquare := 1.
	
	aWormHole := WormHole between: 3 and: 10.
	aShip := Ship called: 'BlueShip'.	
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDefaultDistribution.
	
	aShip move: aSetDice roll.
	self assert: aShip currentSquare equals: expectedSquare
]
