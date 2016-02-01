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
    
    
    // -------------------------
    // Singleton
    // -------------------------
    
    static let instance = Bank()
    private init() {
        clients = []
        selectedClientId = 0
        selectedAccountId = 0
        selectedTransactionId = 0
    }
    
    
    // -------------------------
    // Business Rules
    // -------------------------
    
    func createClient(newClient: Client){
        clients.insert(newClient, atIndex: 0)
    }
    func deleteClient(clientId: Int){
        clients.removeAtIndex(clientId)
    }
    func editClient(clientId: Int){
    }
    
    
    func createAccount(newAccount: Account){
        getSelectedClient().accounts.insert(newAccount, atIndex: 0)
    }
    func deleteAccount(accountId: Int){
        getSelectedClient().accounts.removeAtIndex(accountId)
    }
    func editAccount(accountId: Int64){
    }
    
    
    func addTransactionToAccount(newTrasaction: Transaction){
        getSelectedAccount().transactions.insert(newTrasaction, atIndex: 0)
        
        if newTrasaction.type == TransactionType.Debit {
            getSelectedAccount().balance = getSelectedAccount().balance + newTrasaction.amount
        }else{
            getSelectedAccount().balance = getSelectedAccount().balance - newTrasaction.amount
        }
    }
    
    
    func generateReport(startdate: NSDate, endDate: NSDate, clientId: Int64){}
    
    
    
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