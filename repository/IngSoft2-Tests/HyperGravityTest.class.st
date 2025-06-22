Class {
	#name : 'HyperGravityTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItDoesNotMove [

	| aDistribution tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aFuelQuantity aDistributionBuilder aSetHyperGravitySquare aProbabilityOfOne aSetHyperGravitySquareProbabilisticEvent aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 1.
	oneLap := 1.

	expectedPosition := Position at: 1 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aSetHyperGravitySquare := SetHyperGravitySquare with: 2.
	aProbabilityOfOne := 1.
	aSetHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                            for:
		                                            aSetHyperGravitySquare
		                                            with: aProbabilityOfOne.
	aDistributionBuilder add: aSetHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                   for: zeroReward
		                                   with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRollANumberLowerThanTheSquareMagnitudeThenItsFuelDoesNotChange [

	| aDistribution tenSquares sideToRoll oneLap expectedFuel aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aFuelQuantity aDistributionBuilder aSetHyperGravitySquare aProbabilityOfOne aSetHyperGravitySquareProbabilisticEvent aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 1.
	oneLap := 1.

	expectedFuel := 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aSetHyperGravitySquare := SetHyperGravitySquare with: 2.
	aProbabilityOfOne := 1.
	aSetHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                            for:
		                                            aSetHyperGravitySquare
		                                            with: aProbabilityOfOne.
	aDistributionBuilder add: aSetHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip fuelEquals: expectedFuel)
]

{ #category : 'tests' }
HyperGravityTest >> testWhenAPlayerFallsIntoAHyperGravitySquareAndRolledTheNecesaryNumberThenItCanMove [

	| aDistribution tenSquares sideToRoll oneLap expectedPosition aWormHole aBlueShip aBlackShip aLoadedDice aBoard someShips someDices aGame aDistributionBuilder aFuelQuantity aHyperGravitySquare aProbabilityOfOne aHyperGravitySquareProbabilisticEvent aRewardBuilder zeroReward zeroRewardProbabilisticEvent |
	tenSquares := 10.
	sideToRoll := 1.
	oneLap := 1.

	expectedPosition := Position at: 2 in: 1.

	aWormHole := WormHole between: 5 and: 6.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	aDistributionBuilder := DistributionBuilder new.
	aHyperGravitySquare := HyperGravitySquare between: 1 and: 1.
	aProbabilityOfOne := 1.
	aHyperGravitySquareProbabilisticEvent := ProbabilisticEvent
		                                         for: aHyperGravitySquare
		                                         with: aProbabilityOfOne.
	aDistributionBuilder add: aHyperGravitySquareProbabilisticEvent.
	aDistribution := aDistributionBuilder buildFor: tenSquares.

	aBoard := Board
		          with: tenSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	aRewardBuilder := DistributionBuilder new.
	zeroReward := Reward of: 0.
	zeroRewardProbabilisticEvent := ProbabilisticEvent
		                                for: zeroReward
		                                with: aProbabilityOfOne.
	aRewardBuilder add: zeroRewardProbabilisticEvent.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	aFuelQuantity := (someDices sum: [ :aDice | aDice rollMaximum ]) * 2.

	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices
		         and: aFuelQuantity
		         and: aRewardBuilder.

	aGame nextTurnPlay.
	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPositionEquals: expectedPosition)
]
