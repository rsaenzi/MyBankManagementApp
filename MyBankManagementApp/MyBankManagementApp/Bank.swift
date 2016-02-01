//
//  Bank.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation

class Bank {
    
    // -------------------------
    // Members
    // -------------------------
    
    var clients: [Client]
    
    var selectedClientId: Int
    var selectedAccountId: Int
    var selectedTransactionId: Int
    
    var selectedStartDateForReport: NSDate
    var selectedEndDateForReport: NSDate
    
    
    // -------------------------
    // Singleton
    // -------------------------
    
    static let instance = Bank()
    private init() {
        
        // Persistence parsing
        clients = Persistence.instance.getAllClients()
        
        for currentClient in clients {
            currentClient.accounts = Persistence.instance.getAllAccountsForClient(currentClient)
            
            for currentAccount in currentClient.accounts {
                currentAccount.transactions = Persistence.instance.getAllTransactionsForAccount(currentAccount)
            }
        }
        
        // Initialization
        selectedClientId = 0
        selectedAccountId = 0
        selectedTransactionId = 0
        
        selectedStartDateForReport = NSDate()
        selectedEndDateForReport = NSDate()
    }
    
    
    // -------------------------
    // Business Rules
    // -------------------------
    
    func createClient(newClient: Client){
        
        // Memory
        clients.insert(newClient, atIndex: 0)
        
        // Persistence
        let id = Persistence.instance.addClient(newClient)
        newClient.databaseId = id
    }
    func deleteClient(clientIndex: Int, clientToDelete: Client){
        
        // Persistence
        Persistence.instance.deleteClient(clientToDelete)
        
        // Memory
        clients.removeAtIndex(clientIndex)
    }
    func editClient(clientToEdit: Client, newName: String, newAddress: String, newPhone: String){
        
        // Memory
        clientToEdit.name = newName
        clientToEdit.address = newAddress
        clientToEdit.phone = newPhone
        
        // Persistence
        Persistence.instance.editClient(clientToEdit)
    }
    
    
    
    func createAccount(newAccount: Account){
        
        // Memory
        getSelectedClient().accounts.insert(newAccount, atIndex: 0)
        
        // Persistence
        let id = Persistence.instance.addAccount(newAccount, toClient: getSelectedClient())
        newAccount.databaseId = id
    }
    func deleteAccount(accountIndex: Int, accountToDelete: Account){
        
        // Persistence
        Persistence.instance.deleteAccount(accountToDelete)
        
        // Memory
        getSelectedClient().accounts.removeAtIndex(accountIndex)
    }
    func editAccount(accountToEdit: Account, newName: String, newNumber: String, newBalance: Int64){
        
        // Memory
        accountToEdit.name = newName
        accountToEdit.number = newNumber
        accountToEdit.balance = newBalance
        
        // Persistence
        Persistence.instance.editAccount(accountToEdit)
    }
    
    
    func addTransactionToAccount(newTrasaction: Transaction){
        
        // Memory
        getSelectedAccount().transactions.insert(newTrasaction, atIndex: 0)
        
        // - Balance update
        if newTrasaction.type == TransactionType.Debit {
            getSelectedAccount().balance = getSelectedAccount().balance + newTrasaction.amount
        }else{
            getSelectedAccount().balance = getSelectedAccount().balance - newTrasaction.amount
        }
        editAccount(getSelectedAccount(), newName: getSelectedAccount().name, newNumber: getSelectedAccount().number, newBalance: getSelectedAccount().balance)
        
        // Persistence
        let id = Persistence.instance.addTransaction(newTrasaction, toAccount: getSelectedAccount())
        newTrasaction.databaseId = id
    }
    
    
    
    // -------------------------
    // Methods
    // -------------------------
    
    func getSelectedClient() -> Client {
        return clients[selectedClientId]
    }
    
    func getSelectedAccount() -> Account {
        return clients[selectedClientId].accounts[selectedAccountId]
    }
    
    func getSelectedTrasaction() -> Transaction {
        return clients[selectedClientId].accounts[selectedAccountId].transactions[selectedTransactionId]
    }
    
    func setSelectedClientId(newId: Int){
        selectedClientId = newId
    }
    
    func setSelectedAccountId(newId: Int){
        selectedAccountId = newId
    }
    
    func setSelectedTransactionId(newId: Int){
        selectedTransactionId = newId
    }
    
}