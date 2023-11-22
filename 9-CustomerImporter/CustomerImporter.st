!classDefinition: #PersistentSet category: 'CustomerImporter'!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: 'CustomerImporter'!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 18:17:51'!
test01Import

	CustomerImporter valueFrom: self validImportData into: session..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'Ale 11/16/2023 19:44:55'!
test02ImportCustomerDataWithLessFieldsThrowsAnError
	
	self should: [CustomerImporter valueFrom: self customerDataWithLessFields into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter incorrectNumberOfFieldsOnTheImportingData.
			self assert: 0 equals: (session selectAllOfType: Customer) size]
	! !

!ImportTest methodsFor: 'tests' stamp: 'Ale 11/16/2023 19:54:30'!
test03ImportCustomerDataWithMoreFieldsThrowsAnError
	
	self should: [CustomerImporter valueFrom: self customerDataWithMoreFields into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter incorrectNumberOfFieldsOnTheImportingData.
			self assert: 0 equals: (session selectAllOfType: Customer) size]
	! !

!ImportTest methodsFor: 'tests' stamp: 'Ale 11/16/2023 20:03:37'!
test04ImportAddressDataWithLessFieldsThrowsAnError
	
	self should: [CustomerImporter valueFrom: self addressDataWithLessFields into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter incorrectNumberOfFieldsOnTheImportingData.
			self assert: 0 equals: (session selectAllOfType: Address) size]
	! !

!ImportTest methodsFor: 'tests' stamp: 'Ale 11/16/2023 20:04:43'!
test05ImportAddressDataWithMoreFieldsThrowsAnError
	
	self should: [CustomerImporter valueFrom: self addressDataWithMoreFields into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter incorrectNumberOfFieldsOnTheImportingData.
			self assert: 0 equals: (session selectAllOfType: Address) size]
	! !

!ImportTest methodsFor: 'tests' stamp: 'cielo y ale 11/22/2023 17:12:52'!
test06ImportingAddressForNoCustomerThrowsAnError
	
	
	self should: [CustomerImporter valueFrom: self onlyAddressData into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter firstLineShouldBeACustomer.
			self assert: 0 equals: (session selectAllOfType: Customer) size.
			self assert: 0 equals: (session selectAllOfType: Address) size.]
	! !

!ImportTest methodsFor: 'tests' stamp: 'cielo y ale 11/22/2023 17:50:39'!
test07whenTryingToImportEmptyFileTHrowsAnError
	
	
	self should: [CustomerImporter valueFrom: self emptyData into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter cantImportEmptyRecord.
			self assert: 0 equals: (session selectAllOfType: Customer) size.
			self assert: 0 equals: (session selectAllOfType: Address) size.]
	! !

!ImportTest methodsFor: 'tests' stamp: 'cielo y ale 11/22/2023 18:12:20'!
test08whenImportingARecordNotAddressOrCustomerThrowsAnError
	
	
	self should: [CustomerImporter valueFrom: self invalidImportData into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter notAValidRecord.
			self assert: 0 equals: (session selectAllOfType: Customer) size.
			self assert: 0 equals: (session selectAllOfType: Address) size.]
	! !

!ImportTest methodsFor: 'tests' stamp: 'cielo y ale 11/22/2023 18:16:00'!
test09whenImportingCustomerWithInvalidTypeThrowsAnError
	
	
	self should: [CustomerImporter valueFrom: self invalidCustomer into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter notAValidRecord.
			self assert: 0 equals: (session selectAllOfType: Customer) size.
			self assert: 0 equals: (session selectAllOfType: Address) size.]
	! !

!ImportTest methodsFor: 'tests' stamp: 'cielo y ale 11/22/2023 18:17:37'!
test10whenImportingAddressWithInvalidTypeThrowsAnError
	
	
	self should: [CustomerImporter valueFrom: self invalidAddress into: session]
	raise: Error
	withExceptionDo: [:anError | 
			self assert: anError messageText equals: CustomerImporter notAValidRecord.
			self assert: 1 equals: (session selectAllOfType: Customer) size.
			self assert: 0 equals: (session selectAllOfType: Address) size.]
	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:27:57'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := self customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:12:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: (session selectAllOfType: Customer) size! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 11/16/2023 19:02:04'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 00:28:23'!
tearDown

	session commit.
	session close.
	! !


!ImportTest methodsFor: 'customer' stamp: 'HAW 5/22/2022 18:14:22'!
customerWithIdentificationType: anIdType number: anIdNumber

	^ (session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !


!ImportTest methodsFor: 'test data' stamp: 'Ale 11/16/2023 19:59:14'!
addressDataWithLessFields

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'Ale 11/16/2023 20:05:53'!
addressDataWithMoreFields

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San,Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'Ale 11/16/2023 19:43:02'!
customerDataWithLessFields

	^ ReadStream on:
'C,Pepe,Sanchez,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'Ale 11/16/2023 19:55:32'!
customerDataWithMoreFields

	^ ReadStream on:
'C,Pepe,Pablo,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test data' stamp: 'cielo y ale 11/22/2023 18:01:27'!
emptyData

	^ReadStream on: '
	'! !

!ImportTest methodsFor: 'test data' stamp: 'cielo y ale 11/22/2023 18:16:45'!
invalidAddress

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs
'! !

!ImportTest methodsFor: 'test data' stamp: 'cielo y ale 11/22/2023 18:12:05'!
invalidCustomer 

	^ ReadStream on:
'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'cielo y ale 11/22/2023 18:03:17'!
invalidImportData

	^ ReadStream on:
'K,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'cielo y ale 11/22/2023 17:10:50'!
onlyAddressData

	^ ReadStream on:
'A,San Martin,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session readStream line newCustomer record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 18:06:47'!
initializeFrom: aReadStream into: aSession
	session := aSession.
	readStream := aReadStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 18:06:57'!
checkNotEmptyRecord

	^ record isEmpty ifTrue: [self error: self class cantImportEmptyRecord]! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 17:44:27'!
createAddressRecord

	|  newAddress |
	
			self checkCustomerForThisAddress.		
			self checkAddressRecordSize.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 17:40:14'!
createCustomerRecord

			self checkCustomerRecordSize.
			newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 17:38:23'!
getRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 18:06:35'!
notValidRecord

	^ self error: self class notAValidRecord! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 18:06:57'!
saveRecord

	self checkNotEmptyRecord.

	self isCustomerLine ifTrue: [ ^self createCustomerRecord ].
	self isAddressLine ifTrue: [ ^self createAddressRecord ].
	
	self notValidRecord.! !

!CustomerImporter methodsFor: 'evaluating' stamp: 'cielo y ale 11/22/2023 17:46:05'!
value
	
	[self checkNextLineNotEmpty ] whileTrue: [
		self getRecord.
		self saveRecord.
		 ].

	! !


!CustomerImporter methodsFor: 'checks' stamp: 'cielo y ale 11/22/2023 17:40:34'!
checkAddressRecordSize

	^ record size ~= 6 ifTrue: [self error: self class incorrectNumberOfFieldsOnTheImportingData]! !

!CustomerImporter methodsFor: 'checks' stamp: 'cielo y ale 11/22/2023 17:44:27'!
checkCustomerForThisAddress

	^ newCustomer isNil ifTrue: [self error: self class firstLineShouldBeACustomer]! !

!CustomerImporter methodsFor: 'checks' stamp: 'cielo y ale 11/22/2023 17:40:14'!
checkCustomerRecordSize

	^ record size ~= 5 ifTrue: [self error: self class incorrectNumberOfFieldsOnTheImportingData]! !

!CustomerImporter methodsFor: 'checks' stamp: 'cielo y ale 11/22/2023 17:33:43'!
checkNextLineNotEmpty

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'checks' stamp: 'cielo y ale 11/22/2023 18:17:12'!
isAddressLine

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'checks' stamp: 'cielo y ale 11/22/2023 18:15:10'!
isCustomerLine

	^ record first = 'C'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 18:06:47'!
from: aReadStream into: aSession
	^self new initializeFrom: aReadStream into: aSession! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 18:11:27'!
valueFrom: aReadStream into: aSession

	^(self from: aReadStream into: aSession) value! !


!CustomerImporter class methodsFor: 'errors' stamp: 'cielo y ale 11/22/2023 17:57:23'!
cantImportEmptyRecord
	^'cant Import an Empty Record'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'cielo y ale 11/22/2023 17:13:23'!
firstLineShouldBeACustomer
	^'the first Line Should Be A Customer'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'Ale 11/16/2023 19:46:23'!
incorrectNumberOfFieldsOnTheImportingData
	^'This file has not the corrrect number of fields for the importing'! !

!CustomerImporter class methodsFor: 'errors' stamp: 'cielo y ale 11/22/2023 18:06:09'!
notAValidRecord
	^'the file has a not valid record type'! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
