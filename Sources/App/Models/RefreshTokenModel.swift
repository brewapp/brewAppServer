//
//  RefreshToken.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class RefreshTokenModel: Model, Content {
    
    fileprivate enum Constants {
        static let refreshTokenTime: TimeInterval = 60 * 24 * 60 * 60
    }
    
    static let schema: String = "refreshTokens"
    
    struct FieldKeys {
        static var token: FieldKey { "token" }
        static var expiredAt: FieldKey { "expiredAt" }
        static var userID: FieldKey { "userID" }
    }
    
    // MARK: - fields
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.token)
    var token: String
    
    @Field(key: FieldKeys.expiredAt)
    var expiredAt: Date
    
    @Field(key: FieldKeys.userID)
    var userID: UUID
    
    init() { }
    
    init(id: UUID? = nil,
         token: String,
         expiredAt: Date = Date().addingTimeInterval(Constants.refreshTokenTime),
         userID: UUID) {
        self.id = id
        self.token = token
        self.expiredAt = expiredAt
        self.userID = userID
    }
    
    func updateExpiredDate() {
        self.expiredAt = Date().addingTimeInterval(Constants.refreshTokenTime)
    }
}
