//
//  CreateStyle.swift
//
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import Foundation
import Fluent
import FluentPostgresDriver

struct CreateStyle: AsyncMigration {
    
    func prepare(on database: any FluentKit.Database) async throws {
        try await database.schema("styles") // table name
            .id()
            .field("title", .string, .required) // column name
            .create()
    }
    
    func revert(on database: any FluentKit.Database) async throws {
        try await database.schema("styles").delete()
    }
    

    
    
}
