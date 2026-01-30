Class {
	#name : 'RedoCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'fiveSquares',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aSetCardManager',
		'aRedoCard',
		'aRedoCardProbabilisticEvent',
		'someShips',
		'aGameBuilder',
		'aBoard',
		'aNullCard',
		'twentySquares',
		'anAffectedSquaresPosition',
		'aReversePolarityCard',
		'aBlackHoleSquareProbabilisticEvent',
		'aBlackHoleSquare',
		'someDices',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'aCardSquare',
		'aCardSquareProbabilisticEvent',
		'aCancellationCard',
		'aCancellationCardProbabilisticEvent',
		'aRepeatCard',
		'aRepeatCardProbabilisticEvent',
		'aReversePolarityCardProbabilisticEvent',
		'anOverloadCard',
		'anOverloadCardProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RedoCardTest >> setUp [

	super setUp.

	fiveSquares := 5.
	twentySquares := 20.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 18 and: 19.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.
	aDistributionManager add: aPlainSquareProbabilisticEvent.


	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aSetCardManager := SetProbablisiticEventsManager new.
	aRedoCard := RedoCard new.
	aRedoCardProbabilisticEvent := ProbabilisticEvent
		                               for: aRedoCard
		                               with: aProbabilityOfOne.

	someDices := OrderedCollection new.
	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aSetCardManager.

	aNullCard := NullCard new.

	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.

	aCardSquare := CardSquare new.
	aCardSquareProbabilisticEvent := ProbabilisticEvent
		                                 for: aCardSquare
		                                 with: aProbabilityOfOne.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                 for: aRepeatCard
		                                 with: aProbabilityOfOne.

	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.

	anOverloadCard := OverloadCard new.
	anOverloadCardProbabilisticEvent := ProbabilisticEvent
		                                    for: anOverloadCard
		                                    with: aProbabilityOfOne
]

{ #category : 'asserting' }
RedoCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
RedoCardTest >> testWhenAShipPlaysARedoCardThenItIsNoLongerInItsHand [

	| aGame sideToRoll aDistribution expectedCards aLoadedDice |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices add: aLoadedDice.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aRedoCardProbabilisticEvent.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPass.
	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: anAccelerationCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
RedoCardTest >> testWhenAShipTriesToPlayARedoCardThatIsNotInItsHandThenInvalid [

	| aGame sideToRoll aLoadedDice aDistribution |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: anAllyCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterACancellationCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution aGame |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 5 upTo: 6 in: HasFuelState new.

	aDistributionManager := ProbablisiticEventsManager new.
	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.
	aSetCardManager add: aCancellationCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.

	aGame
		play: aCancellationCard
		by: aBlueShip
		affecting: anAccelerationCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlackShip
		affecting: anAccelerationCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAPermanentCardAndItsNotYourTurnThenItFails [

	| sideToRoll aLoadedDice aDistribution aGame |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterARedoCardAfterAnAccelerationCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution aGame |
	sideToRoll := #( 1 1 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 14 upTo: 20 in: HasFuelState new.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	aGame
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterARepeatCardThenTheEffectIsAppliedProperly [

	| sideToRoll aLoadedDice aDistribution aGame expectedSize |
	sideToRoll := #( 1 1 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedSize := 3.

	aDistributionManager := ProbablisiticEventsManager new.
	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: aRepeatCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.
	aGame nextTurnPass.

	aGame
		play: aRepeatCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	self assert: aBlueShip amountOfCards equals: expectedSize
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAReversePolarityCardThenTheEffectIsAppliedProperly [

	| aGame aDistribution expectedPosition sideToRoll aLoadedDice |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 6 in: 1.

	aDistributionManager := ProbablisiticEventsManager new.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 10 in: 1.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: aReversePolarityCardProbabilisticEvent.

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

	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnAccelerationCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution aGame |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 5 in: 1.
	expectedFuel := Fuel with: 1 upTo: 6 in: HasFuelState new.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	aGame
		play: aRedoCard
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
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnAllyCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution aGame aRedShip aPinkShip |
	sideToRoll := #( 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 9 in: 1.
	expectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	aRedShip := Ship called: 'RedShip'.
	aPinkShip := Ship called: 'PinkShip'.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAllyCardProbabilisticEvent.

	someShips add: aRedShip.
	someShips add: aPinkShip.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAllyCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aRedShip
		affecting: aNullCard
		and: aPinkShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aRedShip currentPositionEquals: expectedPosition).
	self assert: (aPinkShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnOverloadCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution aGame |
	sideToRoll := #( 3 1 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 2 upTo: 6 in: HasFuelState new.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anOverloadCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anOverloadCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	aGame
		play: aRedoCard
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
RedoCardTest >> testWhenAnRedoCardIsUsedBeforeAnyCardIsPlayedThenItFails [

	| sideToRoll aLoadedDice aDistribution aGame |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aSetCardManager add: aRedoCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText:
		'A Redo card can not be played when there are no played cards yet.'
]
