Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenAllTheOthersShipFuelDoNotChange [

	| fiveSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice atomicBombSquareProbability aDistribution aBoard someShips someDices aGame expectedFuel |
	fiveSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.
	expectedFuel := 4.

	aWormHole := WormHole between: 3 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	atomicBombSquareProbability := 1.

	aDistribution := { ([ AtomicBombSquare new]
	                  -> atomicBombSquareProbability ) }.
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
		         for: twoLaps 
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	
	self assert: aBlackShip fuelLeft equals: expectedFuel
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheBoard [

	| expectedPosition fiveSquares sideToRoll oneLap aWormHole aBlueShip aBlackShip aLoadedDice atomicBombSquareProbability aDistribution aBoard someShips someDices aGame |
	expectedPosition := Position at: 0 in: 1.
	fiveSquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 7 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	atomicBombSquareProbability := 1.

	aDistribution := { ([ AtomicBombSquare new]
	                  -> atomicBombSquareProbability ) }.
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

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheCurrentLap [

	| expectedPosition fiveSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice atomicBombSquareProbability aDistribution aBoard someShips someDices aGame |
	expectedPosition := Position at: 0 in: 2.
	fiveSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	atomicBombSquareProbability := 1.

	aDistribution := { ([ AtomicBombSquare new]
	                  -> atomicBombSquareProbability ) }.
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
		         for: twoLaps 
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	
	self assert: (aBlueShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItsFuelDoesNotChange [

	| fiveSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice atomicBombSquareProbability aDistribution aBoard someShips someDices aGame expectedFuel |
	fiveSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.
	expectedFuel := 2.

	aWormHole := WormHole between: 3 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	atomicBombSquareProbability := 1.

	aDistribution := { ([ AtomicBombSquare new]
	                  -> atomicBombSquareProbability ) }.
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
		         for: twoLaps 
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	
	self assert: aBlueShip fuelLeft equals: expectedFuel
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenTheOtherShipsGoBackToTheFirstSquareOfTheirCurrentLap [

	| expectedPosition fiveSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice atomicBombSquareProbability aDistribution aBoard someShips someDices aGame |
	expectedPosition := Position at: 0 in: 1.
	fiveSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	atomicBombSquareProbability := 1.

	aDistribution := { ([ AtomicBombSquare new]
	                  -> atomicBombSquareProbability ) }.
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
		         for: twoLaps 
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	
	self assert: (aBlackShip currentPosition equals: expectedPosition)
]
