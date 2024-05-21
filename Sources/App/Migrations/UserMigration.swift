//
//  UserMigration.swift
//
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import Fluent
import Vapor

extension User {
    struct Migration: AsyncMigration {
        var name: String { "CreateUser" }

        func prepare(on database: Database) async throws {
            try await database.schema("users")
                .id()
                .field("login", .string, .required)
                .field("password", .string, .required)
                .unique(on: "user")
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("users").delete()
        }
    }
}
