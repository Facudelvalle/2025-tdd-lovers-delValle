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

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution someParsecs aGame expectedPosition aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.

	expectedPosition := Position at: 12 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
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
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareAndAfterTheJumpItGoesThroughTheFinalSquareThenTheGameEnds [

	| tenSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution someParsecs aGame aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.

	aWormHole := WormHole between: 3 and: 4.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 5 3 2 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
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
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: aGame hasFinished
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareAndIncrementALapThenItsPositionChangesAccordingly [

	| tenSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll threeLaps aBlackShip aDistribution someParsecs aGame expectedPosition aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 7.
	threeLaps := 3.
	aRatio := 1.

	expectedPosition := Position at: 2 in: 2.

	aWormHole := WormHole between: 3 and: 4.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 5 3 2 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
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
		         for: threeLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareThenItsFuelIsConsumedCorrectly [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution someParsecs aGame expectedFuel aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.

	expectedFuel := 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
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
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAllTheParsecsHaveBeenTakenThenTheNextShipTakesTheFirstParsecAgain [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution someParsecs aGame expectedPosition aWhiteShip aRedShip aPinkShip aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
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

	someParsecs := #( 6 5 5 4 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.
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

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aPinkShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenTheHyperJumpParsecsDoNotEqualTheLengthOfTheBoardThenInvalid [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution someParsecs aGame expectedPosition aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	aRatio := 1.

	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 5 4 6 5 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
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
HyperJumpTest >> testWhenTheRatioIsTwoAndAShipTakesAHyperJumpThenItsMovesCorrectly [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll threeLaps aBlackShip aDistribution someParsecs aGame expectedPosition aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 7.
	threeLaps := 3.
	aRatio := 2.

	expectedPosition := Position at: 13 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 2 2 3 3 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
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
		         for: threeLaps 
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
