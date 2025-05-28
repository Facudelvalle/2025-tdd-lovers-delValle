Class {
	#name : 'DistributionBuilderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DistributionBuilderTest >> testWhenAProbabilityDistributionIsCreatedThenTheSumOfItsProbabilitiesEqualsOne [

	| aDistributionBuilder distributionProbabilitySum expectedSum |
	aDistributionBuilder := DistributionBuilder new.
	aDistributionBuilder plainSquareProbabilityIs: 15.
	aDistributionBuilder blackHoleProbabilityIs: 0.2.
	aDistributionBuilder hyperJumpProbabilityIs: 148965651.
	aDistributionBuilder hyperGravityProbabilityIs: 0.65646.
	aDistributionBuilder moonWalkProbabilityIs: 0.0002.
	aDistributionBuilder atomicBombProbabilityIs: 1.
	aDistributionBuilder build.

	distributionProbabilitySum := aDistributionBuilder showProbabilities
		                              sum: [ :aProbability | aProbability ].
	expectedSum := 1.

	self assert: distributionProbabilitySum rounded equals: expectedSum
]

{ #category : 'tests' }
DistributionBuilderTest >> testWhenAnAverageProbabilityDistributionIsCreatedThenTheResultMatchesTheAverageBoardDistribution [

	| aDistributionBuilder anAverageDistribution plainSquarePossibility blackHoleSquarePossibility hyperGravitySquarePossibility moonWalkSquarePossibility hyperJumpSquarePossibility atomicBombSquarePossibility expectedDistribution |
	aDistributionBuilder := DistributionBuilder new.
	anAverageDistribution := aDistributionBuilder buildAverage.
	
	plainSquarePossibility := 0.4.
	blackHoleSquarePossibility := 0.2.
	hyperGravitySquarePossibility := 0.2.
	moonWalkSquarePossibility := 0.1.
	hyperJumpSquarePossibility := 0.08.
	atomicBombSquarePossibility := 0.02.
	expectedDistribution := {
		                        ([ PlainSquare new ]
		                         -> plainSquarePossibility).
		                        ([ BlackHoleSquare new ]
		                         -> blackHoleSquarePossibility).
		                        ([ HyperGravitySquare new ]
		                         -> hyperGravitySquarePossibility).
		                        ([ MoonWalkSquare new ]
		                         -> moonWalkSquarePossibility).
		                        ([ HyperJumpSquare new ]
		                         -> hyperJumpSquarePossibility).
		                        ([ AtomicBombSquare new ]
		                         -> atomicBombSquarePossibility) }.

	self
		assert: anAverageDistribution asString
		equals: expectedDistribution asString
]
