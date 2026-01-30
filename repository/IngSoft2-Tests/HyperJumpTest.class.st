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
		'aNullCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
HyperJumpTest >> setUp [

	super setUp.

	twentySquares := 20.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfFour := Parsec with: 4.
	aParsecJumpOfSix := Parsec with: 6.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.


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

	| aBoard sideToRoll aDistribution someParsecs aGame expectedPosition aRatio aDistributionManager aHyperJumpSquare aPlainSquareProbabilisticEvent aParsecJumpOfFive aParsecJumpOfFour aParsecJumpOfSix anotherParsecJumpOfFive aLoadedDice someDices |

	sideToRoll := #(7) asOrderedCollection.
	aRatio := 1.

	expectedPosition := Position at: 12 in: 1.

	aLoadedDice := LoadedDice toRoll: sideToRoll.
	
	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfFour := Parsec with: 4.
	aParsecJumpOfSix := Parsec with: 6.
	anotherParsecJumpOfFive := Parsec with: 5.	
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: anotherParsecJumpOfFive.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
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

	| aBoard someDices aLoadedDice sideToRoll aDistribution someParsecs aGame expectedFuel aRatio aDistributionManager aHyperJumpSquare aPlainSquareProbabilisticEvent anAffectedSquaresPosition |
	sideToRoll := #( 7 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	aRatio := 1.

	expectedFuel := Fuel with: 8 upTo: 14 in: HasFuelState new.

	anAffectedSquaresPosition := Position at: 7 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: aParsecJumpOfFive.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
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

	| tenSquares aBoard someDices aLoadedDice sideToRoll  aDistribution someParsecs aGame aRatio aDistributionManager aHyperJumpSquare  aPlainSquareProbabilisticEvent  aParsecJumpOfFive aParsecJumpOfThree aParsecJumpOfTwo |
	tenSquares := 10.
	sideToRoll := #( 7 ) asOrderedCollection.
	aRatio := 1.

	aWormHole := WormHole between: 3 and: 4.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfThree := Parsec with: 3.
	aParsecJumpOfTwo := Parsec with: 2.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.


	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: aGame hasFinished
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAShipTakesAHyperJumpSquareAndIncrementALapThenItsPositionChangesAccordingly [

	| tenSquares  aBoard  someDices aLoadedDice sideToRoll threeLaps aDistribution someParsecs aGame expectedPosition aRatio aDistributionManager aHyperJumpSquare  aPlainSquareProbabilisticEvent  aParsecJumpOfFive aParsecJumpOfThree aParsecJumpOfTwo |
	tenSquares := 10.
	sideToRoll := #( 7 ) asOrderedCollection.
	threeLaps := 3.
	aRatio := 1.

	expectedPosition := Position at: 2 in: 2.

	aWormHole := WormHole between: 3 and: 4.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfThree := Parsec with: 3.
	aParsecJumpOfTwo := Parsec with: 2.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
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

	|  aBoard someDices aLoadedDice sideToRoll aDistribution someParsecs aGame expectedFuel aRatio aDistributionManager aHyperJumpSquare aPlainSquareProbabilisticEvent aParsecJumpOfFive aParsecJumpOfFour aParsecJumpOfSix anotherParsecJumpOfFive |

	sideToRoll := #( 7 ) asOrderedCollection.
	aRatio := 1.

	expectedFuel := Fuel with: 1 upTo: 14 in: HasFuelState new.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfFour := Parsec with: 4.
	aParsecJumpOfSix := Parsec with: 6.
	anotherParsecJumpOfFive := Parsec with: 5.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: anotherParsecJumpOfFive.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	
	someDices := OrderedCollection new.
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

	|  aBoard  someDices aLoadedDice sideToRoll oneLap aDistribution someParsecs aGame expectedPosition aRatio aDistributionBuilder aHyperJumpSquare  aPlainSquareProbabilisticEvent  aParsecJumpOfFive aParsecJumpOfFour aParsecJumpOfSix anotherParsecJumpOfFive |

	sideToRoll := #( 7 ) asOrderedCollection.
	oneLap := 1.
	aRatio := 1.

	expectedPosition := Position at: 13 in: 1.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfFour := Parsec with: 4.
	aParsecJumpOfSix := Parsec with: 6.
	anotherParsecJumpOfFive := Parsec with: 5.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: anotherParsecJumpOfFive.

	aDistributionBuilder := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperJumpTest >> testWhenAllTheParsecsHaveBeenTakenThenTheNextShipTakesTheFirstParsecAgain [

	| aBoard someDices aLoadedDice sideToRoll oneLap  aDistribution someParsecs aGame expectedPosition aWhiteShip aRedShip aPinkShip aRatio aDistributionBuilder aHyperJumpSquare aPlainSquareProbabilisticEvent aParsecJumpOfFive aParsecJumpOfFour aParsecJumpOfSix anotherParsecJumpOfFive |

	sideToRoll := #( 7 ) asOrderedCollection.
	oneLap := 1.
	aRatio := 1.

	expectedPosition := Position at: 13 in: 1.

	aWhiteShip := Ship called: 'WhiteShip'.
	aRedShip := Ship called: 'RedShip'.
	aPinkShip := Ship called: 'PinkShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfFour := Parsec with: 4.
	aParsecJumpOfSix := Parsec with: 6.
	anotherParsecJumpOfFive := Parsec with: 5.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFour.
	someParsecs add: aParsecJumpOfSix.
	someParsecs add: anotherParsecJumpOfFive.

	aDistributionBuilder := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	
	someDices := OrderedCollection new.
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

	| aBoard someDices aLoadedDice sideToRoll threeLaps aDistribution someParsecs aGame expectedPosition aRatio aDistributionManager aHyperJumpSquare aHyperJumpSquareProbabilisticEvent aParsecJumpOfTwo anotherParsecJumpOfTwo aParsecJumpOfThree anotherParsecJumpOfThree |
	sideToRoll := #( 7 ) asOrderedCollection.
	threeLaps := 3.
	aRatio := 2.

	expectedPosition := Position at: 13 in: 1.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aParsecJumpOfTwo := Parsec with: 2.
	anotherParsecJumpOfTwo := Parsec with: 2.
	aParsecJumpOfThree := Parsec with: 3.
	anotherParsecJumpOfThree := Parsec with: 3.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: anotherParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.
	someParsecs add: anotherParsecJumpOfThree.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
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

	| aBoard someDices aLoadedDice sideToRoll threeLaps aDistribution someParsecs aGame expectedPosition aRatio aDistributionManager aHyperJumpSquare  aPlainSquareProbabilisticEvent aLightYearJump aParsecJump anotherLightYearJump anotherParsecJump |
	sideToRoll := #(7) asOrderedCollection.
	threeLaps := 3.
	aRatio := 2.

	expectedPosition := Position at: 13 in: 1.

	aLoadedDice := LoadedDice toRoll: sideToRoll.
	
	aLightYearJump := LightYear with: 6.
	aParsecJump := Parsec with: 2.
	anotherLightYearJump := LightYear with: 9.
	anotherParsecJump := Parsec with: 3.
	
	someParsecs := OrderedCollection new.
	
	someParsecs add: aLightYearJump.
	someParsecs add: aParsecJump.
	someParsecs add: anotherLightYearJump.
	someParsecs add: anotherParsecJump.


	aDistributionManager := ProbablisiticEventsManager new.
	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aHyperJumpSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setLaps: threeLaps.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
