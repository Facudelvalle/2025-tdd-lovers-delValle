Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpTest >> testWhenAParsecRepresentTwoSquaresAndAShipTakesAHyperJumpThenItsMovesCorrectly [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability aCollectionofParsecs aGame expectedPosition aRatio |
	fiveSquares := 20.
	sideToRoll := 7.
	oneLap := 3.
	aRatio := 2.
	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.
	
	aCollectionofParsecs := #( 2 2 3 3) asOrderedCollection.

	aDistribution := { ([ HyperJumpSquare with: aCollectionofParsecs and: aRatio]
	                  -> hyperJumpSquareProbability) }.
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

	self assert: (aBlueShip currentPosition equals: expectedPosition)

]

{ #category : 'tests' }
HyperJumpTest >> testWhenASecondShipTakesAHiperJumpSquareThatWasTakenBefore [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability aCollectionofParsecs aGame expectedPosition aRatio |
	fiveSquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.
	expectedPosition := Position at: 12 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	aCollectionofParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: aCollectionofParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
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

	self assert: (aBlackShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAllTheParsecHasBeenTakenThenTheNextShipTakeTheFistParsec [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability aCollectionofParsecs aGame expectedPosition aWhiteShip aRedShip aPinkShip aRatio |
	fiveSquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.
	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aWhiteShip := Ship called: 'WhiteShip'.
	aRedShip := Ship called: 'RedShip'.
	aPinkShip := Ship called: 'PinkShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	aCollectionofParsecs := #( 6 4 6 4 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: aCollectionofParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
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

	self assert: (aBlackShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenThereAShipTakesAHiperJumpSquareAndIncrementALap [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability aCollectionofParsecs aGame expectedPosition aRatio |
	fiveSquares := 10.
	sideToRoll := 7.
	oneLap := 3.
	aRatio := 1.
	expectedPosition := Position at: 2 in: 2.

	aWormHole := WormHole between: 3 and: 4.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	aCollectionofParsecs := #( 5 3 2 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: aCollectionofParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
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

	self assert: (aBlueShip currentPosition equals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenThereAShipTakesAHiperJumpSquareThenTheShipMovesCorrectly [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability aCollectionofParsecs aGame expectedPosition aRatio |
	fiveSquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.
	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	aCollectionofParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: aCollectionofParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
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

	self assert: (aBlueShip currentPosition equals: expectedPosition)
]
