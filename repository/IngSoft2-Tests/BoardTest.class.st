Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

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

	| twentySquares aWormHole aDistributionManager aDistribution aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	aWormHole := WormHole between: 15 and: 30.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager buildFor: twentySquares.
	
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

	| twentySquares aWormHole aDistributionManager aDistribution aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	aWormHole := WormHole between: 25 and: 30.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager buildFor: twentySquares.
	
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

	| aWormHole fiveSquares aBoard expectedDistribution aDistributionManager aDistribution aBlackHoleSquare aProbability aBlackHoleSquareProbabilisticEvent |
	fiveSquares := 5.
	aWormHole := WormHole between: 1 and: 2.
	expectedDistribution := 'a BlackHoleSquare' , String cr
	                        , 'a WormHoleEndpoint' , String cr
	                        , 'a WormHoleEndpoint' , String cr
	                        , 'a BlackHoleSquare' , String cr
	                        , 'a BlackHoleSquare'.

	aDistributionManager := ProbablisiticEventsManager new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbability := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbability.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionManager buildFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.
	self assert: (aBoard distributionEquals: expectedDistribution)
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithLessThanTwoSquaresThenInvalid [

	| aLength aWormHole aDistributionManager aDistribution aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	aLength := -1.
	aWormHole := WormHole between: 1 and: 2.

	aDistributionManager := ProbablisiticEventsManager new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionManager add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionManager buildFor: aLength.

	self
		should: [
		Board with: aLength and: aWormHole distributedBy: aDistribution ]
		raise: Error
		withMessageText: 'Board must have at least two squares'
]
