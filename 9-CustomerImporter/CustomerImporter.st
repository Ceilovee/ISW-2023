!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'as yet unclassified' stamp: 'cielo 11/16/2023 01:18:41'!
assertAddress: address withProvince: province withZipCode: zipCode withStreetName: streetName withStreetNumber: streetNumber fromTown: town     

	self assert: address province equals: province.
	self assert: address zipCode equals: zipCode.
	self assert: address streetName equals: streetName.
	self assert: address streetNumber equals: streetNumber.
	self assert: address town equals: town! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'cielo 11/16/2023 01:14:07'!
assertCustomer: customer withFirstName: firstName withLastName: lastName withIdType: idType withIdNumber: idNumber    

	self assert: customer firstName equals: firstName.
	self assert: customer lastName equals: lastName.
	self assert: customer identificationType equals: idType.
	self assert: customer identificationNumber equals: idNumber! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'cielo 11/16/2023 01:09:40'!
getAddressFrom: addresses withProvince: aProvince 

	^ (addresses 
	select: [:anAddress | anAddress province = aProvince]) anyOne! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'cielo 11/16/2023 01:06:31'!
getCustomerWithIdType: idType withIdNumber: idNumber

	^ session 
	select: [:aCustomer | aCustomer identificationType = idType and: [aCustomer identificationNumber = idNumber]] 
	ofType: Customer! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AyC 11/13/2023 21:34:08'!
importCustomers: inputFile
	(Importer for: session withFile: inputFile) importCustomers! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'AyC 11/13/2023 21:12:04'!
test01Import

	self importCustomers: 'input.txt'.
	! !

!ImportTest methodsFor: 'as yet unclassified' stamp: 'cielo 11/16/2023 01:20:57'!
test01ImportBringsAllCustomersCorrectly

	|numberOfCustomers customers customer addresses address |

	self importCustomers: 'input.txt'.
	
	numberOfCustomers := (session selectAllOfType: Customer) size .
	
	self assert: numberOfCustomers equals: 2.
	
	customers := self getCustomerWithIdType: 'D' withIdNumber: '22333444'. 
	
	self assert: customers size equals: 1.
	
	customer := customers anyOne .
	
	self assertCustomer: customer withFirstName: 'Pepe' withLastName: 'Sanchez' withIdType: 'D' withIdNumber: '22333444'.
	
	addresses := customer addresses.
	
	address := self getAddressFrom: addresses withProvince: 'BsAs' .
	
	self assertAddress: address withProvince: 'BsAs' withZipCode: 1636 withStreetName: 'San Martin' withStreetNumber: 3322 fromTown: 'Olivos'.
	
	address := self getAddressFrom: addresses withProvince: 'Buenos Aires' .
	
	self assertAddress: address withProvince: 'Buenos Aires' withZipCode: 1122 withStreetName: 'Maipu' withStreetNumber:888 fromTown: 'Florida'.
	
	customers := self getCustomerWithIdType: 'C' withIdNumber: '23-25666777-9'. 
	
	self assert: customers size equals: 1.
	
	customer := customers anyOne .
	
	self assertCustomer: customer withFirstName: 'Juan' withLastName: 'Perez' withIdType: 'C' withIdNumber: '23-25666777-9'.
	
	addresses := customer addresses.

	address := self getAddressFrom: addresses withProvince: 'CABA' .
	
	self assertAddress: address withProvince: 'CABA' withZipCode:  1001withStreetName:'Alem' withStreetNumber:1122 fromTown: 'CABA'.
	
	
	
	
	
	
	

	
	! !


!ImportTest methodsFor: 'setup' stamp: 'AyC 11/13/2023 20:33:20'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction! !


!ImportTest methodsFor: 'teardown' stamp: 'AyC 11/13/2023 20:34:26'!
tearDown

	session commit.
	session close! !


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


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'AyC 11/13/2023 21:02:57'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Importer category: 'CustomerImporter'!
Object subclass: #Importer
	instanceVariableNames: 'session inputFile'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Importer methodsFor: 'initialization' stamp: 'AyC 11/13/2023 21:34:08'!
initializeFor: aSession withFile: anInputFile
	session := aSession.
	inputFile := anInputFile.! !


!Importer methodsFor: 'evaluating' stamp: 'AyC 11/13/2023 21:34:08'!
importCustomers

	"
	self importCustomers
	"
	| inputStream  newCustomer line |

	inputStream := UniFileStream new open: inputFile forWrite: false.

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth ].

		line := inputStream nextLine. ].

	inputStream close.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Importer class' category: 'CustomerImporter'!
Importer class
	instanceVariableNames: ''!

!Importer class methodsFor: 'instance creation' stamp: 'AyC 11/13/2023 21:34:08'!
for: aSession withFile: anInputFile
	^self new initializeFor: aSession withFile: anInputFile! !
