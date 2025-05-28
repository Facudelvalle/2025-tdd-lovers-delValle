Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkTest >> testWhenAMoonWalkEffectWhichMagnitudeIsGreaterThanAShipSquareInTheFirstLapThenTheShipGoesBackToTheFirstSquare [


	| expectedPosition aBlueShip fiveSquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame moonWalkSquareProbability |
	
	expectedPosition := Position at: 0 in: 1.
	fiveSquares := 20.
	sideToRoll := 5.
	oneLap := 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	moonWalkSquareProbability := 1.

	aDistribution := { ([ SetMoonWalkSquare with: 7]
	                  -> moonWalkSquareProbability ) }.
	aBoard := Board
		          with: fiveSquares
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
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareAndTheOtherShipsDoNotHaveEnoughFuelToGoBkacwardThenTheyDoNotMoveAndLoseTwoTurns [


	| expectedPosition aBlueShip fiveSquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame moonWalkSquareProbability |
	
	expectedPosition := Position at: 8 in: 1.
	fiveSquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	moonWalkSquareProbability := 1.

	aDistribution := { ([ SetMoonWalkSquare with: 3]
	                  -> moonWalkSquareProbability ) }.
	aBoard := Board
		          with: fiveSquares
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
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareThenAllTheOtherShipsMoveAccordingWithTheSquareMagnitude [


	| expectedPosition aBlueShip fiveSquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame moonWalkSquareProbability |
	
	expectedPosition := Position at: 6 in: 1.
	fiveSquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	moonWalkSquareProbability := 1.

	aDistribution := { ([ SetMoonWalkSquare with: 2]
	                  -> moonWalkSquareProbability ) }.
	aBoard := Board
		          with: fiveSquares
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

	self assert: (aBlackShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
MoonWalkTest >> testWhenAShipLandsOnAMoonWalkSquareThenItDoesNotMove [


	| expectedPosition aBlueShip fiveSquares sideToRoll oneLap aWormHole aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame moonWalkSquareProbability |
	
	expectedPosition := Position at: 1 in: 1.
	fiveSquares := 20.
	sideToRoll := 1.
	oneLap := 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	moonWalkSquareProbability := 1.

	aDistribution := { ([ MoonWalkSquare between: 1 and: 2]
	                  -> moonWalkSquareProbability ) }.
	aBoard := Board
		          with: fiveSquares
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

	self assert: (aBlueShip currentPosition equals: expectedPosition)
]
