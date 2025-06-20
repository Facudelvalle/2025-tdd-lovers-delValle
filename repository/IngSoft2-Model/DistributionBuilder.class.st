"
This class represents a distribution builder
"
Class {
	#name : 'DistributionBuilder',
	#superclass : 'Object',
	#instVars : [
		'plainSquareProbability',
		'blackHoleProbability',
		'hyperJumpProbability',
		'hyperGravityProbability',
		'moonWalkProbability',
		'atomicBombProbability',
		'hyperJumpSquare',
		'moonWalkSquare',
		'hyperGravitySquare'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'setter' }
DistributionBuilder >> atomicBombProbabilityIs: aProbability [ 
	
	atomicBombProbability := aProbability
]

{ #category : 'setter' }
DistributionBuilder >> blackHoleProbabilityIs: aProbability [ 
	
	blackHoleProbability := aProbability
]

{ #category : 'building' }
DistributionBuilder >> build [

	| aDistribution totalProbability |
	totalProbability := plainSquareProbability + blackHoleProbability
	                    + hyperGravityProbability + hyperJumpProbability
	                    + moonWalkProbability + atomicBombProbability.
	aDistribution := {
		                 ([ PlainSquare new ]
		                  -> (plainSquareProbability / totalProbability)).
		                 ([ BlackHoleSquare new ]
		                  -> (blackHoleProbability / totalProbability)).
		                 (hyperGravitySquare
		                  -> (hyperGravityProbability / totalProbability)).
		                 (moonWalkSquare
		                  -> (moonWalkProbability / totalProbability)).
		                 (hyperJumpSquare
		                  -> (hyperJumpProbability / totalProbability)).
		                 ([ AtomicBombSquare new ]
		                  -> (atomicBombProbability / totalProbability)) }.

	^ aDistribution
]

{ #category : 'building' }
DistributionBuilder >> buildAverage [

	plainSquareProbability := 0.4.
	blackHoleProbability := 0.2.
	hyperJumpProbability := 0.08.
	hyperGravityProbability := 0.2.
	moonWalkProbability := 0.1.
	atomicBombProbability := 0.02.
		
	^ self build
]

{ #category : 'setter' }
DistributionBuilder >> hyperGravityProbabilityIs: aProbability [ 

	hyperGravityProbability := aProbability
]

{ #category : 'validation' }
DistributionBuilder >> hyperGravitySquareBetween: aMinimumMagnitude and: aMaximumMagnitude [

	hyperGravitySquare := [
	                      HyperGravitySquare
		                      between: aMinimumMagnitude
		                      and: aMaximumMagnitude ]
]

{ #category : 'setter' }
DistributionBuilder >> hyperJumpProbabilityIs: aProbability [ 
	
	hyperJumpProbability := aProbability
]

{ #category : 'setter' }
DistributionBuilder >> hyperJumpWith: someParsecs and: aRatio [

	hyperJumpSquare := [ HyperJumpSquare with: someParsecs and: aRatio ]
]

{ #category : 'initialization' }
DistributionBuilder >> initialize [

	plainSquareProbability := 1.
	blackHoleProbability := 0.
	hyperJumpProbability := 0.
	hyperGravityProbability := 0.
	moonWalkProbability := 0.
	atomicBombProbability := 0. 
	hyperJumpSquare := [ HyperJumpSquare new ].
	moonWalkSquare := [ MoonWalkSquare new ].
	hyperGravitySquare := [ HyperGravitySquare new ]
	
]

{ #category : 'setter' }
DistributionBuilder >> moonWalkProbabilityIs: aProbability [ 
	
	moonWalkProbability := aProbability
]

{ #category : 'setter' }
DistributionBuilder >> moonWalkSquareBetween: aMinimumMagnitude and: aMaximumMagnitude [

	moonWalkSquare := [
	                  MoonWalkSquare
		                  between: aMinimumMagnitude
		                  and: aMaximumMagnitude ]
]

{ #category : 'setter' }
DistributionBuilder >> plainSquareProbabilityIs: aProbability [ 
	
		plainSquareProbability := aProbability 
]

{ #category : 'accessing' }
DistributionBuilder >> totalSumEquals: aSum [ 
	
	| totalProbability probabilities probabilitiesSum |
	totalProbability := plainSquareProbability + blackHoleProbability
	                    + hyperGravityProbability + hyperJumpProbability + atomicBombProbability + moonWalkProbability.
	
	probabilities := OrderedCollection new.
	probabilities add: (plainSquareProbability/totalProbability).
	probabilities add: (blackHoleProbability/totalProbability).
	probabilities add: (hyperJumpProbability/totalProbability).
	probabilities add: (hyperGravityProbability/totalProbability).
	probabilities add: (moonWalkProbability/totalProbability).
	probabilities add: (atomicBombProbability/totalProbability).
	
	probabilitiesSum := probabilities sum: [ :aProbability | aProbability ].
	
	^ probabilitiesSum rounded = aSum
]
