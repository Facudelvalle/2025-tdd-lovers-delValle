Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aProbabilityOfOne',
		'aCardManager',
		'someShips',
		'aGameBuilder',
		'aParsecJumpOfFive',
		'aParsecJumpOfFour',
		'aParsecJumpOfSix',
		'aReversePolarityCard',
		'aReversePolarityCardProbabilisticEvent',
		'aNullCard',
		'aRatioOfOne',
		'aRatioOfTwo',
		'aDistributionManager',
		'someDices',
		'aParsecJumpOfThree',
		'aParsecJumpOfTwo',
		'tenSquares',
		'threeLaps',
		'aLightYearJumpOfSix',
		'aLightYearJumpOfNine'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
HyperJumpTest >> setUp [

	super setUp.

	twentySquares := 20.
	tenSquares := 10.

	threeLaps := 3.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfFour := Parsec with: 4.
	aParsecJumpOfSix := Parsec with: 6.
	aParsecJumpOfThree := Parsec with: 3.
	aParsecJumpOfTwo := Parsec with: 2.
	aLightYearJumpOfSix := LightYear with: 6.
	aLightYearJumpOfNine := LightYear with: 9.

	aRatioOfOne := 1.
	aRatioOfTwo := 2.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.


	aProbabilityOfOne := 1.
	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.
	aCardManager add: aReversePolarityCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	someDices := OrderedCollection new.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.

	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.

	aNullCard := NullCard new
]

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

	| aBoard sideToRoll aDistribution someParsecs aGame expectedPosition aHyperJumpSquare aHyperJumpSquareProbabilisticEvent aLoadedDice |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 12 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipLandsOnAnInvertedHyperJumpSquareThenTheOtherShipsFuelIsConsumedCorrectly [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedFuel aHyperJumpSquare aHyperJumpSquareProbabilisticEvent anAffectedSquaresPosition |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedFuel := Fuel with: 8 upTo: 14 in: HasFuelState new.

	anAffectedSquaresPosition := Position at: 7 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlackShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareAndAfterTheJumpItGoesThroughTheFinalSquareThenTheGameEnds [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aWormHole := WormHole between: 3 and: 4.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: aGame hasFinished
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareAndIncrementALapThenItsPositionChangesAccordingly [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedPosition aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 2 in: 2.

	aWormHole := WormHole between: 3 and: 4.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: threeLaps.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareThenItsFuelIsConsumedCorrectly [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedFuel aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedFuel := Fuel with: 1 upTo: 14 in: HasFuelState new.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.
		
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.
		
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpThenItsMovesAccordingly [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedPosition aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 13 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAllTheParsecsHaveBeenTakenThenTheNextShipTakesTheFirstParsecAgain [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedPosition aWhiteShip aRedShip aPinkShip aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 13 in: 1.

	aWhiteShip := Ship called: 'WhiteShip'.
	aRedShip := Ship called: 'RedShip'.
	aPinkShip := Ship called: 'PinkShip'.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips add: aRedShip.
	someShips add: aWhiteShip.
	someShips add: aPinkShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aPinkShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenTheRatioIsTwoAndAShipTakesAHyperJumpThenItsMovesCorrectly [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedPosition aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 13 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.
	someParsecs add: aParsecJumpOfThree.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfTwo.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: threeLaps.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenTheRatioIsTwoAndHasLightYearsThenItsMovesCorrectly [

	| aBoard aLoadedDice sideToRoll aDistribution someParsecs aGame expectedPosition aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 13 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aLightYearJumpOfSix.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aLightYearJumpOfNine.
	someParsecs add: aParsecJumpOfThree.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfTwo.

	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.

	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: threeLaps.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
