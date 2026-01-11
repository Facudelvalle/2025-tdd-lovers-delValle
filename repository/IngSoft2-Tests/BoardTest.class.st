Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#instVars : [
		'twentySquares',
		'aDistributionManager',
		'aPlainSquare',
		'aProbability',
		'aPlainSquareProbabilisticEvent',
		'fiveSquares',
		'aBlackHoleSquare',
		'aBlackHoleSquareProbabilisticEvent'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BoardTest >> setUp [

	super setUp.

	twentySquares := 20.
	fiveSquares := 5.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.

	aBlackHoleSquare := BlackHoleSquare new.
	aProbability := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbability
]

{ #category : 'asserting' }
BoardTest >> should: anErrorBlock raise: anErrorClass withMessageText: anErrorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: anErrorMessage ]
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedAndEndsBeforeTheEndingOfItsWormHoleThenInvalid [

	| aWormHole aDistribution |
	aWormHole := WormHole between: 15 and: 30.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.
	
	self
		should: [
			Board
				with: twentySquares
				and: aWormHole
				distributedBy: aDistribution ]
		raise: Error
		withMessageText:
		'A Board cannot end before the ending of its Worm Hole'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedAndTheWormHoleFallsOutsideOfTheDimentionThenInvalid [

	| aWormHole aDistribution |
	aWormHole := WormHole between: 25 and: 30.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: twentySquares.
	
	self
		should: [
			Board
				with: twentySquares
				and: aWormHole
				distributedBy: aDistribution ]
		raise: Error
		withMessageText:
		'A Worm Hole cannot fall outside of its Boards length'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithACertainDistributionThenTheSquaresWhereThereIsAWormHoleIsAWormHoleEndpoint [

	| aWormHole aBoard expectedDistribution aDistribution |
	aWormHole := WormHole between: 1 and: 2.
	expectedDistribution := 'a BlackHoleSquare' , String cr
	                        , 'a WormHoleEndpoint' , String cr
	                        , 'a WormHoleEndpoint' , String cr
	                        , 'a BlackHoleSquare' , String cr
	                        , 'a BlackHoleSquare'.

	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.
	self assert: (aBoard distributionEquals: expectedDistribution)
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithLessThanTwoSquaresThenInvalid [

	| aLength aWormHole aDistribution |
	aLength := -1.
	aWormHole := WormHole between: 1 and: 2.

	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager generateFor: aLength.

	self
		should: [
		Board with: aLength and: aWormHole distributedBy: aDistribution ]
		raise: Error
		withMessageText: 'Board must have at least two squares'
]
