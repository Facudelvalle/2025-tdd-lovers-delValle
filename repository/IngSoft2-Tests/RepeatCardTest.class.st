Class {
	#name : 'RepeatCardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'asserting' }
RepeatCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAfterAShipsMovesThenTheCardDonApplyAnyEffect [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aPlainSquare aPlainSquareProbabilisticEvent expectedPosition expectedFuel aNullCard |
	twentySquares := 20.
	sideToRoll := #(3) asOrderedCollection.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsABackHoleEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aBlackHoleSquare aBlackHoleSquareProbabilisticEvent expectedPosition expectedFuel aNullCard |
	twentySquares := 20.
	sideToRoll := #( 10 ) asOrderedCollection.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 2 upTo: 20 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbabilityOfOne := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsACardEffectThenItsAppliedCorrectly [

	| twentySquares aWormHole aGame sidesToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aCardSquare aCardSquareProbabilisticEvent expectedSize aNullCard |
	twentySquares := 20.
	sidesToRoll := #( 2 2 10 ) asOrderedCollection.

	expectedSize := 2.

	aWormHole := WormHole between: 15 and: 16.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	aDistributionManager := ProbablisiticEventsManager new.

	aCardSquare := CardSquare new.
	aProbabilityOfOne := 1.
	aCardSquareProbabilisticEvent := ProbabilisticEvent
		                                 for: aCardSquare
		                                 with: aProbabilityOfOne.
	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlackShip.
	aGame nextTurnPass.

	self assert: aBlackShip amountOfCards equals: expectedSize
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAHyperGavityEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sidesToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aHyperGavitySquare expectedPosition expectedFuel aHyperGavitySquareProbabilisticEvent aNullCard |
	twentySquares := 20.
	sidesToRoll := #( 2 5 2 ) asOrderedCollection.

	expectedPosition := Position at: 7 in: 1.
	expectedFuel := Fuel with: 3 upTo: 10 in: HasFuelState new.

	aWormHole := WormHole between: 15 and: 16.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aHyperGavitySquare := HyperGravitySquare between: 4 and: 4.
	aProbabilityOfOne := 1.
	aHyperGavitySquareProbabilisticEvent := ProbabilisticEvent
		                                        for: aHyperGavitySquare
		                                        with: aProbabilityOfOne.
	aDistributionManager add: aHyperGavitySquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAHyperJumpEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sidesToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aHyperJumpSquare expectedPosition expectedFuel aHyperJumpSquareProbabilisticEvent aRatio someParsecs aNullCard aParsecJumpOfFive anotherParsecJumpOfFive aParsecJumpOfTen |
	twentySquares := 20.
	sidesToRoll := #( 2 10 ) asOrderedCollection.

	expectedPosition := Position at: 17 in: 1.
	expectedFuel := Fuel with: 3 upTo: 20 in: HasFuelState new.
	aRatio := 1.

	aWormHole := WormHole between: 15 and: 16.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	aDistributionManager := ProbablisiticEventsManager new.

	aParsecJumpOfFive := Parsec with: 5.
	anotherParsecJumpOfFive := Parsec with: 5.
	aParsecJumpOfTen := Parsec with: 10.
	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfFive.
	someParsecs add: anotherParsecJumpOfFive.
	someParsecs add: aParsecJumpOfTen.

	aHyperJumpSquare := HyperJumpSquare with: someParsecs and: aRatio.
	aProbabilityOfOne := 1.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAMoonWalkEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sidesToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aMoonWalkSquare expectedPosition expectedFuel aMoonWalkSquareProbabilisticEvent aNullCard |
	twentySquares := 20.
	sidesToRoll := #(2 2 10) asOrderedCollection.

	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 17 upTo: 20 in: HasFuelState new.

	aWormHole := WormHole between: 15 and: 16.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	
	aMoonWalkSquare := MoonWalkSquare between: 1 and: 1.
	aProbabilityOfOne := 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aMoonWalkSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsANullEfectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aPlainSquare aPlainSquareProbabilisticEvent expectedPosition expectedFuel aNullCard |
	twentySquares := 20.
	sideToRoll := #(3) asOrderedCollection.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardAndTheLastEffectIsAnAtomicBombEffectThenItsApplyCorrecty [

	| twentySquares aWormHole aGame sidesToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent anAtomicBombSquare expectedPosition expectedFuel anAtomicBombSquareProbabilisticEvent aNullCard |
	twentySquares := 20.
	sidesToRoll := #(2 2 10) asOrderedCollection.

	expectedPosition := Position at: 0 in: 1.
	expectedFuel := Fuel with: 18 upTo: 20 in: HasFuelState new.

	aWormHole := WormHole between: 15 and: 16.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sidesToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	
	anAtomicBombSquare := AtomicBombSquare new.
	aProbabilityOfOne := 1.
	anAtomicBombSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: anAtomicBombSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: anAtomicBombSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPass.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardThenItIsNoLongerInItsHand [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aRepeatCard aRepeatCardProbabilisticEvent expectedCards anAccelerationCard anAccelerationCardProbabilisticEvent aSetCardManager aNullCard |
	fiveSquares := 5.
	sideToRoll := #( 10 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aSetCardManager := SetProbablisiticEventsManager new.
	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                for: aRepeatCard
		                                with: aProbabilityOfOne.
	aSetCardManager add: aRepeatCardProbabilisticEvent.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aSetCardManager.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.
	expectedCards add: anAccelerationCard.

	aNullCard := NullCard new.
	aGame
		play: aRepeatCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipPlaysARepeatCardWhenIsNotItsTurn [

	| twentySquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aProbabilityOfOne aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager aRepeatCard aRepeatCardProbabilisticEvent aPlainSquare aPlainSquareProbabilisticEvent expectedPosition expectedFuel aNullCard |
	twentySquares := 20.
	sideToRoll := #( 3 ) asOrderedCollection.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

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
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aNullCard := NullCard new.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame
		play: aRepeatCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip.
	aGame nextTurnPlay.


	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RepeatCardTest >> testWhenAShipTriesToPlayARepeatCardThatIsNotInItsHandThenInvalid [

	| fiveSquares aWormHole aGame sideToRoll aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aDistributionManager aDistribution aPlainSquare aProbabilityOfOne aPlainSquareProbabilisticEvent aRewardManager zeroReward zeroRewardRewardProbabilisticEvent aGameBuilder aCardManager anAllyCard aRepeatCard anAllyCardProbabilisticEvent aNullCard |
	fiveSquares := 5.
	sideToRoll := #( 10 ) asOrderedCollection.

	aWormHole := WormHole between: 2 and: 3.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAllyCard
		                                        with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	aRepeatCard := RepeatCard new.
	aNullCard := NullCard new.

	self
		should: [
			aGame
				play: aRepeatCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]
