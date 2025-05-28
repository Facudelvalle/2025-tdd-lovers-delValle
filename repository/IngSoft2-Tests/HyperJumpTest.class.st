Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
HyperJumpTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
HyperJumpTest >> testWhenASecondShipTakesAHyperJumpSquareThatWasTakenBeforeThenItTakesTheSecondParsecValueAndMovesAccordingly [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame expectedPosition aRatio |
	twentySquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.
	expectedPosition := Position at: 12 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	someParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: someParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
	aBoard := Board
		          with: twentySquares
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

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHiperJumpSquareAndAfterTheJumpItGoesThroughTheFinalSquareThenTheGameEnds [

	| tenSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame aRatio |
	tenSquares := 10.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.

	aWormHole := WormHole between: 3 and: 4.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	someParsecs := #( 5 3 2 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: someParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
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

	self assert: aGame hasFinished
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHiperJumpSquareAndIncrementALapThenItsPositionChangesAccordingly [

	| tenSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll threeLap aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame expectedPosition aRatio aDistributionBuilder |
	tenSquares := 10.
	sideToRoll := 7.
	threeLap := 3.
	aRatio := 1.
	expectedPosition := Position at: 2 in: 2.

	aWormHole := WormHole between: 3 and: 4.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.
	someParsecs := #( 5 3 2 ) asOrderedCollection.
	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder hyperJumpProbabilityIs: 1.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder hyperJumpWith: someParsecs and: aRatio. 
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
		         for: threeLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHiperJumpSquareThenItsFuellsConsumedCorrectly [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame expectedPosition aRatio |
	twentySquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.
	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	someParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: someParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
	aBoard := Board
		          with: twentySquares
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

	self assert: (aBlueShip fuelEquals: 1)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareThenTheShipMovesCorrectly [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame expectedPosition aRatio |
	twentySquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.
	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.

	someParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: someParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
	aBoard := Board
		          with: twentySquares
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
HyperJumpTest >> testWhenAllTheParsecsHadBeenTakenThenTheNextShipTakesTheFirstParsecAgain [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame expectedPosition aWhiteShip aRedShip aPinkShip aRatio |
	twentySquares := 20.
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

	someParsecs := #( 6 5 5 4 ) asOrderedCollection.

	aDistribution := { ([
	                  HyperJumpSquare
		                  with: someParsecs
		                  and: aRatio ] -> hyperJumpSquareProbability) }.
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someShips add: aRedShip.
	someShips add: aWhiteShip.
	someShips add: aPinkShip.
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
	aGame nextTurnPlay.

	self assert: (aPinkShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenTheRatioIsTwoAndAShipTakesAHyperJumpThenItsMovesCorrectly [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll threeLaps aBlackShip aDistribution hyperJumpSquareProbability someParsecs aGame expectedPosition aRatio |
	twentySquares := 20.
	sideToRoll := 7.
	threeLaps := 3.
	aRatio := 2.
	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.
	
	someParsecs := #( 2 2 3 3) asOrderedCollection.

	aDistribution := { ([ HyperJumpSquare with: someParsecs and: aRatio]
	                  -> hyperJumpSquareProbability) }.
	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	
	aGame := Game
		         with: aBoard
		         for: threeLaps
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)

]
