Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpTest >> testWhenThereIsAHiperJumpSquareWithMagnitudeThatIsInvalid [

	| fiveSquares aWormHole aBlueShip aBoard someShips someDices aLoadedDice sideToRoll oneLap aBlackShip aDistribution hyperJumpSquareProbability aCollectionofParsecs aGame expectedPosition |
	fiveSquares := 20.
	sideToRoll := 7.
	oneLap := 1.
	expectedPosition := Position at: 12 in: 1.

	aWormHole := WormHole between: 17 and: 18.
	aBlueShip := Ship called: 'BlueShip'.
	aBlackShip := Ship called: 'BlackShip'.
	aLoadedDice := LoadedDice toRoll: sideToRoll.

	hyperJumpSquareProbability := 1.
	
	aCollectionofParsecs := #( 5 4 6 5) asOrderedCollection.

	aDistribution := { ([ HyperJumpSquare with: aCollectionofParsecs ]
	                  -> hyperJumpSquareProbability) }.
	aBoard := Board
		          with: fiveSquares
		          and: aWormHole
		          distributedBy: aDistribution.

	someShips := OrderedCollection new.
	someDices := OrderedCollection new.
	someShips add: aBlueShip.
	someShips add: aBlackShip.
	someDices add: aLoadedDice.
	
	aGame := Game
		         with: aBoard
		         for: oneLap
		         and: someShips
		         and: someDices.

	aGame nextTurnPlay.
	aGame nextTurnPlay.

	self assert: (aBlueShip currentPosition equals: expectedPosition)

]
