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


!I class methodsFor: '--** private fileout/in **--' stamp: 'Alex 8/27/2023 21:01:45'!
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

!II class methodsFor: 'Aritmetica' stamp: 'cielo 8/27/2023 00:35:35'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

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

!II class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:18:04'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!II class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:26:11'!
previous
	^previous! !

!II class methodsFor: 'Aritmetica' stamp: 'CIELO 8/24/2023 21:25:18'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Alex 8/27/2023 21:01:45'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Peano'!
DenotativeObject subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: 'next previous'!

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 21:00:55'!
* aNaturalNumber
	^aNaturalNumber multiplicaA: self! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:31:50'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:31:50'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:37:50'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber < aNaturalNumber) ifTrue: [^I].
	^self - aNaturalNumber / aNaturalNumber + I! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:50:53'!
< aNaturalNumber 
	aNaturalNumber = I ifTrue: [^false].
	^self previous < (aNaturalNumber previous)! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:59:36'!
multiplicaA: aNaturalNumber
	^aNaturalNumber previous * self + self! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:31:50'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:31:51'!
previous
	^previous! !

!III class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:31:51'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'Alex 8/27/2023 21:01:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Peano'!
DenotativeObject subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: 'next previous'!

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 21:01:01'!
* aNaturalNumber
	^aNaturalNumber multiplicaA: self! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:38:00'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber < aNaturalNumber) ifTrue: [^I].
	^self - aNaturalNumber / aNaturalNumber + I! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:50:47'!
< aNaturalNumber 
	aNaturalNumber = I ifTrue: [^false].
	^self previous < (aNaturalNumber previous)! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:59:45'!
multiplicaA: aNaturalNumber
	^aNaturalNumber previous * self + self! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
previous
	^previous! !

!IIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Alex 8/27/2023 21:01:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Peano'!
DenotativeObject subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Peano'!
IIIII class
	instanceVariableNames: 'next previous'!

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 21:01:07'!
* aNaturalNumber
	^aNaturalNumber multiplicaA: self! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:00'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:38:10'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	(self - aNaturalNumber < aNaturalNumber) ifTrue: [^I].
	^self - aNaturalNumber / aNaturalNumber + I! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:50:17'!
< aNaturalNumber 
	aNaturalNumber = I ifTrue: [^false].
	^self previous < (aNaturalNumber previous)! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:59:58'!
multiplicaA: aNaturalNumber
	^aNaturalNumber previous * self + self! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:01'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:01'!
previous
	^previous! !

!IIIII class methodsFor: 'Aritmetica' stamp: 'Alex 8/27/2023 20:32:01'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'Alex 8/27/2023 21:01:46'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!