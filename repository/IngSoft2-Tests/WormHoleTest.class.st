Class {
	#name : 'WormHoleTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aWormHole',
		'aBlueShip',
		'aBlackShip',
		'aDistributionManager',
		'aPlainSquare',
		'aProbabilityOfOne',
		'aPlainSquareProbabilisticEvent',
		'aDistribution',
		'aBoard',
		'aRewardManager',
		'zeroReward',
		'zeroRewardProbabilisticEvent',
		'aCardManager',
		'anAllyCard',
		'anAllyCardProbabilisticEvent',
		'someShips',
		'aGameBuilder'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
WormHoleTest >> setUp [
	super setUp.

	twentySquares := 20.
	
	aWormHole := WormHole between: 2 and: 5.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	
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
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardManager add: zeroRewardProbabilisticEvent.
	
	aCardManager := ProbablisiticEventsManager new.
	anAllyCard := AllyCard new.
	anAllyCardProbabilisticEvent := ProbabilisticEvent for: anAllyCard with: aProbabilityOfOne.
	aCardManager add: anAllyCardProbabilisticEvent.

	someShips := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.

	aGameBuilder := GameBuilder new.

	aGameBuilder setBoard: aBoard.
	aGameBuilder setShips: someShips.
	
	aGameBuilder setRewards: aRewardManager.
	aGameBuilder setAvailableCards: aCardManager.
	

]

{ #category : 'asserting' }
WormHoleTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheBeginningOfAWormHoleThenItEndsUpAtTheEndOfIt [

	| sideToRoll aSetDice someDices aGame expectedPosition |
	sideToRoll := #( 2 ) asOrderedCollection.
	aSetDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aSetDice.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 5 in: 1.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
WormHoleTest >> testWhenAShipLandsOnTheEndOfAWormHoleThenItEndsUpAtTheBeginningOfIt [

	| sideToRoll aSetDice someDices aGame expectedPosition |
	sideToRoll := #( 5 ) asOrderedCollection.
	aSetDice := LoadedDice toRoll: sideToRoll.
	someDices := OrderedCollection new.
	someDices add: aSetDice.
	aGameBuilder setDices: someDices.
	aGame := aGameBuilder build.

	expectedPosition := Position at: 2 in: 1.

	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithNegativeBeginningThenInvalid [

	self
		should: [ WormHole between: -2 and: 5 ]
		raise: Error
		withMessageText: 'A Worm Hole cannot begin in a negative square'
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithNegativeEndThenInvalid [

	self
		should: [ WormHole between: 2 and: -5 ]
		raise: Error
		withMessageText: 'A Worm Hole cannot end in a negative square'
]

{ #category : 'tests' }
WormHoleTest >> testWhenAWormHoleIsCreatedWithTheBeginningLargerThanTheEndingThenInvalid [

	self
		should: [ WormHole between: 10 and: 5 ]
		raise: Error
		withMessageText:
		'A Worm Hole cannot be created with the beginning larger than the ending'
]
