Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
GameTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
GameTest >> testWhenAPlayerTriesToRollTheDicesWhenTheGameHasFinishedThenItFails [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 5.
	oneLap := 1.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
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
	self
		should: [ aGame nextTurnPlay ]
		raise: Error
		withMessageText: 'The game has finished.'
]

{ #category : 'tests' }
GameTest >> testWhenAShipCompletesTheRequiredAmountOfLapsThenItwinsTheGame [

	| fiveSquares aWormHole aGame expectedDetails sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices fourLaps aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 10.
	fourLaps := 4.

	expectedDetails := 'Winner: BlueShip' , String cr
	                   , 'BlueShip: Lap: 5 Square: 0' , String cr
	                   , 'BlackShip: Lap: 3 Square: 0'.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
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
		         for: fourLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: aGame printBoard equals: expectedDetails
]

{ #category : 'tests' }
GameTest >> testWhenAShipGoesThroughTheLastSquareButLandsOnABlackHoleSquareThenTheEffectIsAppliedAndTheGameDoesNotEnd [

	| expectedPosition twentySquares sideToRoll twoLaps aWormHole aBlueShip aBlackShip aLoadedDice aDistribution aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity aBlackHoleSquare aProbability aBlackHoleSquareProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 4.
	twoLaps := 2.

	expectedPosition := Position at: 18 in: 1.

	aWormHole := WormHole between: 4 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbability := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aBlackHoleSquare
		                                  with: aProbability.
	aDistributionBuilder add: aBlackHoleSquareProbabilisticEvent.
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
		         for: twoLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self deny: aGame hasFinished.
	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
GameTest >> testWhenAShipMakesOneLapOnTheBoardThenThePositionChangesAccordingly [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aSetDice twoLaps aBlackShip sideToRoll aGame expectedPosition aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 6.
	twoLaps := 2.

	expectedPosition := Position at: 1 in: 2.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aSetDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aSetDice.

	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: twoLaps
		         and: someShips
		         and: someDices
		         and: aFuelQuantity.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
GameTest >> testWhenAShipMovesOneSquareThenTheBoardIsPrintedCorrectly [

	| fiveSquares aWormHole aGame expectedDetails sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 1.
	oneLap := 1.

	expectedDetails := 'Winner: There is not a winner yet' , String cr
	                   , 'BlueShip: Lap: 1 Square: 1' , String cr
	                   , 'BlackShip: Lap: 1 Square: 0'.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
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

	self assert: aGame printBoard equals: expectedDetails
]

{ #category : 'tests' }
GameTest >> testWhenAShipReachesTheFinalSquareThenTheGameEnds [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.
	aBoard := Board
		          with: fiveSquares
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
	aGame nextTurnPlay.

	self assert: aGame hasFinished
]

{ #category : 'tests' }
GameTest >> testWhenTheGameEndsThenTheWinnerIsShownOnTheLeaderBoard [

	| fiveSquares aWormHole aGame expectedDetails sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices oneLap aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 3.
	oneLap := 1.

	expectedDetails := 'Winner: BlueShip' , String cr
	                   , 'BlueShip: Lap: 2 Square: 0' , String cr
	                   , 'BlackShip: Lap: 1 Square: 2'.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
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
	aGame nextTurnPlay.

	self assert: aGame printBoard equals: expectedDetails
]

{ #category : 'tests' }
GameTest >> testWhenTheGameIsCreatedWithOneDiceThenAllTheShipsFuelEqualsToTheMaximumRolledNumberTimesTwo [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices oneLap twoSides aTwoSidedDice aBlackShip maximumRolledNumber aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	twoSides := 2.
	oneLap := 1.

	maximumRolledNumber := twoSides.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aTwoSidedDice := Dice with: twoSides.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aTwoSidedDice.
	
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	Game
		with: aBoard
		for: oneLap
		and: someShips
		and: someDices
		and: aFuelQuantity.

	self assert: (aBlueShip fuelEquals: maximumRolledNumber * 2).
	self assert: (aBlackShip fuelEquals: maximumRolledNumber * 2)
]

{ #category : 'tests' }
GameTest >> testWhenTheGameIsCreatedWithTwoDicesThenAllTheShipsFuelEqualsToTheMaximumRolledNumberTimesTwo [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices oneLap twoSides aTwoSidedDice aFourSidedDice fourSides aBlackShip maximumRolledNumber aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	twoSides := 2.
	fourSides := 4.
	oneLap := 1.

	maximumRolledNumber := twoSides + fourSides.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aTwoSidedDice := Dice with: twoSides.
	aFourSidedDice := Dice with: fourSides.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aTwoSidedDice.
	someDices add: aFourSidedDice.
	
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	Game
		with: aBoard
		for: oneLap
		and: someShips
		and: someDices
		and: aFuelQuantity.

	self assert: (aBlueShip fuelEquals: maximumRolledNumber * 2).
	self assert: (aBlackShip fuelEquals: maximumRolledNumber * 2)
]

{ #category : 'tests' }
GameTest >> testWhenTheHyperJumpParsecsDoNotEqualTheLengthOfTheBoardThenInvalid [

	| twentySquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution someParsecs aRatio aDistributionBuilder aFuelQuantity aHyperJumpSquare aProbability aHyperJumpSquareProbabilisticEvent |
	twentySquares := 20.
	sideToRoll := 2.
	oneLap := 1.
	aRatio := 2.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	someParsecs := #( 5 5 5 6 ) asOrderedCollection.

	aDistributionBuilder := DistributionBuilder new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbability := 1.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbability.
	aDistributionBuilder add: aHyperJumpSquareProbabilisticEvent.
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

	self
		should: [
			Game
				with: aBoard
				for: oneLap
				and: someShips
				and: someDices
				and: aFuelQuantity ]
		raise: Error
		withMessageText:
		'The magnitude of the Hyper Jump Square Parsecs is not valid.'
]

{ #category : 'tests' }
GameTest >> testWhenThereAreLessThanTwoShipsThenTheGameIsInvalid [

	| fiveSquares aWormHole aBlueShip aLoadedDice sideToRoll aBoard someShips someDices oneLap aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	sideToRoll := 2.
	oneLap := 1.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someDices add: aLoadedDice.
	
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	self
		should: [
			Game
				with: aBoard
				for: oneLap
				and: someShips
				and: someDices
				and: aFuelQuantity ]
		raise: Error
		withMessageText: 'The Game needs at least two ship to start.'
]

{ #category : 'tests' }
GameTest >> testWhenThereAreNotAnyDicesThenTheGameIsInvalid [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices oneLap aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	oneLap := 1.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	self
		should: [
			Game
				with: aBoard
				for: oneLap
				and: someShips
				and: someDices
				and: aFuelQuantity ]
		raise: Error
		withMessageText: 'The Game needs at least one dice to start.'
]

{ #category : 'tests' }
GameTest >> testWhenThereIsAHyperGravitySquareWithACorrectMagnitudeThenIsValid [

	| tenSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution aDistributionBuilder expectedPosition aGame aFuelQuantity aHyperGravitySquare aProbability aHyperGravitySquareProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 2.
	oneLap := 1.

	expectedPosition := Position at: 4 in: 1.

	aWormHole := WormHole between: 7 and: 8.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aHyperGravitySquare := HyperGravitySquare between: 1 and: 2.
	aProbability := 1.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with: aProbability.
	aDistributionBuilder add: aHyperGravitySquareProbabilisticEvent.
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
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
GameTest >> testWhenThereIsAHyperGravitySquareWithMagnitudeGreaterThanTheMaximumRollThenInvalid [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aDice twoSides oneLap aBlackShip aDistribution aDistributionBuilder aFuelQuantity aHyperGravitySquare aProbability aHyperGravitySquareProbabilisticEvent |
	fiveSquares := 5.
	twoSides := 2.
	oneLap := 1.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aDice := Dice with: twoSides.

	aDistributionBuilder := DistributionBuilder new.
	aHyperGravitySquare := HyperGravitySquare between: 5 and: 7.
	aProbability := 1.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with: aProbability.
	aDistributionBuilder add: aHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aDice.
	
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	self
		should: [
			Game
				with: aBoard
				for: oneLap
				and: someShips
				and: someDices
				and: aFuelQuantity ]
		raise: Error
		withMessageText:
		'The magnitude of the Hyper Gravity Square is grater than the maximum roll.'
]

{ #category : 'tests' }
GameTest >> testWhenThereIsLessThanOneLapThenTheGameIsInvalid [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aDice twoSides zeroLaps aBlackShip aDistributionBuilder aDistribution aFuelQuantity aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	fiveSquares := 5.
	twoSides := 2.
	zeroLaps := 0.

	aWormHole := WormHole between: 1 and: 2.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aDice := Dice with: twoSides.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aDice.
	
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	self
		should: [
			Game
				with: aBoard
				for: zeroLaps
				and: someShips
				and: someDices
				and: aFuelQuantity ]
		raise: Error
		withMessageText: 'The Game needs at least one lap to start.'
]
