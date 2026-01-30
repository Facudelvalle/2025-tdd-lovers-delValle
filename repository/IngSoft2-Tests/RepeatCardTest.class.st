Class {
	#name : 'RepeatCardTest',
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
		'aRepeatCard',
		'aRepeatCardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'aNullCard',
		'aPlainSquare',
		'aPlainSquareProbabilisticEvent',
		'anAffectedSquaresPosition',
		'aBlackHoleSquare',
		'aBlackHoleSquareProbabilisticEvent',
		'aDistributionManager',
		'aSetCardManager',
		'anAtomicBombSquareProbabilisticEvent',
		'anAtomicBombSquare',
		'someDices',
		'aCardSquare',
		'aCardSquareProbabilisticEvent',
		'aHyperGavitySquare',
		'aHyperGavitySquareOfFourProbabilisticEvent',
		'aRatioOfOne',
		'someParsecs',
		'aParsecJumpOfFive',
		'aParsecJumpOfTen',
		'aMoonWalkSquare',
		'aMoonWalkSquareOfOneProbabilisticEvent',
		'anAllyCard',
		'anAllyCardProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RepeatCardTest >> setUp [

	super setUp.

	twentySquares := 20.

	aRatioOfOne := 1.

	aSetCardManager := SetProbablisiticEventsManager new.

	aDistributionManager := ProbablisiticEventsManager new.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aProbabilityOfOne := 1.

	aPlainSquare := PlainSquare new.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                 for: aRepeatCard
		                                 with: aProbabilityOfOne.
	aCardManager add: aRepeatCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setAvailableCards: aCardManager.
	aGameBuilder setRewards: aRewardManager.

	aNullCard := NullCard new.

	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.

	anAtomicBombSquare := AtomicBombSquare new.
	anAtomicBombSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: anAtomicBombSquare
		                                        with: aProbabilityOfOne.

	aCardSquare := CardSquare new.
	aCardSquareProbabilisticEvent := ProbabilisticEvent
		                                 for: aCardSquare
		                                 with: aProbabilityOfOne.

	aHyperGavitySquare := HyperGravitySquare between: 4 and: 4.
	aHyperGavitySquareOfFourProbabilisticEvent := ProbabilisticEvent
		                                              for:
		                                              aHyperGavitySquare
		                                              with:
		                                              aProbabilityOfOne.

	aParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfTen := Parsec with: 10.
	someParsecs := OrderedCollection new.

	aMoonWalkSquare := MoonWalkSquare between: 1 and: 1.
	aMoonWalkSquareOfOneProbabilisticEvent := ProbabilisticEvent
		                                          for: aMoonWalkSquare
		                                          with: aProbabilityOfOne.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne
]

{ #category : 'asserting' }
RepeatCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAfterAShipMovesThenTheCardDoesntApplyAnyEffect [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
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
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsABackHoleEffectThenItIsAppliedCorrectly [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 2 upTo: 20 in: HasFuelState new.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
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
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsACardEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice aDistribution aBoard aGame expectedSize |
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	expectedSize := 2.

	aDistributionManager add: aCardSquareProbabilisticEvent.
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

	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	self assert: aBlackShip amountOfCards equals: expectedSize
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAHyperGavityEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sidesToRoll := #( 2 5 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	expectedPosition := Position at: 7 in: 1.
	expectedFuel := Fuel with: 3 upTo: 10 in: HasFuelState new.

	aDistributionManager add: aHyperGavitySquareOfFourProbabilisticEvent.
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
	aGame nextTurnPass.
	aGame nextTurnPlay.

	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAHyperJumpEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	sidesToRoll := #( 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	expectedPosition := Position at: 17 in: 1.
	expectedFuel := Fuel with: 3 upTo: 20 in: HasFuelState new.

	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTen.

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
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAMoonWalkEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 17 upTo: 20 in: HasFuelState new.

	aDistributionManager add: aMoonWalkSquareOfOneProbabilisticEvent.
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
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsANullEffectThenItIsAppliedCorrectly [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
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
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAnAtomicBombEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	expectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 18 upTo: 20 in: HasFuelState new.

	aDistributionManager add: anAtomicBombSquareProbabilisticEvent.
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
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardThenItIsNoLongerInItsHand [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedCards |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedCards := OrderedCollection new.
	expectedCards add: aRepeatCard.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
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
		play: aRepeatCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardWhenIsNotItsTurnThenItsEffectIsAppliedCorrectly [

	| sideToRoll aLoadedDice aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
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
	aGame nextTurnPass.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipTriesToPlayARepeatCardThatIsNotInItsHandThenInvalid [

	| aGame sideToRoll aLoadedDice aBoard aDistribution |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager := ProbablisiticEventsManager new.
	aCardManager add: anAllyCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aRepeatCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]
