//
//  Database.swift
//  SmartReceipts
//
//  Created by Jaanus Siim on 31/05/16.
//  Copyright © 2016 Will Baumann. All rights reserved.
//

import Foundation

extension Database {
    func inDatabase(closure: (FMDatabase) -> ()) {
        databaseQueue.inDatabase() {
            database in
         
            closure(database)
        }
    }
}