!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:33:53'!
test01accountSumaryReturnsBalance0WhenNoTransactions
	| account report expectedReport |
	account := ReceptiveAccount new.
	report := AccountSummary from: account.
	expectedReport := OrderedCollection new.
	expectedReport add: 'Balance = 0'.
	self
		assert: report printReport
		equals: expectedReport.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:33:52'!
test02accountSumaryReturnsBalanceAndTransactionsCorrectly
	| account report expectedReport |
	account := ReceptiveAccount new.
	Deposit
		register: 100
		on: account.
	report := AccountSummary from: account.
	expectedReport := OrderedCollection new.
	expectedReport add: 'Depósito por 100'.
	expectedReport add: 'Balance = 100'.
	self
		assert: report printReport
		equals: expectedReport.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:33:52'!
test03accountSumaryReturnsBalanceAndWithdrawCorrectly
	| account report expectedReport |
	account := ReceptiveAccount new.
	Withdraw 
		register: 100
		on: account.
	report := AccountSummary from: account.
	expectedReport := OrderedCollection new.
	expectedReport add: 'Extracción por 100'.
	expectedReport add: 'Balance = -100'.
	self
		assert: report printReport
		equals: expectedReport.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:33:52'!
test04accountSumaryReturnsBalanceAndTransferCorrectly
	| accountSend accountReceive reportSend reportReceive expectedReport1 expectedReport2|
	accountSend := ReceptiveAccount new.
	accountReceive := ReceptiveAccount new.
	Transfer register: 100 from: accountSend to: accountReceive .
	reportSend := AccountSummary from: accountSend .
	reportReceive := AccountSummary from: accountReceive.
	expectedReport1 := OrderedCollection new.
	expectedReport1 add: 'Entrada por transferencia de 100'.
	expectedReport1 add: 'Balance = 100'.
	
	expectedReport2 := OrderedCollection new.
	expectedReport2 add: 'Salida por transferencia de 100'.
	expectedReport2 add: 'Balance = -100'.
	self
		assert: reportReceive printReport
		equals: expectedReport1.
	self assert: reportSend printReport equals: expectedReport2 .! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:33:53'!
test05portfolioSumaryReturnsBalanceAndTransferCorrectly
	| accountSend accountReceive report expectedReport portfolio|
	accountSend := ReceptiveAccount new.
	accountReceive := ReceptiveAccount new.
	Transfer register: 100 from: accountSend to: accountReceive .
	portfolio := Portfolio new.
	portfolio add: accountReceive .
	portfolio add: accountSend .
	report := AccountSummary from: portfolio .

	expectedReport := OrderedCollection new.
	expectedReport add: 'Entrada por transferencia de 100'.
	expectedReport add: 'Salida por transferencia de 100'.
	expectedReport add: 'Balance = 0'.
	self assert: report printReport equals: expectedReport ! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:46:22'!
test06accountTransferNetReturnsBalance0WhenNoTransactions
	| account report |
	account := ReceptiveAccount new.
	report := TransferNet from: account.

	self
		assert: report printReport equals: 0.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 14:46:42'!
test07accountTransferNetReturnsBalanceAndTransferCorrectly
	| accountSend accountReceive reportSend reportReceive |
	accountSend := ReceptiveAccount new.
	accountReceive := ReceptiveAccount new.
	Transfer register: 100 from: accountSend to: accountReceive .
	reportSend := TransferNet from: accountSend .
	reportReceive := TransferNet from: accountReceive.
	
	
	self assert: reportReceive printReport equals: 100.
	self assert: reportSend printReport equals: -100 .! !

!ReportTest methodsFor: 'Test' stamp: 'cielo 10/26/2023 00:05:30'!
test08TreeReportforEmptyPortfolio

	| expectedReport portfolio report |
	portfolio := Portfolio named: 'Portfolio'.
	
	report := TreeReport for: portfolio.
	expectedReport := OrderedCollection new.
	expectedReport add: portfolio nameOf.
	
	self assert: report printReport equals: expectedReport.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 16:34:06'!
test09TreeReportforPortfolioWithOneAccount

	| expectedReport portfolio report account |
	account := ReceptiveAccount named: 'Cuenta 1'.
	portfolio := Portfolio with: account named: 'Portfolio'.
	
	report := TreeReport for: portfolio.
	expectedReport := OrderedCollection new.
	expectedReport add: portfolio nameOf.
	expectedReport add: '   ' , account nameOf.
	
	self assert: report printReport equals: expectedReport.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 16:33:39'!
test10TreeReportforPortfolioWithOneAccountHasEspace

	| expectedReport portfolio report account |
	account := ReceptiveAccount named: 'Cuenta 1'.
	portfolio := Portfolio with: account named: 'Portfolio'.
	
	report := TreeReport for: portfolio.
	expectedReport := OrderedCollection new.
	expectedReport add: portfolio nameOf.
	expectedReport add: ('   ', account nameOf).
	
	self assert: report printReport equals: expectedReport.! !

!ReportTest methodsFor: 'Test' stamp: 'Alex 10/26/2023 16:49:40'!
test11TreeReportforPortfolioWithPortfolioWithTwoAccountHasTheRespectiveSpaces

	| expectedReport portfolio portfolioInPortfolio report account1 account2 |
	account1 := ReceptiveAccount named: 'Cuenta 1'.
	account2 := ReceptiveAccount named: 'Cuenta 2'.
	portfolioInPortfolio := Portfolio with: account1 named: 'Portfolio hijo'.
	portfolioInPortfolio add: account2.
	portfolio := Portfolio with: portfolioInPortfolio named: 'Portfolio padre'.
	
	report := TreeReport for: portfolio.
	expectedReport := OrderedCollection new.
	expectedReport add: portfolio nameOf.
	expectedReport add: ('   ', portfolioInPortfolio nameOf).
	expectedReport add: ('      ', account1 nameOf).
	expectedReport add: ('      ', account2 nameOf).
	
	self assert: report printReport equals: expectedReport.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'Test' stamp: 'cielo ale 10/22/2023 17:25:04'!
test01doATransferAffectsBalanceFromBothAccounts

	| accountSending accountReceive|
	accountReceive := ReceptiveAccount new.
	accountSending := ReceptiveAccount new.
	Transfer register: 50 from: accountSending to: accountReceive.
	
	self assert: accountSending balance equals: -50.
	self assert: accountReceive balance equals: 50.
	
	
! !

!TransferTest methodsFor: 'Test' stamp: 'cielo ale 10/22/2023 18:19:03'!
test02doATransferThenBothAccountsHaveItRegistered

	| accountSending accountReceive transfer|
	accountReceive := ReceptiveAccount new.
	accountSending := ReceptiveAccount new.
	transfer := Transfer register: 50 from: accountSending to: accountReceive.
	
	self assert: (accountSending hasRegistered: transfer sendingLeg).
	self assert: (accountReceive hasRegistered: transfer receivingLeg).
	
	
! !

!TransferTest methodsFor: 'Test' stamp: 'cielo ale 10/22/2023 18:41:41'!
test03cantSendToTheSameAccount

	| account |
	account := ReceptiveAccount new..
	
	self 
		should: [Transfer register: 50 from: account to: account. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: account balance equals: 0.
			self assert: Transfer theReceivingAndSendingAccountCanNotBeTheSame equals: anError messageText.]
	
	
! !

!TransferTest methodsFor: 'Test' stamp: 'cielo ale 10/22/2023 18:51:43'!
test04CanTransferOnlyPositiveValues

	| accountSending accountReceive |
	accountReceive := ReceptiveAccount new.
	accountSending := ReceptiveAccount new.
	
	self 
		should: [Transfer register: -50 from: accountSending to: accountReceive. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: accountSending balance equals: 0.
			self assert: accountReceive balance equals: 0.
			self assert: Transfer cantTransferThisAmount equals: anError messageText.]
	
	
! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: 'Portfolio' category: 'Portfolio-Solucion'!
Account subclass: 'Portfolio'
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'Alex 10/26/2023 16:14:15'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'Alex 10/26/2023 16:14:26'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'Alex 10/26/2023 16:14:37'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'Alex 10/26/2023 16:14:49'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'Alex 10/26/2023 16:14:59'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'Alex 10/26/2023 16:15:13'!
initialize
	name:= ''.
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'Alex 10/26/2023 16:15:24'!
initializeNamed: aName

	name := aName .
	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'Alex 10/26/2023 16:19:30'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'Alex 10/26/2023 16:19:52'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'Alex 10/26/2023 16:19:40'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'Alex 10/26/2023 16:20:03'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'Alex 10/26/2023 16:20:32'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'Alex 10/26/2023 16:20:22'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'Alex 10/26/2023 16:20:13'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'Alex 10/26/2023 16:21:03'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'Alex 10/26/2023 16:20:52'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].! !

!Portfolio methodsFor: 'account management - private' stamp: 'Alex 10/26/2023 16:20:43'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'Alex 10/26/2023 16:22:13'!
addTransactionsToReport: anAccountSumary 
	self transactions do: [:transaction | transaction printFor: anAccountSumary ].
! !

!Portfolio methodsFor: 'reports' stamp: 'Alex 10/26/2023 16:21:31'!
nameOf
	^name! !

!Portfolio methodsFor: 'reports' stamp: 'Alex 10/26/2023 16:46:55'!
printTreeReportFor: treeReport
	
	treeReport addNamePortfolio: name.
	accounts do: [:account | account printTreeReportFor: treeReport ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error handling' stamp: 'Alex 10/26/2023 16:17:19'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'initialization' stamp: 'Alex 10/26/2023 16:15:48'!
named: aName
	^self new initializeNamed: aName! !

!Portfolio class methodsFor: 'initialization' stamp: 'Alex 10/26/2023 16:17:03'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'initialization' stamp: 'Alex 10/26/2023 16:16:24'!
with: account named: aName  
	^(self new initializeNamed: aName)
		add: account; yourself.! !

!Portfolio class methodsFor: 'initialization' stamp: 'Alex 10/26/2023 16:16:45'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'cielo 10/26/2023 00:04:01'!
initializeNamed: aName
	
	name:= aName .
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'cielo 10/26/2023 00:04:33'!
nameOf
	^name! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:33:44'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'report' stamp: 'Alex 10/26/2023 13:02:42'!
addTransactionsToReport: aReport
	transactions do: [:transaction | transaction printFor: aReport].! !

!ReceptiveAccount methodsFor: 'report' stamp: 'Alex 10/26/2023 16:46:38'!
printTreeReportFor: treeReport
	
	treeReport addNameAccount: name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'cielo 10/25/2023 23:57:51'!
named: aName

	^self new initializeNamed: aName ! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 17:41:39'!
affectBalance: aBalance forAccount: anAccount

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'for reports' stamp: 'Alex 10/26/2023 12:30:28'!
printFor: report

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:31:19'!
affectBalance: aBalance 

	^aBalance + value ! !


!Deposit methodsFor: 'for reports' stamp: 'Alex 10/26/2023 13:03:26'!
printFor: report
	^report addDepositToReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'Alex 10/26/2023 14:44:35'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferPart category: 'Portfolio-Solucion'!
AccountTransaction subclass: #TransferPart
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferPart methodsFor: 'initialization' stamp: 'cielo ale 10/22/2023 19:04:07'!
initializeFor: aTransfer
	
	transfer := aTransfer .! !


!TransferPart methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 19:04:29'!
affectBalance: aBalance

	self subclassResponsibility! !


!TransferPart methodsFor: 'value' stamp: 'Alex 10/26/2023 14:43:24'!
value
	^transfer value! !


!classDefinition: #TransferReceive category: 'Portfolio-Solucion'!
TransferPart subclass: #TransferReceive
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferReceive methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:33:09'!
affectBalance: aBalance 

	^transfer affectBalanceForReceivingAccount: aBalance .! !


!TransferReceive methodsFor: 'for report' stamp: 'cielo 10/25/2023 21:10:09'!
printFor: report
	
	transfer printReceiveFor: report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferReceive class' category: 'Portfolio-Solucion'!
TransferReceive class
	instanceVariableNames: ''!

!TransferReceive class methodsFor: 'as yet unclassified' stamp: 'Alex 10/26/2023 14:45:14'!
from: aTransfer

	^self new initializeFor: aTransfer .! !


!classDefinition: #TransferSend category: 'Portfolio-Solucion'!
TransferPart subclass: #TransferSend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSend methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:32:47'!
affectBalance: aBalance 

	^transfer affectBalanceForSendingAccount: aBalance .! !


!TransferSend methodsFor: 'for report' stamp: 'cielo 10/25/2023 21:10:36'!
printFor: report
	
	transfer printSendFor: report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSend class' category: 'Portfolio-Solucion'!
TransferSend class
	instanceVariableNames: ''!

!TransferSend class methodsFor: 'as yet unclassified' stamp: 'Alex 10/26/2023 14:45:24'!
from: aTransfer

	^self new initializeFor: aTransfer .! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:31:32'!
affectBalance: aBalance 

	^aBalance - value! !


!Withdraw methodsFor: 'for reports' stamp: 'Alex 10/26/2023 13:03:56'!
printFor: report
	
	^report addWithdrawToReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'Alex 10/26/2023 14:44:49'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Reports category: 'Portfolio-Solucion'!
Object subclass: #Reports
	instanceVariableNames: 'account report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Reports methodsFor: 'add' stamp: 'Alex 10/26/2023 12:23:49'!
addDepositToReport: value

	self subclassResponsibility! !

!Reports methodsFor: 'add' stamp: 'Alex 10/26/2023 14:28:37'!
addTransferReceiveToReport: aTransfer

	self subclassResponsibility! !

!Reports methodsFor: 'add' stamp: 'Alex 10/26/2023 12:24:21'!
addTransferSendToReport: value

	self subclassResponsibility! !

!Reports methodsFor: 'add' stamp: 'Alex 10/26/2023 13:45:01'!
addWithdrawToReport: aWithdraw

	self subclassResponsibility! !


!Reports methodsFor: 'print' stamp: 'cielo 10/25/2023 21:21:05'!
printReport

	self subclassResponsibility! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Reports subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'Initialization' stamp: 'Alex 10/26/2023 14:31:49'!
initializeFor: anAccount
	account := anAccount! !


!AccountSummary methodsFor: 'add' stamp: 'Alex 10/26/2023 14:37:02'!
addBalanceToReport

	^ report add: 'Balance = ' , account balance printString! !

!AccountSummary methodsFor: 'add' stamp: 'Alex 10/26/2023 13:08:42'!
addDepositToReport: aDeposit
	report add: ('Depósito por ' , aDeposit value printString).
	! !

!AccountSummary methodsFor: 'add' stamp: 'Alex 10/26/2023 14:37:51'!
addTransferReceiveToReport: aTransfer
	report add: ('Entrada por transferencia de ' , aTransfer value printString).

	! !

!AccountSummary methodsFor: 'add' stamp: 'Alex 10/26/2023 14:38:10'!
addTransferSendToReport: aTransfer
	report add: ('Salida por transferencia de ' , aTransfer value printString)! !

!AccountSummary methodsFor: 'add' stamp: 'Alex 10/26/2023 14:38:30'!
addWithdrawToReport: aWithdraw
	report add: ('Extracción por ' , aWithdraw value printString)
! !


!AccountSummary methodsFor: 'print' stamp: 'Alex 10/26/2023 14:37:02'!
printReport
	report := OrderedCollection new.
	account addTransactionsToReport: self.
	self addBalanceToReport.
	^report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'initialization' stamp: 'Alex 10/26/2023 14:34:29'!
from: anAccount
	^self new initializeFor: anAccount! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Reports subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'Initialization' stamp: 'Alex 10/26/2023 14:31:49'!
initializeFor: anAccount
	
	account := anAccount ! !


!TransferNet methodsFor: 'add' stamp: 'Alex 10/26/2023 13:42:53'!
addDepositToReport: aDeposit! !

!TransferNet methodsFor: 'add' stamp: 'Alex 10/26/2023 13:44:22'!
addTransferReceiveToReport: aTransfer 
	report := report + aTransfer value ! !

!TransferNet methodsFor: 'add' stamp: 'Alex 10/26/2023 13:44:22'!
addTransferSendToReport: aTransfer 
	report := report - aTransfer value .! !

!TransferNet methodsFor: 'add' stamp: 'Alex 10/26/2023 13:43:03'!
addWithdrawToReport: aWithdraw! !


!TransferNet methodsFor: 'print' stamp: 'Alex 10/26/2023 13:46:03'!
printReport	report := 0.
	account addTransactionsToReport: self .
	^report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'Initialization' stamp: 'Alex 10/26/2023 14:34:17'!
from: anAccount
	^self new initializeFor: anAccount! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value legReceiving legSending'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initilization' stamp: 'Alex 10/26/2023 14:33:52'!
register: aValue from: anAccountSending to: anAccountReceive 

	value:= aValue .
	legReceiving := TransferReceive from: self.
	legSending := TransferSend from: self.
	anAccountSending register: legSending .
	anAccountReceive register: legReceiving .
	! !


!Transfer methodsFor: 'accessing' stamp: 'cielo ale 10/22/2023 18:36:24'!
receivingLeg
	^legReceiving ! !

!Transfer methodsFor: 'accessing' stamp: 'cielo ale 10/22/2023 18:36:01'!
sendingLeg
	^legSending ! !

!Transfer methodsFor: 'accessing' stamp: 'Alex} 10/25/2023 11:41:16'!
value
	^value! !


!Transfer methodsFor: 'affectBalance' stamp: 'cielo ale 10/22/2023 18:34:17'!
affectBalanceForReceivingAccount: aBalance
	
	^aBalance + value ! !

!Transfer methodsFor: 'affectBalance' stamp: 'cielo ale 10/22/2023 18:34:05'!
affectBalanceForSendingAccount: aBalance
	
	^aBalance - value ! !


!Transfer methodsFor: 'for report' stamp: 'Alex 10/26/2023 13:04:57'!
printReceiveFor:  report
	report addTransferReceiveToReport: self .! !

!Transfer methodsFor: 'for report' stamp: 'Alex 10/26/2023 13:05:06'!
printSendFor: report
	report addTransferSendToReport: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'class initialization' stamp: 'cielo ale 10/22/2023 18:52:50'!
cantTransferThisAmount

	^'cant Transfer This Amount!! The amount can only be positive'! !

!Transfer class methodsFor: 'class initialization' stamp: 'cielo ale 10/22/2023 18:54:20'!
checkAmountValid: value

   (value > 0 ) ifFalse: [^self error: self cantTransferThisAmount ].! !

!Transfer class methodsFor: 'class initialization' stamp: 'cielo ale 10/22/2023 18:48:30'!
checkIsValidTranferfrom: accountSending to: accountReceive 

   (accountSending = accountReceive ) ifTrue: [^self error: self theReceivingAndSendingAccountCanNotBeTheSame ].! !

!Transfer class methodsFor: 'class initialization' stamp: 'cielo ale 10/22/2023 18:53:10'!
register: value from: accountSending to: accountReceive 

	self checkIsValidTranferfrom: accountSending to: accountReceive .
	self checkAmountValid: value.
	^self new register: value from: accountSending to: accountReceive .! !

!Transfer class methodsFor: 'class initialization' stamp: 'cielo ale 10/22/2023 18:52:11'!
theReceivingAndSendingAccountCanNotBeTheSame

	^'the Receiving And Sending Account Can Not Be The Same!!'! !


!classDefinition: #TreeReport category: 'Portfolio-Solucion'!
Object subclass: #TreeReport
	instanceVariableNames: 'portfolio report space'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeReport methodsFor: 'add' stamp: 'Alex 10/26/2023 16:06:01'!
addNameAccount: aName 
	
	report add: (space, aName) .! !

!TreeReport methodsFor: 'add' stamp: 'Alex 10/26/2023 16:34:27'!
addNamePortfolio: aName
	
	report add: (space, aName).
	space:= (space, '   ').! !


!TreeReport methodsFor: 'initialization' stamp: 'cielo 10/25/2023 23:52:39'!
for: aPortfolio

	portfolio := aPortfolio ! !


!TreeReport methodsFor: 'actual reporting' stamp: 'Alex 10/26/2023 16:05:02'!
printReport

	report := OrderedCollection new.
	space := ''.
	portfolio printTreeReportFor: self.
	
	^report! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreeReport class' category: 'Portfolio-Solucion'!
TreeReport class
	instanceVariableNames: ''!

!TreeReport class methodsFor: 'class initialization' stamp: 'cielo 10/25/2023 23:52:07'!
for: aPortfolio 
	^self new for: aPortfolio ! !
