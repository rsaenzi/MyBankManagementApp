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
        clients = Persistence.instance.getAllClients()
        
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
        
        // Add
        clients.insert(newClient, atIndex: 0)
        
        // Persist
        let id = Persistence.instance.addClient(newClient)
        newClient.databaseId = id
    }
    func deleteClient(clientId: Int){
        clients.removeAtIndex(clientId)
    }
    
    
    func createAccount(newAccount: Account){
        getSelectedClient().accounts.insert(newAccount, atIndex: 0)
    }
    func deleteAccount(accountId: Int){
        getSelectedClient().accounts.removeAtIndex(accountId)
    }
    
    
    func addTransactionToAccount(newTrasaction: Transaction){
        getSelectedAccount().transactions.insert(newTrasaction, atIndex: 0)
        
        if newTrasaction.type == TransactionType.Debit {
            getSelectedAccount().balance = getSelectedAccount().balance + newTrasaction.amount
        }else{
            getSelectedAccount().balance = getSelectedAccount().balance - newTrasaction.amount
        }
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