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
		'twentySquares'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RedoCardTest >> setUp [

	super setUp.

	fiveSquares := 5.
	twentySquares := 20.

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
	aSetCardManager add: aRedoCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aSetCardManager.


	aNullCard := NullCard new
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

	| aGame sideToRoll aDistribution expectedCards anAccelerationCard anAccelerationCardProbabilisticEvent aLoadedDice someDices |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

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
		and: aPlainSquare.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
RedoCardTest >> testWhenAShipTriesToPlayARedoCardThatIsNotInItsHandThenInvalid [

	| aGame sideToRoll aLoadedDice someDices aDistribution aCardManager anAllyCard anAllyCardProbabilisticEvent |
	sideToRoll := #( 10 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.


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

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: aPlainSquare ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterACancellationCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aCardSquare aCardSquareProbabilisticEvent aDistribution someDices aGame anAccelerationCard anAccelerationCardProbabilisticEvent aCancellationCard aCancellationCardProbabilisticEvent |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 5 upTo: 6 in: HasFuelState new.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

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

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aCancellationCard := CancellationCard new.
	aCancellationCardProbabilisticEvent := ProbabilisticEvent
		                                       for: aCancellationCard
		                                       with: aProbabilityOfOne.

	aSetCardManager add: aCancellationCardProbabilisticEvent.
	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices := OrderedCollection new.
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
		and: aPlainSquare.

	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.

	aGame
		play: aCancellationCard
		by: aBlueShip
		affecting: anAccelerationCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlackShip
		affecting: anAccelerationCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAPermanentCardAndItsNotYourTurnThenItFails [

	| sideToRoll aLoadedDice aDistribution someDices aGame anAccelerationCard anAccelerationCardProbabilisticEvent |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	aLoadedDice := LoadedDice toRoll: sideToRoll.


	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	self
		should: [
			aGame
				play: aRedoCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: aPlainSquare ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterARedoCardAfterAnAccelerationCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution someDices aGame anAccelerationCard anAccelerationCardProbabilisticEvent |
	sideToRoll := #( 1 1 10 ) asOrderedCollection.

	expectedPosition := Position at: 6 in: 1.
	expectedFuel := Fuel with: 14 upTo: 20 in: HasFuelState new.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	aGame
		play: aRedoCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterARepeatCardThenTheEffectIsAppliedProperly [

	| sideToRoll aLoadedDice aCardSquare aCardSquareProbabilisticEvent aDistribution someDices aGame aRepeatCard aRepeatCardProbabilisticEvent expectedSize |
	sideToRoll := #( 1 1 10 ) asOrderedCollection.

	expectedSize := 3.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

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

	aRepeatCard := RepeatCard new.
	aRepeatCardProbabilisticEvent := ProbabilisticEvent
		                                 for: aRepeatCard
		                                 with: aProbabilityOfOne.

	aSetCardManager add: aRepeatCardProbabilisticEvent.

	someDices := OrderedCollection new.
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
		and: aPlainSquare.

	aGame
		play: aRedoCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlueShip
		and: aPlainSquare.

	self assert: aBlueShip amountOfCards equals: expectedSize
]

{ #category : 'tests' }
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnAccelerationCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution someDices aGame anAccelerationCard anAccelerationCardProbabilisticEvent |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 5 in: 1.
	expectedFuel := Fuel with: 1 upTo: 6 in: HasFuelState new.

	aLoadedDice := LoadedDice toRoll: sideToRoll.
	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anAccelerationCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	aGame
		play: aRedoCard
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
RedoCardTest >> testWhenAnRedoCardIsUsedAfterAnAllyCardThenTheEffectIsAppliedProperly [

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution someDices aGame aRedShip aPinkShip anAllyCard anAllyCardProbabilisticEvent |
	sideToRoll := #( 3 ) asOrderedCollection.

	expectedPosition := Position at: 9 in: 1.
	expectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	aRedShip := Ship called: 'RedShip'.
	aPinkShip := Ship called: 'PinkShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent
		                                for: anAllyCard
		                                with: aProbabilityOfOne.


	aSetCardManager add: anAllyCardProbabilisticEvent.

	someDices := OrderedCollection new.
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
		and: aPlainSquare.

	aGame nextTurnPass.
	aGame nextTurnPass.

	aGame
		play: aRedoCard
		by: aRedShip
		affecting: aNullCard
		and: aPinkShip
		and: aPlainSquare.

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

	| sideToRoll expectedPosition expectedFuel aLoadedDice aDistribution someDices aGame anOverloadCard anOverloadCardProbabilisticEvent |
	sideToRoll := #( 3 1 3 ) asOrderedCollection.

	expectedPosition := Position at: 2 in: 1.
	expectedFuel := Fuel with: 2 upTo: 6 in: HasFuelState new.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.


	anOverloadCard := OverloadCard new.
	anOverloadCardProbabilisticEvent := ProbabilisticEvent
		                                    for: anOverloadCard
		                                    with: aProbabilityOfOne.

	aSetCardManager add: anOverloadCardProbabilisticEvent.

	someDices := OrderedCollection new.
	someDices add: aLoadedDice.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	aGame
		play: anOverloadCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: aPlainSquare.

	aGame nextTurnPlay.

	aGame
		play: aRedoCard
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
RedoCardTest >> testWhenAnRedoCardIsUsedBeforeAnyCardIsPlayedThenItFails [

	| sideToRoll aLoadedDice aDistribution someDices aGame anAccelerationCard anAccelerationCardProbabilisticEvent |
	sideToRoll := #( 1 1 3 ) asOrderedCollection.

	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistribution := aDistributionManager generateFor: twentySquares.

	aBoard := Board
		          with: twentySquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aSetCardManager add: anAccelerationCardProbabilisticEvent.

	someDices := OrderedCollection new.
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
				and: aPlainSquare ]
		raise: Error
		withMessageText:
		'A Redo card can not be played when there are no played cards yet.'
]
