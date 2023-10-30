!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test17whenCreatingMarsRoverLogIsEmpty

	| marsRover logger|
	marsRover := MarsRover at: 0@0 heading: self north . 
	logger := HistoryLogPositions for: marsRover.
	self assert: logger historyLog equals: OrderedCollection new.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test18whenMarsRoverMoveForwardLogStoresNewPosition

	| marsRover expectedHistoryChanges logger|
	
	marsRover := MarsRover at: 0@0 heading: self north.
	
	logger := HistoryLogPositions for: marsRover.
	marsRover process: 'f'.
	
	expectedHistoryChanges := OrderedCollection new.
	expectedHistoryChanges add: 0@1.
	
	self assert: logger historyLog equals: expectedHistoryChanges.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test19whenMarsRoverMoveBackwardLogStoresNewPosition

	| marsRover expectedHistoryChanges logger|
	
	marsRover := MarsRover at: 0@0 heading: self north .
	
	logger := HistoryLogPositions for: marsRover.
	marsRover process: 'b'.
	
	expectedHistoryChanges := OrderedCollection new.
	expectedHistoryChanges add: 0@-1.
	
	self assert: logger historyLog equals: expectedHistoryChanges.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test20whenMarsRoverRotatesLeftLogStoresNewHeading

	| marsRover expectedHistoryChanges logger|
	
	marsRover := MarsRover at: 0@0 heading: self north .
	
	logger := HistoryLogHeadings for: marsRover.
	marsRover process: 'l'.
	
	expectedHistoryChanges := OrderedCollection new.
	expectedHistoryChanges add: #West.
	
	self assert: logger historyLog equals: expectedHistoryChanges.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test21whenMarsRoverRotatesRightLogStoresNewHeading

	| marsRover expectedHistoryChanges logger|
	
	marsRover := MarsRover at: 0@0 heading: self north .
	
	logger := HistoryLogHeadings for: marsRover.
	marsRover process: 'r'.
	
	expectedHistoryChanges := OrderedCollection new.
	expectedHistoryChanges add: #East.
	
	self assert: logger historyLog equals: expectedHistoryChanges.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test22whenMarsRoverRotatesAndMovesLogStoresBoth

	| marsRover expectedHistoryChanges logger|
	
	marsRover := MarsRover at: 0@0 heading: self north .
	
	logger := HistoryLogHeadingsAndPositions for: marsRover.
	marsRover process: 'rfl'.
	
	expectedHistoryChanges := OrderedCollection new.
	expectedHistoryChanges add: #East.
	expectedHistoryChanges add: 1@0.
	expectedHistoryChanges add: #North.
	
	self assert: logger historyLog equals: expectedHistoryChanges.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:44:59'!
test23whenMarsRoverRotatesAndMovesLogCanStoresOnlyMovementsOrOnlyHeadings

	| marsRover expectedHistoryHeadings expectedHistoryPositions loggerHeading loggerPosition loggerPositions|
	
	marsRover := MarsRover at: 0@0 heading: self north .
	
	loggerHeading := HistoryLogHeadings for: marsRover.
	loggerPositions := HistoryLogPositions for: marsRover.
	marsRover process: 'rfl'.
	expectedHistoryHeadings := OrderedCollection new.
	expectedHistoryPositions := OrderedCollection new.
	expectedHistoryHeadings add: #East.
	expectedHistoryPositions add: 1@0.
	expectedHistoryHeadings add: #North.
	
	self assert: loggerHeading historyLog equals: expectedHistoryHeadings.
	self assert: loggerPositions historyLog equals: expectedHistoryPositions

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:46:02'!
test24whenCreatingMarsRoverWindowIsEmpty
	| marsRover window|
	marsRover := MarsRover at: 0@0 heading: self north . 
	window := WindowWithPositionsAndHeadings for: marsRover.
	self assert: window showWindow equals: 'Position:  | Heading: '.
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/29/2023 23:53:49'!
test25whenMarsRoverMoveForwardWindowShowsNewPosition

	| marsRover window|
	
	marsRover := MarsRover at: 0@0 heading: self north.
	
	window := WindowWithPositionsAndHeadings for: marsRover.
	marsRover process: 'f'.
	self assert: window showWindow equals: 'Position: 0@1 | Heading: '
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/30/2023 00:02:17'!
test26whenMarsRoverRotatesWindowShowsNewHeading

	| marsRover window|
	
	marsRover := MarsRover at: 0@0 heading: self north.
	
	window := WindowWithPositionsAndHeadings for: marsRover.
	marsRover process: 'fr'.
	self assert: window showWindow equals: 'Position: 0@1 | Heading: East'
	
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/30/2023 00:14:06'!
test27whenMarsRoverMovesAndRotatesWindowCanOnlyShowsHeading

	| marsRover window|
	
	marsRover := MarsRover at: 0@0 heading: self north.
	
	window := WindowWithHeading for: marsRover.
	marsRover process: 'br'.
	self assert: window showWindow equals: 'Heading: East'
	
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'AyC 10/30/2023 00:15:52'!
test28whenMarsRoverMovesAndRotatesWindowCanOnlyShowsPosition

	| marsRover window|
	
	marsRover := MarsRover at: 0@0 heading: self north.
	
	window := WindowWithPositions for: marsRover.
	marsRover process: 'br'.
	self assert: window showWindow equals: 'Position: 0@ -1'
	
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head observers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'AyC 10/29/2023 21:41:16'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	
	observers := OrderedCollection new! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'AyC 10/29/2023 21:54:39'!
rotateLeft
	
	head rotateLeft.
	
	self notifyRotation! !

!MarsRover methodsFor: 'heading' stamp: 'AyC 10/29/2023 22:02:54'!
rotateRight
	
	head rotateRight.
	
	self notifyRotation! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'AyC 10/29/2023 21:40:02'!
moveBackward
	
	head moveBackward.
	self notifyMovement! !

!MarsRover methodsFor: 'moving' stamp: 'cielo y ale 10/26/2023 21:04:30'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'AyC 10/29/2023 21:39:45'!
moveForward
	
	head moveForward.
	self notifyMovement! !

!MarsRover methodsFor: 'moving' stamp: 'cielo y ale 10/26/2023 21:04:13'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'cielo y ale 10/26/2023 21:04:19'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'cielo y ale 10/26/2023 21:04:23'!
moveWest
	
	position := position + (-1@0)
! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'cielo y ale 10/26/2023 21:18:35'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !



!MarsRover methodsFor: 'communicate to observers' stamp: 'AyC 10/29/2023 21:35:39'!
connectTo: aLogger
	observers add: aLogger! !

!MarsRover methodsFor: 'communicate to observers' stamp: 'AyC 10/29/2023 21:39:45'!
notifyMovement

	^ observers do: [:observer | observer marsRoverMovesTo: position]! !

!MarsRover methodsFor: 'communicate to observers' stamp: 'AyC 10/29/2023 22:00:55'!
notifyRotation

	^ observers do: [:observer | observer marsRoverRotatesTo: 	head headOrientation]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'AyC 10/29/2023 21:58:13'!
headOrientation

	self subclassResponsibility! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'AyC 10/29/2023 21:57:58'!
headOrientation
	^#East! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'AyC 10/29/2023 21:58:37'!
headOrientation
	^#North! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'AyC 10/29/2023 21:58:49'!
headOrientation
	^#South! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'AyC 10/29/2023 21:58:59'!
headOrientation
	^#West! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverObserver category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverObserver
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverObserver methodsFor: 'update changes' stamp: 'AyC 10/30/2023 00:19:11'!
marsRoverMovesTo: aNewPosition

	self subclassResponsibility! !

!MarsRoverObserver methodsFor: 'update changes' stamp: 'AyC 10/30/2023 00:19:17'!
marsRoverRotatesTo: aCardinalSimbol

	self subclassResponsibility! !


!classDefinition: #HistoryLog category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #HistoryLog
	instanceVariableNames: 'historyLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HistoryLog methodsFor: 'Initialization' stamp: 'AyC 10/29/2023 22:23:41'!
initializeFor: aMarsRover
	historyLog := OrderedCollection new.
	aMarsRover connectTo: self.! !


!HistoryLog methodsFor: 'history' stamp: 'AyC 10/29/2023 23:44:59'!
historyLog
	^historyLog ! !


!HistoryLog methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:24:58'!
marsRoverMovesTo: aNewPosition

	self subclassResponsibility! !

!HistoryLog methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:25:03'!
marsRoverRotatesTo: aCardinalSimbol

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HistoryLog class' category: 'MarsRover-WithHeading'!
HistoryLog class
	instanceVariableNames: ''!

!HistoryLog class methodsFor: 'initialization' stamp: 'AyC 10/29/2023 23:47:01'!
for: aMarsRovers
	^self new initializeFor: aMarsRovers ! !


!classDefinition: #HistoryLogHeadings category: 'MarsRover-WithHeading'!
HistoryLog subclass: #HistoryLogHeadings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HistoryLogHeadings methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:16:35'!
marsRoverMovesTo: aNewPosition! !

!HistoryLogHeadings methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:00:26'!
marsRoverRotatesTo: aCardinalSimbol

	historyLog add: aCardinalSimbol ! !


!classDefinition: #HistoryLogHeadingsAndPositions category: 'MarsRover-WithHeading'!
HistoryLog subclass: #HistoryLogHeadingsAndPositions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HistoryLogHeadingsAndPositions methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:06:19'!
marsRoverMovesTo: aNewPosition
	historyLog add: aNewPosition ! !

!HistoryLogHeadingsAndPositions methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:06:34'!
marsRoverRotatesTo: aCardinalSimbol

	historyLog add: aCardinalSimbol ! !


!classDefinition: #HistoryLogPositions category: 'MarsRover-WithHeading'!
HistoryLog subclass: #HistoryLogPositions
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!HistoryLogPositions methodsFor: 'update changes' stamp: 'AyC 10/29/2023 21:31:39'!
marsRoverMovesTo: aNewPosition
	historyLog add: aNewPosition ! !

!HistoryLogPositions methodsFor: 'update changes' stamp: 'AyC 10/29/2023 22:16:24'!
marsRoverRotatesTo: aCardinalSimbol! !


!classDefinition: #WindowStatus category: 'MarsRover-WithHeading'!
MarsRoverObserver subclass: #WindowStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowStatus methodsFor: 'initialization' stamp: 'AyC 10/30/2023 00:10:42'!
initializeFor: aMarsRover

	self subclassResponsibility! !


!WindowStatus methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:11:15'!
marsRoverMovesTo: aPosition

	self subclassResponsibility! !

!WindowStatus methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:11:22'!
marsRoverRotatesTo: aCardinalSimbol

	self subclassResponsibility! !


!WindowStatus methodsFor: 'show window' stamp: 'AyC 10/30/2023 00:11:26'!
showWindow

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WindowStatus class' category: 'MarsRover-WithHeading'!
WindowStatus class
	instanceVariableNames: ''!

!WindowStatus class methodsFor: 'initialization' stamp: 'AyC 10/30/2023 00:09:01'!
for: aMarsRover
	^self new initializeFor: aMarsRover ! !


!classDefinition: #WindowWithHeading category: 'MarsRover-WithHeading'!
WindowStatus subclass: #WindowWithHeading
	instanceVariableNames: 'heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowWithHeading methodsFor: 'initialization' stamp: 'AyC 10/30/2023 00:14:55'!
initializeFor: aMarsRover
	aMarsRover connectTo: self.
	heading := ''! !


!WindowWithHeading methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:15:06'!
marsRoverMovesTo: aPosition ! !

!WindowWithHeading methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:15:14'!
marsRoverRotatesTo: aCardinalSimbol
	heading := aCardinalSimbol asString! !


!WindowWithHeading methodsFor: 'show window' stamp: 'AyC 10/30/2023 00:15:30'!
showWindow

	^'Heading: ', heading! !


!classDefinition: #WindowWithPositions category: 'MarsRover-WithHeading'!
WindowStatus subclass: #WindowWithPositions
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowWithPositions methodsFor: 'initialization' stamp: 'AyC 10/30/2023 00:11:49'!
initializeFor: aMarsRover
	aMarsRover connectTo: self.
	position := ''! !


!WindowWithPositions methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:12:03'!
marsRoverMovesTo: aPosition 
	position := aPosition asString! !

!WindowWithPositions methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:12:14'!
marsRoverRotatesTo: aCardinalSimbol! !


!WindowWithPositions methodsFor: 'show window' stamp: 'AyC 10/30/2023 00:12:27'!
showWindow

	^'Position: ', position! !


!classDefinition: #WindowWithPositionsAndHeadings category: 'MarsRover-WithHeading'!
WindowStatus subclass: #WindowWithPositionsAndHeadings
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!WindowWithPositionsAndHeadings methodsFor: 'initialization' stamp: 'AyC 10/29/2023 23:48:54'!
initializeFor: aMarsRover
	aMarsRover connectTo: self.
	position := ''.
	heading := ''! !


!WindowWithPositionsAndHeadings methodsFor: 'update status' stamp: 'AyC 10/29/2023 23:57:12'!
marsRoverMovesTo: aPosition 
	position := aPosition asString! !

!WindowWithPositionsAndHeadings methodsFor: 'update status' stamp: 'AyC 10/30/2023 00:01:10'!
marsRoverRotatesTo: aCardinalSimbol
	heading := aCardinalSimbol asString! !


!WindowWithPositionsAndHeadings methodsFor: 'show window' stamp: 'AyC 10/30/2023 00:01:52'!
showWindow

	^'Position: ', position, ' | Heading: ', heading! !
