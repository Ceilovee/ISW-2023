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

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/23/2023 20:31:59'!
test01accountSumaryReturnsBalance0WhenNoTransactions
	| account report expectedReport |
	account := ReceptiveAccount new.
	report := AccountSumary from: account.
	expectedReport := OrderedCollection new.
	expectedReport add: 'Balance = 0'.
	self
		assert: report printReport
		equals: expectedReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/23/2023 20:32:43'!
test02accountSumaryReturnsBalanceAndTransactionsCorrectly
	| account report expectedReport |
	account := ReceptiveAccount new.
	Deposit
		register: 100
		on: account.
	report := AccountSumary from: account.
	expectedReport := OrderedCollection new.
	expectedReport add: 'Depósito por 100'.
	expectedReport add: 'Balance = 100'.
	self
		assert: report printReport
		equals: expectedReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/23/2023 20:35:01'!
test03accountSumaryReturnsBalanceAndWithdrawCorrectly
	| account report expectedReport |
	account := ReceptiveAccount new.
	Withdraw 
		register: 100
		on: account.
	report := AccountSumary from: account.
	expectedReport := OrderedCollection new.
	expectedReport add: 'Extracción por 100'.
	expectedReport add: 'Balance = -100'.
	self
		assert: report printReport
		equals: expectedReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/23/2023 21:36:03'!
test04accountSumaryReturnsBalanceAndTransferCorrectly
	| accountSend accountReceive reportSend reportReceive expectedReport1 expectedReport2|
	accountSend := ReceptiveAccount new.
	accountReceive := ReceptiveAccount new.
	Transfer register: 100 from: accountSend to: accountReceive .
	reportSend := AccountSumary from: accountSend .
	reportReceive := AccountSumary from: accountReceive.
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

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 19:35:47'!
test05portfolioSumaryReturnsBalanceAndTransferCorrectly
	| accountSend accountReceive report expectedReport portfolio|
	accountSend := ReceptiveAccount new.
	accountReceive := ReceptiveAccount new.
	Transfer register: 100 from: accountSend to: accountReceive .
	portfolio := Portfolio new.
	portfolio add: accountReceive .
	portfolio add: accountSend .
	report := AccountSumary from: portfolio .

	expectedReport := OrderedCollection new.
	expectedReport add: 'Entrada por transferencia de 100'.
	expectedReport add: 'Salida por transferencia de 100'.
	expectedReport add: 'Balance = 0'.
	self assert: report printReport equals: expectedReport ! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:16:05'!
test06accountTransferNetReturnsBalance0WhenNoTransactions
	| account report |
	account := ReceptiveAccount new.
	report := TransferNet from: account.

	self
		assert: report printReport
		equals: 'Balance = 0'.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:16:46'!
test07accountTransferNetReturnsBalanceAndTransferCorrectly
	| accountSend accountReceive reportSend reportReceive |
	accountSend := ReceptiveAccount new.
	accountReceive := ReceptiveAccount new.
	Transfer register: 100 from: accountSend to: accountReceive .
	reportSend := TransferNet from: accountSend .
	reportReceive := TransferNet from: accountReceive.
	
	
	self assert: reportReceive printReport equals: 'Balance = 100'.
	self assert: reportSend printReport equals: 'Balance = -100' .! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/22/2023 17:25:04'!
test01doATransferAffectsBalanceFromBothAccounts

	| accountSending accountReceive|
	accountReceive := ReceptiveAccount new.
	accountSending := ReceptiveAccount new.
	Transfer register: 50 from: accountSending to: accountReceive.
	
	self assert: accountSending balance equals: -50.
	self assert: accountReceive balance equals: 50.
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/22/2023 18:19:03'!
test02doATransferThenBothAccountsHaveItRegistered

	| accountSending accountReceive transfer|
	accountReceive := ReceptiveAccount new.
	accountSending := ReceptiveAccount new.
	transfer := Transfer register: 50 from: accountSending to: accountReceive.
	
	self assert: (accountSending hasRegistered: transfer sendingLeg).
	self assert: (accountReceive hasRegistered: transfer receivingLeg).
	
	
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/22/2023 18:41:41'!
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

!TransferTest methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/22/2023 18:51:43'!
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
	instanceVariableNames: ''
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


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'reports' stamp: 'cielo ale 10/24/2023 19:41:35'!
addTransactionsToSumary: summary for: anAccountSumary 
	self transactions do: [:transaction | transaction printFor: anAccountSumary in: summary ].
	
	^summary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
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


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'Alex} 10/25/2023 11:46:30'!
addTransactionsToSumary: summary
	transactions do: [:transaction | transaction printFor: summary].! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'cielo ale 10/24/2023 21:36:46'!
addTransactionsToSumary: report for: summary
	"transactions do: [ :transaction |
	    transaction printFor: summary in: report]."
	transactions inject: report into: [ :reportIterative :transaction |
	    transaction printFor: summary in: reportIterative].
	^ report.! !

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


!ReceptiveAccount methodsFor: 'composition' stamp: 'cielo ale 10/23/2023 21:55:16'!
accountSummary

	| accountSummary |
	accountSummary := AccountSumary for: self.
	
	^accountSummary printReport.! !

!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountSumary category: 'Portfolio-Solucion'!
Object subclass: #AccountSumary
	instanceVariableNames: 'account summary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 11:57:49'!
addDeposit: aDeposit
	summary add: ('Depósito por ' , aDeposit value printString).
	! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 19:22:09'!
addDepositOf: value in: report

	 report add: ('Depósito por ' , value printString).
	^report.
	
	

	! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 11:59:28'!
addTransferReceive: aTransferReceive
	summary add: ('Entrada por transferencia de ' , aTransferReceive value printString).

	! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 19:23:30'!
addTransferReceiveOf: value in: report

	 report add: ('Entrada por transferencia de ' , value printString).
	^report.
	
	

	! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 12:05:54'!
addTransferSend: aTransferSend
	summary add: ('Salida por transferencia de ' , aTransferSend value printString)! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 19:23:16'!
addTransferSendOf: value in: report

	 report add: ('Salida por transferencia de ' , value printString).
	^report.
	
	

	! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 12:06:09'!
addWithdraw: aWithdraw
	summary add: ('Extracción por ' , aWithdraw value printString)
! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 19:22:53'!
addWithdrawOf: value in: report

	 report add: ('Extracción por ' , value printString).
	^report.
	
	

	! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/23/2023 21:28:11'!
from: anAccount
	account := anAccount! !

!AccountSumary methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 12:01:56'!
printReport
	summary := OrderedCollection new.
	account addTransactionsToSumary: self.
	summary add: 'Balance = ' , account balance printString.
	^ summary.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSumary class' category: 'Portfolio-Solucion'!
AccountSumary class
	instanceVariableNames: ''!

!AccountSumary class methodsFor: 'class initialization' stamp: 'cielo ale 10/23/2023 21:26:55'!
from: anAccount
	^self new from: anAccount! !


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


!Deposit methodsFor: 'value' stamp: 'Alex} 10/25/2023 11:55:32'!
printFor: report
	^report addDeposit: self.! !

!Deposit methodsFor: 'value' stamp: 'cielo ale 10/24/2023 19:20:38'!
printFor: summary in: report
	
	^summary addDepositOf: value in: report.
	
	! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:31:19'!
affectBalance: aBalance 

	^aBalance + value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
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


!classDefinition: #TransferReceive category: 'Portfolio-Solucion'!
TransferPart subclass: #TransferReceive
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferReceive methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:33:09'!
affectBalance: aBalance 

	^transfer affectBalanceForReceivingAccount: aBalance .! !

!TransferReceive methodsFor: 'balance' stamp: 'Alex} 10/25/2023 11:53:56'!
printFor: report
	
	^report addTransferReceive: self! !

!TransferReceive methodsFor: 'balance' stamp: 'cielo ale 10/24/2023 19:29:21'!
printFor: summary in: report
	
	^transfer printReceiveFor: summary in: report! !


!TransferReceive methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 11:42:01'!
value
	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferReceive class' category: 'Portfolio-Solucion'!
TransferReceive class
	instanceVariableNames: ''!

!TransferReceive class methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/22/2023 18:30:09'!
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

!TransferSend methodsFor: 'balance' stamp: 'Alex} 10/25/2023 11:54:34'!
printFor: report
	
	^report addTransferSend: self! !

!TransferSend methodsFor: 'balance' stamp: 'cielo ale 10/24/2023 19:29:42'!
printFor: summary in: report
	
	^transfer printSendFor: summary in: report! !


!TransferSend methodsFor: 'as yet unclassified' stamp: 'Alex} 10/25/2023 11:41:45'!
value
	^transfer  value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferSend class' category: 'Portfolio-Solucion'!
TransferSend class
	instanceVariableNames: ''!

!TransferSend class methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/22/2023 18:31:06'!
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


!Withdraw methodsFor: 'value' stamp: 'Alex} 10/25/2023 11:52:47'!
printFor: report
	
	^report addWithdraw: self.! !

!Withdraw methodsFor: 'value' stamp: 'cielo ale 10/24/2023 19:25:06'!
printFor: summary in: report
	
	^summary addWithdrawOf: value in: report.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'cielo ale 10/22/2023 18:31:32'!
affectBalance: aBalance 

	^aBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value legReceiving legSending'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initilization' stamp: 'cielo ale 10/22/2023 18:59:29'!
register: aValue from: anAccountSending to: anAccountReceive 

	value:= aValue .
	legReceiving := TransferReceive from: self.
	legSending := TransferSend from: self.
	anAccountSending register: legSending .
	anAccountReceive register: legReceiving .
	! !


!Transfer methodsFor: 'accessing' stamp: 'cielo ale 10/24/2023 19:28:32'!
printReceiveFor: summary in: report
	
	^summary addTransferReceiveOf: value in: report.! !

!Transfer methodsFor: 'accessing' stamp: 'cielo ale 10/24/2023 19:29:00'!
printSendFor: summary in: report
	
	^summary addTransferSendOf: value in: report.! !

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


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Object subclass: #TransferNet
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:22:01'!
addDepositOf: value in: report

	^report! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:15:44'!
addTransferReceiveOf: value in: report

	^report + value.! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:15:20'!
addTransferSendOf: value in: report

	^report - value .! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:21:53'!
addWithdrawOf: value in: report

	^report! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:07:36'!
from: anAccount
	
	account := anAccount ! !

!TransferNet methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:29:30'!
printReport
	|value|
	
	value := 0.
	account addTransactionsToSumary: value for: self.

	
	^'Balance = ', value printString .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'cielo ale 10/24/2023 21:07:20'!
from: anAccount
	^self new from: anAccount! !
