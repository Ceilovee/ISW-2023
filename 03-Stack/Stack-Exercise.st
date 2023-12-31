!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'stackVacio stackDeOraciones sentenceFinderOraciones sentenceFinderStackVacio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 20:06:09'!
test01ReturnsEmptyWhenStackEmpty
	self assert: ((sentenceFinderStackVacio encontrarOracionesConPrefijo: 'hola') isEmpty ).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 20:05:44'!
test02ReturnsEmptyWhenPrefixDoesntMatch
	self assert: ((sentenceFinderOraciones encontrarOracionesConPrefijo: 'hola') isEmpty ).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 20:12:51'!
test03ReturnsOneMatchCaseSensitive

	| collectionWithMatch |
	
	collectionWithMatch := OrderedCollection new.
	collectionWithMatch add: 'Winter is here'.
	
	self assert: ((sentenceFinderOraciones encontrarOracionesConPrefijo: 'Winter') = collectionWithMatch ).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 20:15:27'!
test04ReturnsMatchesWithWCaseSensitive

	| collectionWithMatch |
	
	collectionWithMatch := OrderedCollection new.
	collectionWithMatch add: 'winning is everything'.
	collectionWithMatch add: 'winter is comming'.
	
	self assert: ((sentenceFinderOraciones encontrarOracionesConPrefijo: 'w') = collectionWithMatch ).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 21:31:55'!
test05PrefixCantBeEmpty
	
	self
		should: [ sentenceFinderOraciones encontrarOracionesConPrefijo: '']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = sentenceFinderOraciones elPrefijoNoPuedeSerVacio ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 22:04:55'!
test06StackIsStillTheSame
	| stack |
	stack := sentenceFinderOraciones stack.
	sentenceFinderOraciones encontrarOracionesConPrefijo: 'hola'.
	self assert: sentenceFinderOraciones stack = stack! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'cielo 9/17/2023 21:33:03'!
test07PrefixCantHaveBlankSpaces
	
	self
		should: [ sentenceFinderOraciones encontrarOracionesConPrefijo: 'winter is']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = sentenceFinderOraciones elPrefijoNoPuedeContenerEspacioVacio ]! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'cielo 9/17/2023 19:59:46'!
setUp

	stackVacio := OOStack new.
	
	stackDeOraciones := OOStack new.
	stackDeOraciones push: 'winter is comming'.
	stackDeOraciones push: 'winning is everything'.
	stackDeOraciones push: 'The winds of Winter'.
	stackDeOraciones push: 'Winter is here'.
	
	sentenceFinderOraciones := SentenceFinderByPrefix withStack: stackDeOraciones .
	sentenceFinderStackVacio := SentenceFinderByPrefix withStack: stackVacio .
	
	! !


!classDefinition: #ComponentesDeStack category: 'Stack-Exercise'!
Object subclass: #ComponentesDeStack
	instanceVariableNames: 'stackAsociado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ComponentesDeStack methodsFor: 'creacionDeComponente' stamp: 'cielo 9/16/2023 17:26:14'!
agregarEncima: elementoAAgregar
	^ElementoDeStack withValue:  elementoAAgregar withParent: self associateToStack: stackAsociado ! !


!ComponentesDeStack methodsFor: 'informacion' stamp: 'cielo 9/16/2023 18:52:41'!
esBaseDeStack
	^self subclassResponsibility ! !

!ComponentesDeStack methodsFor: 'informacion' stamp: 'cielo 9/16/2023 18:52:57'!
valor
	^self subclassResponsibility ! !


!classDefinition: #BaseDeStack category: 'Stack-Exercise'!
ComponentesDeStack subclass: #BaseDeStack
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!BaseDeStack methodsFor: 'inicialization' stamp: 'cielo 9/16/2023 17:23:58'!
initializewithStack: stackCreador
	stackAsociado := stackCreador ! !


!BaseDeStack methodsFor: 'informacionSobreComponente' stamp: 'cielo 9/16/2023 16:28:36'!
esBaseDeStack
	^true! !

!BaseDeStack methodsFor: 'informacionSobreComponente' stamp: 'cielo 9/16/2023 17:18:04'!
valor
	stackAsociado throwEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BaseDeStack class' category: 'Stack-Exercise'!
BaseDeStack class
	instanceVariableNames: ''!

!BaseDeStack class methodsFor: 'as yet unclassified' stamp: 'cielo 9/16/2023 17:23:31'!
withStack: stackCreador
	^self new initializewithStack: stackCreador! !


!classDefinition: #ElementoDeStack category: 'Stack-Exercise'!
ComponentesDeStack subclass: #ElementoDeStack
	instanceVariableNames: 'elementoAnterior valor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoDeStack methodsFor: 'inicialization' stamp: 'cielo 9/16/2023 17:25:07'!
withValue:  valorDeElemento withParent: elementoPadre associateToStack: stackCreador
	elementoAnterior := elementoPadre .
	valor := valorDeElemento.
	stackAsociado := stackCreador! !


!ElementoDeStack methodsFor: 'infromacionDeComponente' stamp: 'cielo 9/16/2023 17:08:27'!
elementoAnterior
	^elementoAnterior! !

!ElementoDeStack methodsFor: 'infromacionDeComponente' stamp: 'cielo 9/16/2023 16:28:57'!
esBaseDeStack
	^false! !

!ElementoDeStack methodsFor: 'infromacionDeComponente' stamp: 'cielo 9/16/2023 16:47:12'!
valor
	^valor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementoDeStack class' category: 'Stack-Exercise'!
ElementoDeStack class
	instanceVariableNames: ''!

!ElementoDeStack class methodsFor: 'as yet unclassified' stamp: 'cielo 9/16/2023 17:25:23'!
withValue:  valorDeElemento withParent: elementoPadre associateToStack: stackCreador
	^self new withValue:  valorDeElemento withParent: elementoPadre associateToStack: stackCreador! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'topeDeStack size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'inicialization' stamp: 'cielo 9/16/2023 17:21:35'!
initialize 
	topeDeStack := BaseDeStack withStack: self.
	size := 0! !


!OOStack methodsFor: 'informacion' stamp: 'cielo 9/16/2023 16:28:23'!
isEmpty
	^topeDeStack esBaseDeStack! !

!OOStack methodsFor: 'informacion' stamp: 'cielo 9/16/2023 17:00:36'!
size
	^size! !

!OOStack methodsFor: 'informacion' stamp: 'cielo 9/16/2023 16:47:00'!
top
	^topeDeStack valor! !


!OOStack methodsFor: 'error' stamp: 'cielo 9/16/2023 17:18:13'!
throwEmptyErrorDescription
	self error: self class stackEmptyErrorDescription! !


!OOStack methodsFor: 'modificarStack' stamp: 'cielo 9/16/2023 17:08:46'!
pop
	|topeADevolver|
	topeADevolver  := self top.
	
	topeDeStack :=  topeDeStack elementoAnterior. 
	size := size -1.
	^topeADevolver  ! !

!OOStack methodsFor: 'modificarStack' stamp: 'cielo 9/16/2023 17:01:31'!
push: elementoAPushear
	topeDeStack := topeDeStack agregarEncima: elementoAPushear.
	size := size + 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackDeOraciones'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'cielo 9/16/2023 18:58:25'!
initializeWithStack: unStackParaBucarPrefijos
	stackDeOraciones :=  unStackParaBucarPrefijos! !

!SentenceFinderByPrefix methodsFor: 'initialize' stamp: 'cielo 9/17/2023 22:02:09'!
stack
	^stackDeOraciones ! !


!SentenceFinderByPrefix methodsFor: 'find' stamp: 'cielo 9/17/2023 21:28:48'!
encontrarOracionesConPrefijo: unPrefijo
	|stackDeAlmacenamientoTemporal prefijosEncontrados|
	
	self precondicionesDelPrefijo: unPrefijo.
	
	stackDeAlmacenamientoTemporal := OOStack new.
	prefijosEncontrados := OrderedCollection new.
	
	[stackDeOraciones isEmpty] whileFalse: 
	[
		stackDeAlmacenamientoTemporal push: stackDeOraciones pop.
		(self laOracion: stackDeAlmacenamientoTemporal top tienePrefijo: unPrefijo ) ifTrue: 			[prefijosEncontrados add: stackDeAlmacenamientoTemporal top.].
	] .

	self rearmarStackAPartirDe: stackDeAlmacenamientoTemporal.
	
	^prefijosEncontrados! !

!SentenceFinderByPrefix methodsFor: 'find' stamp: 'cielo 9/17/2023 22:00:09'!
precondicionesDelPrefijo: unPrefijo

	unPrefijo isEmpty ifTrue: [^self error: self elPrefijoNoPuedeSerVacio].
	(unPrefijo includesSubString: ' ') ifTrue: [^self error: self elPrefijoNoPuedeContenerEspacioVacio]! !


!SentenceFinderByPrefix methodsFor: 'operacionesSobreString' stamp: 'cielo 9/16/2023 18:40:26'!
elInicioDeLaOracion: unaOracionDelStack esIgualA: unPrefijo

	^ (unaOracionDelStack copyFrom:1 to: unPrefijo size) = unPrefijo! !

!SentenceFinderByPrefix methodsFor: 'operacionesSobreString' stamp: 'cielo 9/16/2023 18:40:26'!
laOracion: unaOracionDelStack tienePrefijo: unPrefijo
	^(self prefijo: unPrefijo esMasChicoQue: unaOracionDelStack) and: [self elInicioDeLaOracion: unaOracionDelStack esIgualA: unPrefijo]! !

!SentenceFinderByPrefix methodsFor: 'operacionesSobreString' stamp: 'cielo 9/16/2023 18:38:10'!
prefijo: unPrefijo esMasChicoQue: unaOracionDelStack

	^ unaOracionDelStack size >= unPrefijo size! !


!SentenceFinderByPrefix methodsFor: 'operacionesSobreStack' stamp: 'cielo 9/16/2023 19:15:59'!
rearmarStackAPartirDe: stackInvertido 
	[stackInvertido isEmpty] whileFalse: 
	[
		stackDeOraciones push: stackInvertido pop.
	] . ! !


!SentenceFinderByPrefix methodsFor: 'mensajesDeError' stamp: 'cielo 9/17/2023 21:28:07'!
elPrefijoNoPuedeContenerEspacioVacio
	^'el prefijo no puede contener espacios vacios'! !

!SentenceFinderByPrefix methodsFor: 'mensajesDeError' stamp: 'cielo 9/17/2023 21:27:20'!
elPrefijoNoPuedeSerVacio
	^'el prefijo no puede ser vacio'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'cielo 9/16/2023 18:59:30'!
withStack: unStackParaBuscarPrefijos
	^self new initializeWithStack: unStackParaBuscarPrefijos ! !
