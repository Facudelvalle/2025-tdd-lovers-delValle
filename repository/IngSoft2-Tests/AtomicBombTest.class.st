Class {
	#name : 'AtomicBombTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenAllTheOtherShipsFuelDoesNotChange [

	| tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame expectedFuel aDistributionBuilder aFuelQuantity anAtomicBombSquare aProbability anAtomicBombProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.

	expectedFuel := 4.

	aWormHole := WormHole between: 3 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbability := 1.
	anAtomicBombProbabilisticEvent := ProbabilisticEvent for: anAtomicBombSquare with: aProbability.
	aDistributionBuilder add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: twoLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheBoard [

	| expectedPosition twentySquares sideToRoll oneLap aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity anAtomicBombProbabilisticEvent anAtomicBombSquare aProbability |
	twentySquares := 20.
	sideToRoll := 2.
	oneLap := 1.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 7 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbability := 1.

	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbability.
	aDistributionBuilder add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItGoesBackToTheFirstSquareOfTheCurrentLap [

	| expectedPosition tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity anAtomicBombSquare aProbability anAtomicBombProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.

	expectedPosition := Position at: 0 in: 2.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbability := 1.

	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbability.
	aDistributionBuilder add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: twoLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenItsFuelDoesNotChange [

	| tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame expectedFuel aDistributionBuilder aFuelQuantity anAtomicBombSquare aProbability anAtomicBombProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.

	expectedFuel := 2.

	aWormHole := WormHole between: 3 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbability := 1.

	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbability.
	aDistributionBuilder add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: twoLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
AtomicBombTest >> testWhenAShipLandsOnAnAtomicBombSquareThenTheOtherShipsGoBackToTheFirstSquareOfTheirCurrentLap [

	| expectedPosition tenSquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity anAtomicBombSquare aProbability anAtomicBombProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 2.
	twoLaps := 2.

	expectedPosition := Position at: 0 in: 1.

	aWormHole := WormHole between: 2 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	anAtomicBombSquare := AtomicBombSquare new.
	aProbability := 1.

	anAtomicBombProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbability.
	aDistributionBuilder add: anAtomicBombProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.
	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: twoLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]
