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
    let clientsColumnId = Expression<Int64>("Id")
    let clientsColumnName = Expression<String>("Name")
    let clientsColumnAddress = Expression<String>("Address")
    let clientsColumnPhone = Expression<Int64>("Phone")
    
    
    
    // -------------------------
    // Singleton
    // -------------------------
    
    static let instance = Persistence()
    private init() {
        loadDatabase()
    }
    
    
    
    // -------------------------
    // Methods
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
    
    func deleteEdit(clientToEdit: Client){}
    
    func deleteClient(clientToDelete: Client){}
    
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
                clients.append(newClient)
            }
            
            print("Persistence: Query getAllClients Success")
            
        }catch{
            print("Persistence: Query getAllClients Failed")
        }
        
        return clients
    }
    
    
}