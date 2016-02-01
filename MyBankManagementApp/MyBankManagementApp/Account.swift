//
//  Account.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation

class Account {
    
    var databaseId: Int64
    var name: String
    var number: String
    var balance: Int64
    var transactions: [Transaction]
    
    init(newName: String, newNumber: String) {
        databaseId = 0
        name = newName
        number = newNumber
        balance = 0
        transactions = []
    }
    
}