//
//  Transaction.swift
//  MyBankManagementApp
//
//  Created by Rigoberto Sáenz Imbacuán on 1/31/16.
//  Copyright © 2016 Rigoberto Saenz Imbacuan. All rights reserved.
//

import Foundation

class Transaction {
    
    var databaseId: Int64
    var type: TransactionType
    var date: NSDate
    var amount: Int64
    
    init(newType: TransactionType, newDate: NSDate, newAmount: Int64){
        databaseId = 0
        type = newType
        date = newDate
        amount = newAmount
    }
    
}