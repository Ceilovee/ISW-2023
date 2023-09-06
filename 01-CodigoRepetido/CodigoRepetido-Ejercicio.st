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

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 23:40:56'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |		
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	self whenThisFails:[customerBook removeCustomerNamed: 'Paul McCartney'.] withError: NotFound inThisCustomerBook: customerBook stillHasThisCustomer: johnLennon andnumberOfCustomers: 1 .

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 23:35:21'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self thisCustomerBookhas:customerBook numberOfActiveCustomers:0 numberOfSuspendedCustomers:1 numberOfCustomers:1 .
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 23:35:11'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self thisCustomerBookhas:customerBook numberOfActiveCustomers:0 numberOfSuspendedCustomers:0 numberOfCustomers:0 .
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 23:43:18'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self whenThisFails:[customerBook suspendCustomerNamed: 'George Harrison'.] withError: CantSuspend  inThisCustomerBook: customerBook stillHasThisCustomer: johnLennon andnumberOfCustomers: 1 .
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'cielo 9/5/2023 23:43:48'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self whenThisFails:[customerBook suspendCustomerNamed: johnLennon.] withError: CantSuspend  inThisCustomerBook: customerBook stillHasThisCustomer: johnLennon andnumberOfCustomers: 1 .
! !


!CustomerBookTest methodsFor: 'checkingErrorsAreShownCorrectly' stamp: 'Alex 9/5/2023 17:41:25'!
checkThatFails: closureWithAnError withError: errorName andAssertTheseConditions: aCollectionOfConditions
	
	[ closureWithAnError value.
	self fail ]
		on: errorName
		do: [ :anError | 
			
			aCollectionOfConditions do: [:aCondition| self assert: (aCondition value: anError)]. ].
		! !

!CustomerBookTest methodsFor: 'checkingErrorsAreShownCorrectly' stamp: 'cielo 9/5/2023 23:42:31'!
whenThisFails: aFailingClosure  withError: aTypeOfError  inThisCustomerBook: aCustomerBook stillHasThisCustomer: aCustomerName andnumberOfCustomers: anumberOfCustomers
	|checksCustomersInTheBookAreCorrect|
	checksCustomersInTheBookAreCorrect := OrderedCollection new.
	checksCustomersInTheBookAreCorrect add: [:anError | aCustomerBook numberOfCustomers = anumberOfCustomers.].
	checksCustomersInTheBookAreCorrect add: [:anError | (aCustomerBook includesCustomerNamed: aCustomerName) ].
	
	self checkThatFails: aFailingClosure  withError: aTypeOfError 
	andAssertTheseConditions: checksCustomersInTheBookAreCorrect.! !


!CustomerBookTest methodsFor: 'checkingTimeExecution' stamp: 'cielo 9/5/2023 23:13:43'!
executeThis: aClosure wontLastMoreThan: time
	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (time * millisecond)! !


!CustomerBookTest methodsFor: 'checkingAmountOfCustumers' stamp: 'cielo 9/5/2023 23:34:50'!
thisCustomerBookhas: customerBook numberOfActiveCustomers: numberOfActiveCustomers numberOfSuspendedCustomers:numberOfSuspendedCustomers numberOfCustomers:numberOfCustomers 	
	self assert: numberOfActiveCustomers equals: customerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: customerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: customerBook numberOfCustomers.

! !


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


!CustomerBook methodsFor: 'customer management' stamp: 'cielo 9/5/2023 23:52:47'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'cielo 9/5/2023 23:48:50'!
removeCustomerNamed: aName 
 	self removeIfExists: aName from: active .
	self removeIfExists: aName from: suspended .

	^ NotFound signal.
! !

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


!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'signals' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !


!CustomerBook methodsFor: 'numbersOf' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'numbersOf' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'numbersOf' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

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
