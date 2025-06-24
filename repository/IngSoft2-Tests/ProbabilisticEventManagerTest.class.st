Class {
	#name : 'ProbabilisticEventManagerTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ProbabilisticEventManagerTest >> testWhenADistributionIsBuiltThenItMatchesTheEventsProbability [

	| expectedDistribution averageDistribution aDistributionManager aPlainSquare aPlainSquareProbabilisticEvent aDistribution aPlainSquareProbability oneHundredSquares aBlackHoleSquare aBlackHoleSquareProbability aBlackHoleSquareProbabilisticEvent aHyperGravitySquare aHyperGravitySquareProbability aHyperGravitySquareProbabilisticEvent aMoonWalkSquare aMoonWalkSquareProbability aMoonWalkSquareProbabilisticEvent aHyperJumpSquare aHyperJumpSquareProbability aHyperJumpSquareProbabilisticEvent anAtomicBombSquare anAtomicBombSquareProbability anAtomicBombSquareProbabilisticEvent plainSquares blackHoleSquares hyperGravitySquares moonWalkSquares hyperJumpSquares atomicBombSquares iterations |
	
	oneHundredSquares := 100.
	aDistributionManager := ProbablisiticEventsManager new.

	aPlainSquare := PlainSquare new.
	aPlainSquareProbability := 0.4.
	aPlainSquareProbabilisticEvent := ProbabilisticEvent
		                                  for: aPlainSquare
		                                  with: aPlainSquareProbability.
	aDistributionManager add: aPlainSquareProbabilisticEvent.

	aBlackHoleSquare := BlackHoleSquare new.
	aBlackHoleSquareProbability := 0.2.
	aBlackHoleSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aBlackHoleSquare
		                                      with:
		                                      aBlackHoleSquareProbability.
	aDistributionManager add: aBlackHoleSquareProbabilisticEvent.

	aHyperGravitySquare := HyperGravitySquare between: 1 and: 2.
	aHyperGravitySquareProbability := 0.2.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with:
		                                         aHyperGravitySquareProbability.
	aDistributionManager add: aHyperGravitySquareProbabilisticEvent.

	aMoonWalkSquare := MoonWalkSquare between: 1 and: 2.
	aMoonWalkSquareProbability := 0.1.
	aMoonWalkSquareProbabilisticEvent := ProbabilisticEvent
		                                     for: aMoonWalkSquare
		                                     with:
		                                     aMoonWalkSquareProbability.
	aDistributionManager add: aMoonWalkSquareProbabilisticEvent.

	aHyperJumpSquare := HyperJumpSquare
		                    with: #( 1 2 3 ) asOrderedCollection
		                    and: 1.
	aHyperJumpSquareProbability := 0.08.
	aHyperJumpSquareProbabilisticEvent := ProbabilisticEvent
		                                      for: aHyperJumpSquare
		                                      with:
		                                      aHyperJumpSquareProbability.
	aDistributionManager add: aHyperJumpSquareProbabilisticEvent.

	anAtomicBombSquare := AtomicBombSquare new.
	anAtomicBombSquareProbability := 0.02.
	anAtomicBombSquareProbabilisticEvent := ProbabilisticEvent
		                                        for: anAtomicBombSquare
		                                        with:
		                                        anAtomicBombSquareProbability.
	aDistributionManager add: anAtomicBombSquareProbabilisticEvent.

	aDistribution := aDistributionManager generateFor: oneHundredSquares.

	plainSquares := 0.
	blackHoleSquares := 0.
	hyperGravitySquares := 0.
	moonWalkSquares := 0.
	hyperJumpSquares := 0.
	atomicBombSquares := 0.
	iterations := 100.

	1 to: iterations do: [ :anIteration |
		aDistribution := aDistributionManager generateFor: oneHundredSquares.

		plainSquares := plainSquares + (aDistribution occurrencesOf: aPlainSquare).
		blackHoleSquares := blackHoleSquares + (aDistribution occurrencesOf: aBlackHoleSquare).
		hyperGravitySquares := hyperGravitySquares + (aDistribution occurrencesOf:
			aHyperGravitySquare).
		moonWalkSquares := moonWalkSquares + (aDistribution occurrencesOf: aMoonWalkSquare).
		hyperJumpSquares := hyperJumpSquares + (aDistribution occurrencesOf: aHyperJumpSquare).
		atomicBombSquares := atomicBombSquares + (aDistribution occurrencesOf: anAtomicBombSquare) ].

	averageDistribution := OrderedCollection new.
	averageDistribution add: plainSquares/(iterations*oneHundredSquares).
	averageDistribution add: blackHoleSquares/(iterations*oneHundredSquares).
	averageDistribution add: hyperGravitySquares/(iterations*oneHundredSquares).
	averageDistribution add: moonWalkSquares/(iterations*oneHundredSquares).
	averageDistribution add: hyperJumpSquares/(iterations*oneHundredSquares).
	averageDistribution add: atomicBombSquares/(iterations*oneHundredSquares).

	expectedDistribution := #( 0.4 0.2 0.2 0.1 0.08 0.02 ) asOrderedCollection .
	self assert:
		(averageDistribution closeTo: expectedDistribution precision: 0.01)
]
