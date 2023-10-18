!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/9/2023 21:31:16'!
test01emptyPortfolioHas0Balance

	|emptyPortfolio |

	emptyPortfolio := Portfolio new.
	
	self assert: emptyPortfolio balance = 0. 
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 07:23:59'!
test02addOneAccountToPortfolioAndBalanceOfPortfolioIsThatAccountBalance

	|portfolio account|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	portfolio add: account.
	
	self assert: account balance equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 07:28:39'!
test04addMoraThanOneAccountReturnsTheBalanceOfAllAccounts

	|portfolio account account2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	account2 := ReceptiveAccount new.
	Deposit register: 50 on: account2.
	Withdraw register: 10 on: account2.
	portfolio add: account.
	portfolio add: account2.
	
	self assert: 90 equals: portfolio balance.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 07:37:08'!
test06noTransactionIfAccountsDoestHaveTransactions

	|portfolio account account2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account.
	portfolio add: account2.
	
	self assert: portfolio transactions isEmpty.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 08:08:56'!
test07oneAccountAddedToPortfolioAllItsTransactionsAreInPortfolio

	|portfolio account deposit|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account .	
	portfolio add: account.
	
	self assert: 1 equals: portfolio transactions size.
	self assert: portfolio transactions includes: deposit.	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 17:55:27'!
test08portfolioHasAllTransactionsFromAccountsAdded

	|portfolio account deposit account2 deposit2|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	deposit2 := Deposit register: 50 on: account2 .	
	portfolio add: account.
	portfolio add: account2.
	
	self assert: 2 equals: portfolio transactions size.
	self assert: portfolio transactions includes: deposit.	
	self assert: portfolio transactions includes: deposit2.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 18:11:11'!
test09PortfolioDoesntHaveTransactionRegistered

	|portfolio account deposit account2 deposit2 withdraw|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	deposit2 := Deposit register: 50 on: account2 .	
	portfolio add: account.
	
	withdraw := Withdraw register: 20  on: account2 .
	
	self assert: portfolio transactions includes: deposit.	
	self deny: (portfolio transactions includes: deposit2).
	self deny: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 18:13:18'!
test10PortfolioHasTransactionRegistered

	|portfolio account deposit withdraw|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.	
	portfolio add: account.
	
	withdraw := Withdraw register: 20  on: account .
	
	self assert: portfolio transactions includes: deposit.	
	self assert: (portfolio hasRegistered: withdraw).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 18:29:10'!
test11cantAddAnAccountToAPortfolioMoreThanOnce

	|portfolio account|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	
	self
		should: [portfolio add: account ] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = portfolio cantAddAccountAlreadyAdded ]
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/18/2023 17:58:49'!
test13canAddAnotherPortfolio

	|portfolio account portfolio2 account2 deposit|
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio add: account.
	portfolio2 add: account2.
	deposit := Deposit register: 100 on: account2. 
	
	portfolio addPortfolio: portfolio2 .
	
	self assert: portfolio balance equals: 100. 
	
	
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'cielo 10/12/2023 18:39:17'!
test14cantAddAPortfolioWithRepeatedAccounts

	|portfolio account portfolio2 |
	
	portfolio := Portfolio new.
	portfolio2 := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	portfolio2 add: account.
	
	self
		should: [portfolio add: portfolio2 ] 
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = portfolio cantAddPortfolioWithanAccountAlreadyAdded ]
	
	
! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'cielo 10/9/2023 20:59:06'!
impactInBalance: accountBalance
	
	^accountBalance + value! !

!Deposit methodsFor: 'value' stamp: 'cielo 10/9/2023 20:38:02'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'cielo 10/9/2023 20:48:04'!
initializeFor: aValue

	value := aValue! !


!Withdraw methodsFor: 'value' stamp: 'cielo 10/9/2023 20:58:42'!
impactInBalance: accountBalance
	
	^accountBalance - value! !

!Withdraw methodsFor: 'value' stamp: 'cielo 10/9/2023 20:46:41'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #BankAccounts category: 'Portfolio-Ejercicio'!
Object subclass: #BankAccounts
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
BankAccounts subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'cielo 10/18/2023 17:56:13'!
balance
	|acoountBalance portoliosBalance|

	acoountBalance:= accounts inject: 0 into: [:balance :account  | balance + account balance ].
	
	portoliosBalance:= portfolios inject: 0 into: [:balance :porfolio  | balance + porfolio balance ].
	
	^acoountBalance + portoliosBalance! !


!Portfolio methodsFor: 'addAccounts' stamp: 'cielo 10/12/2023 19:08:29'!
add: account 
	(accounts includes: account) ifTrue: [^self error: self cantAddAccountAlreadyAdded ].
	accounts add: account ! !

!Portfolio methodsFor: 'addAccounts' stamp: 'cielo 10/18/2023 18:04:17'!
addPortfolio: portfolio
	(portfolios includes: portfolio) ifTrue: [^self error: self cantAddPortfolioWithanAccountAlreadyAdded ].
	portfolios add: portfolio ! !


!Portfolio methodsFor: 'initialization' stamp: 'cielo 10/18/2023 17:54:27'!
initialize
	
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'accessing' stamp: 'cielo 10/18/2023 17:56:53'!
transactions

	| allTransactions |

	allTransactions := OrderedCollection new.

	accounts do: [ :account |
	    allTransactions addAll: account transactions.
	].

	portfolios do: [ :porfolio |
	    allTransactions addAll: porfolio transactions.
	].

	^ allTransactions.! !


!Portfolio methodsFor: 'registers' stamp: 'cielo 10/18/2023 17:58:21'!
hasRegistered: aTransaction 

	^(accounts anySatisfy: [:account | account transactions includes: aTransaction ]) or: 
	  (portfolios anySatisfy: [:porfolio | porfolio transactions includes: aTransaction ])
	! !


!Portfolio methodsFor: 'error handling' stamp: 'cielo 10/12/2023 18:23:40'!
cantAddAccountAlreadyAdded

	^'cant add account already added'! !

!Portfolio methodsFor: 'error handling' stamp: 'cielo 10/18/2023 18:01:14'!
cantAddPortfolioWithanAccountAlreadyAdded

	^'cant add portfolio already added'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
BankAccounts subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'cielo 10/9/2023 21:01:36'!
balance
	
	^transactions inject: 0 into: [ :accountBalance :aTransaction | aTransaction impactInBalance: accountBalance ].
! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
