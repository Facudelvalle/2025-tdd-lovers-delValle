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

	| twentySquares aWormHole aDistributionBuilder aDefaultDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 15 and: 30.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	self
		should: [
			Board
				with: twentySquares
				and: aWormHole
				distributedBy: aDefaultDistribution ]
		raise: Error
		withMessageText:
		'A Board cannot end before the ending of its Worm Hole'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedAndTheWormHoleFallsOutsideOfTheDimentionThenInvalid [

	| twentySquares aWormHole aDistributionBuilder aDefaultDistribution |
	twentySquares := 20.
	aWormHole := WormHole between: 25 and: 30.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	self
		should: [
			Board
				with: twentySquares
				and: aWormHole
				distributedBy: aDefaultDistribution ]
		raise: Error
		withMessageText:
		'A Worm Hole cannot fall outside of its Boards length'
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithACertainDistributionThenTheSquaresWhereThereIsAWormHoleIsAPlainSquare [

	| aWormHole fiveSquares aBoard expectedDistribution aDistributionBuilder aDistribution |
	fiveSquares := 5.
	aWormHole := WormHole between: 1 and: 2.
	expectedDistribution := 'a BlackHoleSquare' , String cr
	                        , 'a PlainSquare' , String cr
	                        , 'a PlainSquare' , String cr
	                        , 'a BlackHoleSquare' , String cr
	                        , 'a BlackHoleSquare'.

	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder plainSquareProbabilityIs: 0.
	aDistributionBuilder blackHoleProbabilityIs: 1.
	aDistribution := aDistributionBuilder build.

	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.
	self assert: aBoard showDistribution equals: expectedDistribution
]

{ #category : 'tests' }
BoardTest >> testWhenABoardIsCreatedWithLessThanTwoSquaresThenInvalid [

	| aLength aWormHole aDistributionBuilder aDefaultDistribution |
	aLength := -1.
	aWormHole := WormHole between: 1 and: 2.

	aDistributionBuilder := DistributionBuilder new.
	aDefaultDistribution := aDistributionBuilder build.
	
	self
		should: [
			Board
				with: aLength
				and: aWormHole
				distributedBy: aDefaultDistribution ]
		raise: Error
		withMessageText: 'Board must have at least two squares'
]
