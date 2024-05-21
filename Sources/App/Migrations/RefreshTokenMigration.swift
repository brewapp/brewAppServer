//
//  RefreshTokenMigration.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Fluent
import Vapor

extension RefreshToken {
    struct Migration: AsyncMigration {
        var name: String { "RefreshToken" }

        func prepare(on database: Database) async throws {
            try await database.schema("refreshTokens")
                .id()
                .field("token", .string, .required)
                .field("expiredAt", .date, .required)
                .field("userID", .uuid, .required)
                .unique(on: "token")
                .create()
        }

        func revert(on database: Database) async throws {
            try await database.schema("refreshTokens").delete()
        }
    }
}
