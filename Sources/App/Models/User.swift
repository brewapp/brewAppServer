//
//  User.swift
//
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import Fluent
import FluentPostgresDriver
import Vapor

final class User: Model, Content {
    
    static let schema: String = "users"
    
    struct FieldKeys {
        static var login: FieldKey { "user" }
        static var password: FieldKey { "password" }
    }
    
    // MARK: - fields
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: FieldKeys.login)
    var login: String
    
    @Field(key: FieldKeys.password)
    var password: String
    
    init() { }
    
    init(id: UUID? = nil,
         login: String,
         password: String)
    {
        self.id = id
        self.login = login
        self.password = password
    }

}
