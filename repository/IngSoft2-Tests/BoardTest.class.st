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

	| twentySquares aWormHole aDistributionBuilder aDistribution aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	aWormHole := WormHole between: 15 and: 30.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.
	
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

	| twentySquares aWormHole aDistributionBuilder aDistribution aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	twentySquares := 20.
	aWormHole := WormHole between: 25 and: 30.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: twentySquares.
	
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

	| aWormHole fiveSquares aBoard expectedDistribution aDistributionBuilder aDistribution aBlackHoleSquare aProbability aBlackHoleSquareProbabilisticEvent |
	fiveSquares := 5.
	aWormHole := WormHole between: 1 and: 2.
	expectedDistribution := 'a BlackHoleSquare' , String cr
	                        , 'a WormHoleEndpoint' , String cr
	                        , 'a WormHoleEndpoint' , String cr
	                        , 'a BlackHoleSquare' , String cr
	                        , 'a BlackHoleSquare'.

	aDistributionBuilder := DistributionBuilder new.
	aBlackHoleSquare := BlackHoleSquare new.
	aProbability := 1.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with: aProbability.
	aDistributionBuilder add: aBlackHoleSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: fiveSquares.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.
	self assert: (aBoard distributionEquals: expectedDistribution)
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithLessThanTwoSquaresThenInvalid [

	| aLength aWormHole aDistributionBuilder aDistribution aPlainSquare aProbability aPlainSquareProbabilisticEvent |
	aLength := -1.
	aWormHole := WormHole between: 1 and: 2.

	aDistributionBuilder := DistributionBuilder new.
	aPlainSquare := PlainSquare new.
	aProbability := 1.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aProbability.
	aDistributionBuilder add: aPlainSquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: aLength.

	self
		should: [
		Board with: aLength and: aWormHole distributedBy: aDistribution ]
		raise: Error
		withMessageText: 'Board must have at least two squares'
]
