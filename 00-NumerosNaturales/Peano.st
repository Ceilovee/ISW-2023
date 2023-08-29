!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'Aritmetica' stamp: 'cielo 8/26/2023 01:22:03'!
* aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:04:16'!
+ aNaturalNumber
	^aNaturalNumber next! !

!I class methodsFor: 'Aritmetica' stamp: 'cielo 8/29/2023 10:29:58'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^I]! !

!I class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:51:11'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^true! !

!I class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:58:39'!
multiplicaA: aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:01:37'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  ^next! !

!I class methodsFor: 'Aritmetica' stamp: 'cielo 8/29/2023 10:23:36'!
restaA: aNaturalNumber
	^aNaturalNumber previous! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'cielo 8/29/2023 10:31:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:57:50'!
* aNaturalNumber
	^aNaturalNumber multiplicaA: self! !

!II class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:11:08'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!II class methodsFor: 'Aritmetica' stamp: 'cielo 8/29/2023 10:21:07'!
- aNaturalNumber
	^aNaturalNumber restaA: self! !

!II class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:37:41'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber < aNaturalNumber) ifTrue: [^I].
	^self - aNaturalNumber / aNaturalNumber + I! !

!II class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:51:00'!
< aNaturalNumber 
	aNaturalNumber = I ifTrue: [^false].
	^self previous < (aNaturalNumber previous)! !

!II class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:57:18'!
multiplicaA: aNaturalNumber
	^aNaturalNumber previous * self + self! !

!II class methodsFor: 'Aritmetica' stamp: 'cielo 8/29/2023 10:18:10'!
next 
  next ifNotNil: [^next].
  next:= self createChildNamed: self name, 'I'.
  next previous: self.
  ^next! !

!II class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:26:11'!
previous
	^previous! !

!II class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:25:18'!
previous: aNaturalNumber
	previous := aNaturalNumber! !

!II class methodsFor: 'Aritmetica' stamp: 'cielo 8/29/2023 10:22:43'!
restaA: aNaturalNumber
	^aNaturalNumber previous - self previous! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'cielo 8/29/2023 10:31:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'cielo 8/29/2023 10:31:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'cielo 8/29/2023 10:31:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!