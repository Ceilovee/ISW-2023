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

!I class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:04:16'!
+ aNaturalNumber
	^aNaturalNumber next! !

!I class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:01:37'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  ^next! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'CIELO 8/25/2023 10:25:25'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:11:08'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!II class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:58:20'!
- aNaturalNumber
"IF MALO"
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:18:04'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!II class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:26:11'!
previous
	^previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:25:18'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'CIELO 8/25/2023 10:25:25'!
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

!III class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:42'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!III class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:42'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!III class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:42'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!III class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:42'!
previous
	^previous! !

!III class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:42'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!III class methodsFor: '--** private fileout/in **--' stamp: 'CIELO 8/25/2023 10:25:25'!
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

!IIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:53'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:53'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:53'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
previous
	^previous! !

!IIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!IIII class methodsFor: '--** private fileout/in **--' stamp: 'CIELO 8/25/2023 10:25:26'!
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

!IIIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
- aNaturalNumber
(aNaturalNumber = I) ifTrue: [^self previous].
	^self previous - aNaturalNumber previous.! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  next previous: self.
  ^next! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
previous
	^previous! !

!IIIII class methodsFor: 'as yet unclassified' stamp: 'CIELO 8/24/2023 21:49:54'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'CIELO 8/25/2023 10:25:26'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIII.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!