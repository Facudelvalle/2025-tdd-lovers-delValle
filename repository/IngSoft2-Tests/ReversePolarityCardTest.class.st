Class {
	#name : 'ReversePolarityCardTest',
	#superclass : 'TestCase',
	#instVars : [
		'sideToRoll',
		'aLoadedDice',
		'aBlueShip',
		'aBlackShip',
		'aWormHole',
		'aRewardManager',
		'zeroReward',
		'zeroRewardRewardProbabilisticEvent',
		'aProbabilityOfOne',
		'aReversePolarityCard',
		'aReversePolarityCardProbabilisticEvent',
		'someShips',
		'someDices',
		'aGameBuilder',
		'aNullCard',
		'aSetCardManagerWithReversePolarityCards',
		'aPlainSquare',
		'aPlainSquareProbabilisticEvent',
		'aDistributionManager',
		'anAccelerationCard',
		'anAccelerationCardProbabilisticEvent',
		'anAtomicBombSquare',
		'anAtomicBombSquareProbabilisticEvent',
		'aBlackHoleSquare',
		'aBlackHoleSquareProbabilisticEvent',
		'aMoonWalkSquare',
		'aMoonWalkSquareProbabilisticEvent',
		'sixSquares',
		'aHyperGravitySquare',
		'aHyperGravitySquareProbabilisticEvent',
		'aCardSquare',
		'aCardSquareProbabilisticEvent',
		'aRatioOfOne',
		'aParsecJumpOfOne',
		'aParsecJumpOfTwo',
		'aParsecJumpOfThree'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ReversePolarityCardTest >> setUp [

	super setUp.

	sixSquares := 6.

	aRatioOfOne := 1.

	aParsecJumpOfOne := Parsec with: 1.
	aParsecJumpOfTwo := Parsec with: 2.
	aParsecJumpOfThree := Parsec with: 3.

	aDistributionManager := ProbablisiticEventsManager new.

	sideToRoll := #( 2 3 2 1 ) asOrderedCollection.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.

	aWormHole := WormHole between: 4 and: 5.

	aPlainSquare := PlainSquare new.
	aProbabilityOfOne := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbabilityOfOne.

	anAtomicBombSquare := AtomicBombSquare new.
	anAtomicBombSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: anAtomicBombSquare
		                                        with: aProbabilityOfOne.

	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbabilityOfOne.

	aMoonWalkSquare := MoonWalkSquare between: 1 and: 1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with: aProbabilityOfOne.

	aHyperGravitySquare := HyperGravitySquare between: 3 and: 3.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with: aProbabilityOfOne.

	aCardSquare := CardSquare new.
	aCardSquareProbabilisticEvent := ProbabilisticEvent
		                                 for: aCardSquare
		                                 with: aProbabilityOfOne.

	aRewardManager := ProbablisiticEventsManager new.
	zeroReward := FuelDecreaseReward of: 0.
	zeroRewardRewardProbabilisticEvent := ProbabilisticEvent
		                                      for: zeroReward
		                                      with: aProbabilityOfOne.
	aRewardManager add: zeroRewardRewardProbabilisticEvent.

	aReversePolarityCard := ReversePolarityCard new.
	aReversePolarityCardProbabilisticEvent := ProbabilisticEvent
		                                          for: aReversePolarityCard
		                                          with: aProbabilityOfOne.

	anAccelerationCard := AccelerationCard new.
	anAccelerationCardProbabilisticEvent := ProbabilisticEvent
		                                        for: anAccelerationCard
		                                        with: aProbabilityOfOne.

	aSetCardManagerWithReversePolarityCards := ProbablisiticEventsManager
		                                           new.
	aSetCardManagerWithReversePolarityCards add:
		aReversePolarityCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.

	aGameBuilder := GameBuilder new.

	aGameBuilder setShips: someShips.
	aGameBuilder setDices: someDices.
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards:
		aSetCardManagerWithReversePolarityCards.

	aNullCard := NullCard new
]

{ #category : 'asserting' }
ReversePolarityCardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingABlackHoleSquareThenItsEffectIsInverted [

	| aGame aDistribution aBoard blackShipsExpectedPosition anAffectedSquaresPosition blueShipsExpectedPosition blueShipsExpectedFuel blackShipsExpectedFuel |
	blueShipsExpectedPosition := Position at: 1 in: 1.
	blueShipsExpectedFuel := Fuel with: 0 upTo: 6 in: HasFuelState new.
	blackShipsExpectedPosition := Position at: 3 in: 1.
	blackShipsExpectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.
	
	aWormHole := WormHole between: 2 and: 5.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 3 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame nextTurnPlay.

	aGame
		play: aReversePolarityCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert:
		(aBlueShip currentPositionEquals: blueShipsExpectedPosition).
	self assert: (aBlueShip fuelEquals: blueShipsExpectedFuel).
	
	self assert:
		(aBlackShip currentPositionEquals: blackShipsExpectedPosition).
	self assert: (aBlackShip fuelEquals: blackShipsExpectedFuel)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingACardSquareThenItsEffectIsInverted [

	| aGame aDistribution aBoard expectedCards anAffectedSquaresPosition |
	expectedCards := OrderedCollection new.
	expectedCards add: aReversePolarityCard.
	expectedCards add: aReversePolarityCard.

	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingAHyperGravitySquareThenItsEffectIsInverted [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition |
	expectedPosition := Position at: 2 in: 1.

	aDistributionManager add: aHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingAHyperJumpSquareThenItsEffectIsInverted [

	| aGame aDistribution aBoard blackShipsExpectedPosition anAffectedSquaresPosition blueShipsExpectedPosition someParsecs aHyperJumpSquare aHyperJumpSquareProbabilisticEvent blueShipsExpectedFuel blackShipsExpectedFuel |
	blueShipsExpectedPosition := Position at: 2 in: 1.
	blueShipsExpectedFuel := Fuel with: 4 upTo: 6 in: HasFuelState new.
	blackShipsExpectedPosition := Position at: 3 in: 1.
	blackShipsExpectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfOne.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfThree.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert:
		(aBlueShip currentPositionEquals: blueShipsExpectedPosition).
	self assert: (aBlueShip fuelEquals: blueShipsExpectedFuel).

	self assert:
		(aBlackShip currentPositionEquals: blackShipsExpectedPosition).
	self assert: (aBlackShip fuelEquals: blackShipsExpectedFuel)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingAMoonWalkSquareThenItsEffectIsInverted [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition expectedFuel |
	expectedPosition := Position at: 1 in: 1.
	expectedFuel := Fuel with: 3 upTo: 6 in: HasFuelState new.

	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingAWormHoleBeginningThenItsEffectIsInverted [

	| aGame aDistribution aBoard blackShipsExpectedPosition anAffectedSquaresPosition blueShipsExpectedPosition |
	blueShipsExpectedPosition := Position at: 4 in: 1.
	blackShipsExpectedPosition := Position at: 5 in: 1.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 4 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert:
		(aBlueShip currentPositionEquals: blueShipsExpectedPosition).
	self assert:
		(aBlackShip currentPositionEquals: blackShipsExpectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingAWormHoleEndThenItsEffectIsInverted [

	| aGame aDistribution aBoard blackShipsExpectedPosition anAffectedSquaresPosition blueShipsExpectedPosition |
	blueShipsExpectedPosition := Position at: 5 in: 1.
	blackShipsExpectedPosition := Position at: 4 in: 1.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 5 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert:
		(aBlueShip currentPositionEquals: blueShipsExpectedPosition).
	self assert:
		(aBlackShip currentPositionEquals: blackShipsExpectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardAffectingAnAtomicBombSquareThenItsEffectIsInverted [

	| aGame aDistribution aBoard blueShipsexpectedPosition anAffectedSquaresPosition blackShipsexpectedPosition anotherAffectedSquaresPosition |
	blueShipsexpectedPosition := Position at: 2 in: 1.
	blackShipsexpectedPosition := Position at: 3 in: 1.

	aDistributionManager add: anAtomicBombSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.
	anotherAffectedSquaresPosition := Position at: 3 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	aGame
		play: aReversePolarityCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anotherAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert:
		(aBlueShip currentPositionEquals: blueShipsexpectedPosition).
	self assert:
		(aBlackShip currentPositionEquals: blackShipsexpectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysAReversePolarityCardThenItIsNoLongerInItsHand [

	| aGame expectedCards aDistribution aBoard anAffectedSquaresPosition |
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.
	expectedCards add: aReversePolarityCard.

	anAffectedSquaresPosition := Position at: 1 in: 1.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingABlackHoleSquareThenItsEffectIsRegular [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition |
	expectedPosition := Position at: 0 in: 1.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingACardSquareThenItsEffectIsRegular [

	| aGame aDistribution aBoard expectedCards anAffectedSquaresPosition |
	expectedCards := OrderedCollection new.
	expectedCards add: aReversePolarityCard.

	aDistributionManager add: aCardSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: aBlueShip cards equals: expectedCards
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingAHyperGravitySquareThenItsEffectIsRegular [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition |
	expectedPosition := Position at: 2 in: 1.

	aDistributionManager add: aHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPass.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingAHyperJumpSquareThenItsEffectIsRegular [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition someParsecs aHyperJumpSquare aHyperJumpSquareProbabilisticEvent |
	expectedPosition := Position at: 4 in: 1.

	someParsecs := OrderedCollection new.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfTwo.
	someParsecs add: aParsecJumpOfTwo.

	aHyperJumpSquare := HyperJumpSquare
		                    with: someParsecs
		                    and: aRatioOfOne.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with: aProbabilityOfOne.
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingAMoonWalkSquareThenItsEffectIsRegular [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition |
	expectedPosition := Position at: 1 in: 1.

	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 3 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	aGame
		play: aReversePolarityCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingAWormHoleBeginningThenItsEffectIsRegular [

	| aGame aDistribution aBoard blackShipsExpectedPosition anAffectedSquaresPosition blueShipsExpectedPosition |
	blueShipsExpectedPosition := Position at: 5 in: 1.
	blackShipsExpectedPosition := Position at: 3 in: 1.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 4 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert:
		(aBlueShip currentPositionEquals: blueShipsExpectedPosition).
	self assert:
		(aBlackShip currentPositionEquals: blackShipsExpectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingAWormHoleEndThenItsEffectIsRegular [

	| aGame aDistribution aBoard anAffectedSquaresPosition expectedPosition |
	expectedPosition := Position at: 4 in: 1.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 5 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.
	aGame nextTurnPass.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipPlaysTwoReversePolarityCardsAffectingAnAtomicBombSquareThenItsEffectIsRegular [

	| aGame aDistribution aBoard expectedPosition anAffectedSquaresPosition |
	expectedPosition := Position at: 0 in: 1.

	aDistributionManager add: anAtomicBombSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	aGame
		play: aReversePolarityCard
		by: aBlueShip
		affecting: aNullCard
		and: aBlackShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	aGame
		play: aReversePolarityCard
		by: aBlackShip
		affecting: aNullCard
		and: aBlueShip
		and: anAffectedSquaresPosition.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition).
	self assert: (aBlackShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipTriesToPlayAReversePolarityCardThatIsNotInItsHandThenInvalid [

	| aGame expectedCards aDistribution aBoard aCardManager anAffectedSquaresPosition |
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aCardManager := ProbablisiticEventsManager new.
	aCardManager add: anAccelerationCardProbabilisticEvent.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setAvailableCards: aCardManager.
	aGame := aGameBuilder build.

	expectedCards := OrderedCollection new.
	expectedCards add: aReversePolarityCard.

	self
		should: [
			aGame
				play: aReversePolarityCard
				by: aBlueShip
				affecting: aNullCard
				and: aBlackShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText: 'The ship does not have that card on its hand.'
]

{ #category : 'tests' }
ReversePolarityCardTest >> testWhenAShipTriesToPlayAReversePolarityCardWhenItIsNotItsTurnThenInvalid [

	| aGame aDistribution aBoard anAffectedSquaresPosition |
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: sixSquares.

	anAffectedSquaresPosition := Position at: 2 in: 1.

	aBoard := Board
		          with: sixSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aGameBuilder setBoard: aBoard.
	aGame := aGameBuilder build.

	self
		should: [
			aGame
				play: aReversePolarityCard
				by: aBlackShip
				affecting: aNullCard
				and: aBlueShip
				and: anAffectedSquaresPosition ]
		raise: Error
		withMessageText:
		'A permanent card cannot be played when it is not your turn.'
]
