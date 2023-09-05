!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/4/2023 21:40:26'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self executeThis: [customerBook addCustomerNamed: 'John Lennon'.] wontLastMoreThan: 50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/4/2023 21:42:52'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self executeThis: [customerBook removeCustomerNamed: paulMcCartney.] wontLastMoreThan: 100.

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Alex 9/5/2023 17:39:21'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook checksThatTheErrorIsTheCorrectOne|		
	customerBook := CustomerBook new.
	
	checksThatTheErrorIsTheCorrectOne  := OrderedCollection new.
	checksThatTheErrorIsTheCorrectOne add: [:anError | anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.].
	checksThatTheErrorIsTheCorrectOne add: [:anError | customerBook isEmpty .].
	

        self checkThatFails: [customerBook addCustomerNamed: ''.] 
	withError: Error andAssertTheseConditions: checksThatTheErrorIsTheCorrectOne
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Alex 9/5/2023 17:50:35'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon checksThatTheCustomersInTheBookAreCorrect|		
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	checksThatTheCustomersInTheBookAreCorrect := OrderedCollection new.
	checksThatTheCustomersInTheBookAreCorrect  add: [:anError | customerBook numberOfCustomers = 1.].
	checksThatTheCustomersInTheBookAreCorrect add: [:anError | (customerBook includesCustomerNamed: johnLennon) ].
		self checkThatFails: [ customerBook removeCustomerNamed: 'Paul McCartney'.] withError: NotFound 
	andAssertTheseConditions: checksThatTheCustomersInTheBookAreCorrect.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 00:05:20'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self thisCusumerBookhas:customerBook numberOfActiveCustumers:0 numberOfSuspendedCustomers:1 numberOfCustomers:1 .
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 00:04:55'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self thisCusumerBookhas:customerBook numberOfActiveCustumers:0 numberOfSuspendedCustomers:0 numberOfCustomers:0 .
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/17/2020 06:03:47'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: 'George Harrison'.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'NR 9/19/2018 17:57:11'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	[ customerBook suspendCustomerNamed: johnLennon.
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !


!CustomerBookTest methodsFor: 'checkingErrorsAreShownCorrectly' stamp: 'Alex 9/5/2023 17:41:25'!
checkThatFails: closureWithAnError withError: errorName andAssertTheseConditions: aCollectionOfConditions
	
	[ closureWithAnError value.
	self fail ]
		on: errorName
		do: [ :anError | 
			
			aCollectionOfConditions do: [:aCondition| self assert: (aCondition value: anError)]. ].
		! !

!CustomerBookTest methodsFor: 'checkingErrorsAreShownCorrectly' stamp: 'cielo 9/4/2023 22:18:31'!
checkThatFails: closureWithAnError withError: errorName andAssertThis:checkIsCorrectError andThis:reasonForFailing
	
	[ closureWithAnError value.
	self fail ]
		on: errorName
		do: [ :anError | 
			self assert: (checkIsCorrectError value:anError).
			self assert: reasonForFailing value. ].
		! !


!CustomerBookTest methodsFor: 'checkingTimeExecution' stamp: 'Alex 9/5/2023 16:50:27'!
executeThis: aClosure wontLastMoreThan: time
	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time * millisecond)! !


!CustomerBookTest methodsFor: 'checkingAmountOfCustumers' stamp: 'Alex 9/5/2023 17:14:07'!
thisCusumerBookhas: customerBook numberOfActiveCustumers: numberOfActiveCustumers numberOfSuspendedCustomers:numberOfSuspendedCustomers numberOfCustomers:numberOfCustomers 	
	self assert: numberOfActiveCustumers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.

! !

!CustomerBookTest methodsFor: 'checkingAmountOfCustumers' stamp: 'Alex 9/5/2023 17:57:30'!
xx: yy z: ppp zzz: t
	|y|
	y := OrderedCollection new.
	y add: [:anError | yy numberOfCustomers = 1.].
	y add: [:anError | (yy includesCustomerNamed: ppp) ].
	
	self checkThatFails: [ yy removeCustomerNamed: t.] withError: NotFound 
	andAssertTheseConditions: y.! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'removeANameInCollection' stamp: 'cielo 9/5/2023 00:14:47'!
removeIfExists: aName from: anOrderCollection
	1 to: anOrderCollection size do: 
	[ :index |
		aName = (anOrderCollection at: index)
			ifTrue: [
				anOrderCollection removeAt: index.
				^ aName 
			] 
	].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
