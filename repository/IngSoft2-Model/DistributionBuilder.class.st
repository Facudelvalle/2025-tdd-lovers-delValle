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
		'atomicBombProbability'
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
		                 ([ HyperGravitySquare new ]
		                  -> (hyperGravityProbability / totalProbability)).
		                 ([ MoonWalkSquare new ] -> (moonWalkProbability
		                  / totalProbability)).
		                 ([ HyperJumpSquare new ] -> (hyperJumpProbability
		                  / totalProbability)).
		                 ([ AtomicBombSquare new ] -> (atomicBombProbability
		                  / totalProbability)) }.

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

{ #category : 'setter' }
DistributionBuilder >> hyperJumpProbabilityIs: aProbability [ 
	
	hyperJumpProbability := aProbability
]

{ #category : 'initialization' }
DistributionBuilder >> initialize [

	plainSquareProbability := 1.
	blackHoleProbability := 0.
	hyperJumpProbability := 0.
	hyperGravityProbability := 0.
	moonWalkProbability := 0.
	atomicBombProbability := 0. 

	
]

{ #category : 'setter' }
DistributionBuilder >> moonWalkProbabilityIs: aProbability [ 
	
	moonWalkProbability := aProbability
]

{ #category : 'setter' }
DistributionBuilder >> plainSquareProbabilityIs: aProbability [ 
	
		plainSquareProbability := aProbability 
]

{ #category : 'getter' }
DistributionBuilder >> showProbabilities [

	| probabilities totalProbability |
	totalProbability := plainSquareProbability + blackHoleProbability
	                    + hyperGravityProbability + hyperJumpProbability + atomicBombProbability + moonWalkProbability.
	
	probabilities := OrderedCollection new.
	probabilities add: (plainSquareProbability/totalProbability).
	probabilities add: (blackHoleProbability/totalProbability).
	probabilities add: (hyperJumpProbability/totalProbability).
	probabilities add: (hyperGravityProbability/totalProbability).
	probabilities add: (moonWalkProbability/totalProbability).
	probabilities add: (atomicBombProbability/totalProbability).

	^ probabilities
]
