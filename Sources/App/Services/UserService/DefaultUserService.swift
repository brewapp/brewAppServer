//
//  DefaultUserService.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Vapor
import Crypto
import Fluent
import FluentPostgresDriver

struct DefaultUserService: UserService {
    
    func signUp(request: Request, user: User) async throws -> ResponseDto {
        
        let actualUser = try await User
            .query(on: request.db)
            .filter(\.$login == user.login)
            .first()
        
        if (actualUser != nil) {
            throw Abort(.badRequest, reason: "A user with login \(user.login) already exists")
        }

        user.password = try Bcrypt.hash(user.password)
        try await user.save(on: request.db)
        return ResponseDto(message: "Account created successfully")
    }
    
    func signIn(request: Request, user: User) async throws -> AccessDto {
        
        let actualUser = try await User
            .query(on: request.db)
            .filter(\.$login == user.login)
            .first()
        
        guard let persistedUser = actualUser else {
            throw Abort(.badRequest, reason: "User with login \(user.login) not found")
        }
        
        let corretPassword = try Bcrypt.verify(user.password, created: persistedUser.password)

        if corretPassword {
            let accessToken = try TokenHelpers.createAccessToken(from: persistedUser, req: request)
            let refreshToken = TokenHelpers.createRefreshToken()
            let expiredDate = try TokenHelpers.expiredDate(of: accessToken, req: request)
            
            print ("==== before)")
            
            let aux = RefreshTokenModel(token: refreshToken, userID: try persistedUser.requireID())
            
            print ("==== \(aux)")
            try await aux.save(on: request.db)
            
            return AccessDto(refreshToken: refreshToken, accessToken: accessToken, expiredAt: expiredDate)
        } else {
            throw Abort(.badRequest, reason: "Incorrect user password")
        }
        
    }
    
    func refreshToken(request: Request, refreshTokenDto: RefreshTokenDto) async throws -> AccessDto {
        return AccessDto(refreshToken: "", accessToken: "", expiredAt: Date())
    }
    
    func getUsers(request: Request) async throws -> [User] {
        try await User.query(on: request.db).all().map { $0 }
    }
}
