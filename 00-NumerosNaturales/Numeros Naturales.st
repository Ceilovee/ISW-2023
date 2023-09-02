!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'AritmeticOperations' stamp: 'cielo 8/26/2023 01:22:03'!
* aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'AritmeticOperations' stamp: 'CIELO 8/24/2023 21:04:16'!
+ aNaturalNumber
	^aNaturalNumber next! !

!I class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 18:49:39'!
- aNaturalNumber
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 19:02:51'!
/ aNaturalNumber
	aNaturalNumber = I ifTrue: [^I].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor! !

!I class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 18:59:34'!
< aNaturalNumber
	aNaturalNumber = self ifTrue: [^false].
	^true! !


!I class methodsFor: 'OperationsToAvoidIfs' stamp: 'cielo 9/2/2023 18:40:47'!
multiplyTo: aNaturalNumber
	^aNaturalNumber! !

!I class methodsFor: 'OperationsToAvoidIfs' stamp: 'cielo 9/2/2023 18:41:10'!
substractTo: aNaturalNumber
	^aNaturalNumber previous! !


!I class methodsFor: 'Next' stamp: 'CIELO 8/24/2023 21:01:37'!
next 
  next ifNotNil: [^next].
  next:= self cloneNamed: self name, 'I'.
  ^next! !


!I class methodsFor: 'Errors' stamp: 'cielo 9/2/2023 19:03:20'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'Cant be divided by greater numbers'! !

!I class methodsFor: 'Errors' stamp: 'cielo 9/2/2023 18:55:11'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Negative numbers not suported'! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'cielo 9/2/2023 19:06:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 18:35:55'!
* aNaturalNumber
	^aNaturalNumber multiplyTo: self! !

!II class methodsFor: 'AritmeticOperations' stamp: 'CIELO 8/24/2023 21:11:08'!
+ aNaturalNumber
	^self previous + aNaturalNumber next ! !

!II class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 18:36:05'!
- aNaturalNumber
	^aNaturalNumber substractTo: self! !

!II class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 19:00:42'!
/ aNaturalNumber
	self = aNaturalNumber ifTrue: [^I].
	self < aNaturalNumber ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor ].
	^self - aNaturalNumber / aNaturalNumber + I! !

!II class methodsFor: 'AritmeticOperations' stamp: 'cielo 9/2/2023 18:58:31'!
< aNaturalNumber
	aNaturalNumber = I ifTrue: [^false].
	^self previous < aNaturalNumber previous! !


!II class methodsFor: 'OperationsToAvoidIfs' stamp: 'cielo 9/2/2023 18:35:32'!
multiplyTo: aNaturalNumber
	^aNaturalNumber previous * self + self! !

!II class methodsFor: 'OperationsToAvoidIfs' stamp: 'cielo 9/2/2023 18:35:16'!
substractTo: aNaturalNumber
	^aNaturalNumber previous - self previous! !


!II class methodsFor: 'PreviousAndNext' stamp: 'cielo 9/2/2023 18:28:37'!
next 
  next ifNotNil: [^next].
  next:= II createChildNamed: self name, 'I'.
  next previous: self.
  ^next! !

!II class methodsFor: 'PreviousAndNext' stamp: 'CIELO 8/24/2023 21:26:11'!
previous
	^previous! !

!II class methodsFor: 'PreviousAndNext' stamp: 'CIELO 8/24/2023 21:25:18'!
previous: aNaturalNumber
	previous := aNaturalNumber! !


!II class methodsFor: 'Errors' stamp: 'cielo 9/2/2023 18:55:39'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
 	^'Cant be divided by greater numbers'! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'cielo 9/2/2023 19:06:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'cielo 9/2/2023 19:06:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'cielo 9/2/2023 19:06:32'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!