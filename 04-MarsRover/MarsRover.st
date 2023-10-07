!classDefinition: #TestsMarsRover category: 'MarsRover'!
TestCase subclass: #TestsMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:14:03'!
test01MarsRoverAtSetLocationWhenCreated
	
	| rover startPoint direction |
	
	startPoint := 0@0	.
	direction := #North.
	rover := MarsRover at: startPoint facing: direction .
	
	self assert: (rover location) = startPoint.
	self assert: (rover direction) = direction.
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:14:12'!
test02MarsRoverUpdatesLocationWhenMovedForward
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'f' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) = (0@1).
	self assert: (rover direction) = direction.
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:14:20'!
test03MarsRoverUpdatesLocationWhenMovedBackwards
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'b' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: (0@-1).
	self assert: (rover direction) = direction.
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:14:28'!
test04MarsRoverUpdatesLocationWhenMovedBackwards
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'b' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: (0@-1).
	self assert: (rover direction) = direction.
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:14:47'!
test05MarsRoverUpdatesDirecionWhenRotatedRight
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'r' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: startPoint .
	self assert: (rover direction) equals: #East.
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:15:02'!
test06MarsRoverUpdatesDirecionWhenRotatedLeft
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'l' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: startPoint .
	self assert: (rover direction) equals: #West.
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:15:20'!
test07MarsRoverUpdatesDirecionWhenMovesForwardMore
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'ff' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: (0@2) .
	self assert: (rover direction) equals: direction .
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:17:06'!
test08MarsRoverUpdatesDirecionWhenMovesBackwardsMore
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'bb' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: (0@-2) .
	self assert: (rover direction) equals: direction .
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:31:54'!
test09MarsRoverUpdatesDirecionWhenRotatedMoreThanOnce
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'rr' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: startPoint .
	self assert: (rover direction) equals: #South .
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:55:47'!
test10MarsRoverExecutesMultipleCommandsCorrectly
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'rfflb' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: (2@-1) .
	self assert: (rover direction) equals: #North .
	! !

!TestsMarsRover methodsFor: 'as yet unclassified' stamp: 'cielo 10/5/2023 21:53:55'!
test11MarsRoverExecutesCorrectlyUntilWrongCommand
	
	| rover startPoint direction commands |
	
	startPoint := 0@0	.
	direction := #North.
	commands := 'rffxlb' .
	rover := MarsRover at: startPoint facing: direction.
	rover execute: commands.
	
	self assert: (rover location) equals: (2@0) .
	self assert: (rover direction) equals: #East .
	! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'location direction posibleCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialization' stamp: 'cielo 10/6/2023 22:49:12'!
at: startPoint facing: aDirection 

	location := startPoint.
	direction := aDirection .
	posibleCommands := OrderedCollection new.
	posibleCommands add: $f.
	posibleCommands add: $b.
	posibleCommands add: $l.
	posibleCommands add: $r.! !


!MarsRover methodsFor: 'execution' stamp: 'cielo 10/6/2023 22:45:02'!
execute: commands 
	
	commands do: [:aCommand |
		(posibleCommands includes: aCommand) ifFalse: [^self].
		 self executeACommand: aCommand. ].
	
! !

!MarsRover methodsFor: 'execution' stamp: 'cielo 10/5/2023 21:34:35'!
executeACommand: aCommand

	(aCommand = $f) ifTrue: [self moveForward].
	(aCommand = $b) ifTrue: [self moveBackwards].
	(aCommand = $r) ifTrue: [self rotateRight].
	(aCommand = $l) ifTrue: [self rotateLeft].! !


!MarsRover methodsFor: 'rotation ' stamp: 'cielo 10/5/2023 21:43:02'!
rotateLeft
	(direction = #North) ifTrue: [^direction := #West].
	(direction = #South) ifTrue: [^direction := #East].
	(direction = #West) ifTrue: [^direction := #South].
	^direction := #North. ! !

!MarsRover methodsFor: 'rotation ' stamp: 'cielo 10/5/2023 21:42:42'!
rotateRight
	(direction = #North) ifTrue: [^direction := #East].
	(direction = #South) ifTrue: [^direction := #West].
	(direction = #West) ifTrue: [^direction := #North].
	^direction := #South.! !


!MarsRover methodsFor: 'geters' stamp: 'cielo 10/5/2023 20:58:35'!
direction
	^direction ! !

!MarsRover methodsFor: 'geters' stamp: 'cielo 10/5/2023 20:35:25'!
location
	^location! !


!MarsRover methodsFor: 'moving' stamp: 'cielo 10/5/2023 21:52:22'!
moveBackwards

	(direction = #North) ifTrue: [^location := location x @ (location y - 1)].
	(direction = #South) ifTrue: [^location := location x @ (location y + 1)].
	(direction = #West) ifTrue: [^location := (location x + 1) @ location y.].
	^location := (location x - 1) @ location y.
! !

!MarsRover methodsFor: 'moving' stamp: 'cielo 10/5/2023 21:52:10'!
moveForward

	(direction = #North) ifTrue: [^location := location x @ (location y + 1)].
	(direction = #South) ifTrue: [^location := location x @ (location y - 1)].
	(direction = #West) ifTrue: [^location := (location x - 1) @ location y.].
	^location := (location x + 1) @ location y.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'class initialization' stamp: 'cielo 10/5/2023 20:28:42'!
at: startPoint facing: direction 
	^self new at: startPoint facing: direction.! !
