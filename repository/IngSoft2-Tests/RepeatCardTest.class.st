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
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'aPlainSquare',
		'aPlainSquareProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RepeatCardTest >> setUp [

	super setUp.

	twentySquares := 20.

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

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.

	aNullCard := NullCard new
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

	| sideToRoll aLoadedDice someDices aDistributionManager aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsABackHoleEfectThenItIsAppliedCorrectly [

	| sideToRoll aLoadedDice someDices aDistributionManager aBlackHoleSquare aBlackHoleSquareProbabilisticEvent aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.
	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 2 upTo: 20 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsACardEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice someDices aDistributionManager aCardSquare aCardSquareProbabilisticEvent aDistribution aBoard aGame expectedSize |
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.
	aCardSquare := CardSquare new.
	aCardSquareProbabilisticEvent := ProbabilisticEvent
		                                 for: aCardSquare
		                                 with: aProbabilityOfOne.
	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedSize := 2.

	aGame nextTurnPlay.

	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPass.

	self assert: aBlackShip amountOfCards equals: expectedSize
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAMoonWalkEfectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice someDices aDistributionManager aMoonWalkSquare aMoonWalkSquareProbabilisticEvent aDistribution aBoard aGame expectedPosition expectedFuel |
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.
	aMoonWalkSquare := MoonWalkSquare between: 1 and: 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 17 upTo: 20 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsANullEfectThenItIsAppliedCorrectly [

	| sideToRoll aLoadedDice someDices aDistributionManager aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAnAtomicBombEffectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice someDices aDistributionManager anAtomicBombSquare anAtomicBombSquareProbabilisticEvent aDistribution aBoard aGame expectedPosition expectedFuel |
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.
	anAtomicBombSquare := AtomicBombSquare new.
	anAtomicBombSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: anAtomicBombSquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 18 upTo: 20 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAnHyperGavityEfectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice someDices aDistributionManager aHyperGavitySquare aHyperGavitySquareProbabilisticEvent aDistribution aBoard aGame expectedPosition expectedFuel |
	sidesToRoll := #( 2 5 2 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperGavitySquare := HyperGravitySquare between: 4 and: 4.
	aHyperGavitySquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aHyperGavitySquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: aHyperGavitySquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 7 in: 1.
	expectedFuel := Fuel with: 3 upTo: 10 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAnHyperJumpEfectThenItIsAppliedCorrectly [

	| sidesToRoll aLoadedDice someDices aDistributionManager aHyperJumpSquare aHyperJumpSquareProbabilisticEvent aDistribution aBoard aGame expectedPosition expectedFuel aRatio aParsecJumpOfFive anotherParsecJumpOfFive aParsecJumpOfTen someParsecs |
	sidesToRoll := #( 2 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aRatio := 1.
	aParsecJumpOfFive := Parsec with: 5.
	anotherParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfTen := Parsec with: 10.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: anotherParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTen.

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

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 17 in: 1.
	expectedFuel := Fuel with: 3 upTo: 20 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardThenItIsNoLongerInItsHand [

	| sideToRoll aLoadedDice someDices aDistributionManager aDistribution aBoard aGame expectedCards |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.
	expectedCards add: aRepeatCard.

	aGame
		play: aRepeatCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardWhenIsNotItsTurnThenItsEffectIsAppliedCorrectly [

	| sideToRoll aLoadedDice someDices aDistributionManager aDistribution aBoard aGame expectedPosition expectedFuel |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistributionManager := ProbablisiticEventsManager new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipTriesToPlayARepeatCardThatIsNotInItsHandThenInvalid [

	| aGame sideToRoll aLoadedDice aBoard someDices aDistributionManager aDistribution anAllyCard anAllyCardProbabilisticEvent |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aRepeatCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: aPlainSquare ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]
