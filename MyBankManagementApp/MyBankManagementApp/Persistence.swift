//
//  Persistence.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation
import SQLite

class Persistence {
    
    // -------------------------
    // Members
    // -------------------------
    
    private let databaseName = "BankDatabase.db"
    private var database: Connection?
    private var tableClients: Table?
    private var tableAccounts: Table?
    private var tableTransaction: Table?
    
    // Table Clients
    private let clientsColumnId = Expression<Int64>("Id")
    private let clientsColumnName = Expression<String>("Name")
    private let clientsColumnAddress = Expression<String>("Address")
    private let clientsColumnPhone = Expression<Int64>("Phone")
    
    // Table Accounts
    private let accountsColumnId = Expression<Int64>("Id")
    private let accountsColumnClientId = Expression<Int64>("ClientId")
    private let accountsColumnName = Expression<String>("Name")
    private let accountsColumnNumber = Expression<Int64>("Number")
    private let accountsColumnBalance = Expression<Int64>("Balance")
    
    // Table Transactions
    private let transactionsColumnId = Expression<Int64>("Id")
    private let transactionsColumnAccountId = Expression<Int64>("AccountId")
    private let transactionsColumnType = Expression<String>("Type")
    private let transactionsColumnDate = Expression<String>("Date")
    private let transactionsColumnAmount = Expression<Int64>("Amount")
    
    
    // -------------------------
    // Singleton
    // -------------------------
    
    static let instance = Persistence()
    private init() {
        loadDatabase()
    }
    
    
    
    // -------------------------
    // Database Loading
    // -------------------------
    
    private func loadDatabase() {
        
        do{
            
            // 0. Create path to database in documents folder
            let initPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first!
            let dbPathInDocuments = "\(initPath)/\(databaseName)"
            //print("Persistence: pathInDocuments = \(dbPathInDocuments)")
            
            // 1. Get path to database in bundle
            if let dbPathInBundle = NSBundle.mainBundle().pathForResource(databaseName, ofType: nil) {
                //print("Persistence: pathInBundle = \(dbPathInBundle)")
                
                // Delete Database
                //try NSFileManager.defaultManager().removeItemAtPath(dbPathInDocuments)
                //print("Persistence: Database deleting success")
                //return
                
                // 2. Check if a database exist in documents folder
                if NSFileManager.defaultManager().fileExistsAtPath(dbPathInDocuments) == false {
                    print("Persistence: Database dont exist in R/W Documents folder")
                    
                    // 3. Copy database in bundle to documents folder
                    do {
                        try NSFileManager.defaultManager().copyItemAtURL(NSURL(fileURLWithPath: dbPathInBundle), toURL: NSURL(fileURLWithPath: dbPathInDocuments))
                        print("Persistence: Database copying success")
                        
                    }catch{
                        print("Persistence: Database copying failed")
                        return
                    }
                }
                
                // 4. Load database from documents
                print("Persistence: Database exist in R/W Documents folder")
                do{
                    database = try Connection(dbPathInDocuments)
                    print("Persistence: Database loaded from Documents folders")
                    
                }catch{
                    print("Persistence: Cant load database from Documents folders")
                    return
                }
                
                // 5. Load tables
                tableClients = Table("Clients")
                tableAccounts = Table("Accounts")
                tableTransaction = Table("Transactions")
                print("Persistence: Database tables loaded")
                
            }else {
                print("Persistence: Database dont exist in bundle")
            }
            
        }catch{
            print("Persistence: Process failed...")
        }
    }
    
    
    
    // -------------------------
    // Client
    // -------------------------
    
    func addClient(clientToAdd: Client) -> Int64 {
        
        do {
            
            // INSERT INTO "Clients" ("Name", "Address", "Phone") VALUES ('Rigoberto', 'Street 61', '123456789')
            if let rowId = try database?.run(tableClients!.insert(clientsColumnName <- clientToAdd.name, clientsColumnAddress <- clientToAdd.address, clientsColumnPhone <- Int64(clientToAdd.phone)!)) {
                print("Persistence: Query addClient Success: \(rowId)")
                return rowId
                
            }else {
                print("Persistence: Query addClient Failed")
            }
            
        } catch {
            print("Persistence: Query addClient Failed")
        }
        return -1
    }
    
    func editClient(editedClient: Client){
        
        do {
            
            // UPDATE "Clients" SET "name" = 'Rigoberto' WHERE ("id" = 1)
            let cellToEdit = tableClients!.filter(clientsColumnId == editedClient.databaseId)
            
            if try database?.run(cellToEdit.update(clientsColumnName <- editedClient.name, clientsColumnAddress <- editedClient.address, clientsColumnPhone <- Int64(editedClient.phone)!)) > 0 {
                print("Persistence: Query editClient Success")
            } else {
                print("Persistence: Query editClient NotFound")
            }
            
        } catch {
            print("Persistence: Query editClient Failed")
        }
    }
    
    func deleteClient(clientToDelete: Client){
        
        do {
            
            // DELETE FROM "Clients" WHERE ("id" = 1)
            let cellToDelete = tableClients!.filter(clientsColumnId == clientToDelete.databaseId)
            
            if try database?.run(cellToDelete.delete()) > 0 {
                print("Persistence: Query deleteClient Success")
            } else {
                print("Persistence: Query deleteClient NotFound")
            }
            
        } catch {
            print("Persistence: Query deleteClient Failed")
        }
    }
    
    func getAllClients() -> [Client] {
        
        var clients: [Client] = []
        
        do{
            
            // Clients parsing
            for currentPersistedClient in try database!.prepare(tableClients!) {
                
                // SELECT * FROM "Clients"
                let newClient = Client(newName: String(currentPersistedClient[clientsColumnName]), newAddress: String(currentPersistedClient[clientsColumnAddress]), newPhone: String(currentPersistedClient[clientsColumnPhone]))
                newClient.databaseId = Int64(currentPersistedClient[clientsColumnId])
                print("Persistence: Loaded Client Id: \(newClient.databaseId)")
                
                // Add client to list
                clients.insert(newClient, atIndex: 0)
            }
            
            print("Persistence: Query getAllClients Success")
            
        }catch{
            print("Persistence: Query getAllClients Failed")
        }
        
        return clients
    }
    
    
    
    // -------------------------
    // Accounts
    // -------------------------
    
    func addAccount(accountToAdd: Account, toClient: Client) -> Int64 {
        
        do {
            
            // INSERT INTO "Accounts" ("ClientId", "Name", "Number", "Balance") VALUES (345678, 'Rigoberto', 9876543, 123456789)
            if let rowId = try database?.run(tableAccounts!.insert(accountsColumnClientId <- toClient.databaseId, accountsColumnName <- accountToAdd.name, accountsColumnNumber <- Int64(accountToAdd.number)!, accountsColumnBalance <- accountToAdd.balance)) {
                print("Persistence: Query addAccount Success: \(rowId)")
                return rowId
                
            }else {
                print("Persistence: Query addAccount Failed")
            }
            
        } catch {
            print("Persistence: Query addAccount Failed")
        }
        return -1
    }
    
    func editAccount(editedAccount: Account){
        
        do {
            
            // UPDATE "Accounts" SET "name" = 'Rigoberto' WHERE ("id" = 1)
            let cellToEdit = tableAccounts!.filter(accountsColumnId == editedAccount.databaseId)
            
            if try database?.run(cellToEdit.update(accountsColumnName <- editedAccount.name, accountsColumnNumber <- Int64(editedAccount.number)!, accountsColumnBalance <- Int64(editedAccount.balance))) > 0 {
                print("Persistence: Query editAccount Success")
            } else {
                print("Persistence: Query editAccount NotFound")
            }
            
        } catch {
            print("Persistence: Query editAccount Failed")
        }
    }
    
    func deleteAccount(accountToDelete: Account){
        
        do {
            
            // DELETE FROM "Accounts" WHERE ("id" = 1)
            let cellToDelete = tableAccounts!.filter(accountsColumnId == accountToDelete.databaseId)
            
            if try database?.run(cellToDelete.delete()) > 0 {
                print("Persistence: Query deleteAccount Success")
            } else {
                print("Persistence: Query deleteAccount NotFound")
            }
            
        } catch {
            print("Persistence: Query deleteAccount Failed")
        }
    }
    
    func getAllAccountsForClient(client: Client) -> [Account] {
        
        var accounts: [Account] = []
        
        do{
            
            // Accounts parsing
            for currentPersistedAccount in try database!.prepare(tableAccounts!.filter(accountsColumnClientId == client.databaseId)) {
                
                // SELECT * FROM "Accounts" WHERE clientId = 1
                let newAccount = Account(newName: currentPersistedAccount[accountsColumnName], newNumber: String(currentPersistedAccount[accountsColumnNumber]))
                newAccount.balance = currentPersistedAccount[accountsColumnBalance]
                newAccount.databaseId = Int64(currentPersistedAccount[accountsColumnId])
                print("Persistence: Loaded Account Id: \(newAccount.databaseId)")
                
                // Add client to list
                accounts.insert(newAccount, atIndex: 0)
            }
            
            print("Persistence: Query getAllAccounts Success")
            
        }catch{
            print("Persistence: Query getAllAccounts Failed")
        }
        
        return accounts
    }
    
    
    
    // -------------------------
    // Trasactions
    // -------------------------
    
    func addTransaction(transactionToAdd: Transaction, toAccount: Account) -> Int64 {
        
        do {
            
            // INSERT INTO "Transactions" ("AccountId", "Type", "Date", "Amount") VALUES (345678, 'Credit', '00/00/0000', 123456789)
            if let rowId = try database?.run(tableTransaction!.insert(transactionsColumnAccountId <- toAccount.databaseId, transactionsColumnType <- transactionToAdd.type.rawValue, transactionsColumnDate <- String(transactionToAdd.date.timeIntervalSince1970), transactionsColumnAmount <- transactionToAdd.amount)) {
                print("Persistence: Query addTransaction Success: \(rowId)")
                return rowId
                
            }else {
                print("Persistence: Query addTransaction Failed")
            }
            
        } catch {
            print("Persistence: Query addTransaction Failed")
        }
        return -1
    }
    
    func getAllTransactionsForAccount(account: Account) -> [Transaction] {
        
        var transactions: [Transaction] = []
        
        do{
            
            // Transactions parsing
            for currentPersistedTransaction in try database!.prepare(tableTransaction!.filter(transactionsColumnAccountId == account.databaseId)) {
                
                // SELECT * FROM "Transactions" WHERE accountId = 1
                let newTransaction = Transaction(newType: TransactionType(rawValue: currentPersistedTransaction[transactionsColumnType])!, newDate: NSDate(timeIntervalSince1970: Double(currentPersistedTransaction[transactionsColumnDate])!) , newAmount: currentPersistedTransaction[transactionsColumnAmount])
                newTransaction.databaseId = Int64(currentPersistedTransaction[accountsColumnId])
                print("Persistence: Loaded Transaction Id: \(newTransaction.databaseId)")
                
                // Add client to list
                transactions.insert(newTransaction, atIndex: 0)
            }
            
            print("Persistence: Query getAllTransactionsForAccount Success")
            
        }catch{
            print("Persistence: Query getAllTransactionsForAccount Failed")
        }
        
        return transactions
    }
    
    
}