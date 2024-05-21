//
//  UsersController.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//


import Vapor

final class UsersController {
    
    fileprivate var userService: UserService
    
    init(userService: UserService) {
        self.userService = userService
    }

    @Sendable
    func signUp(_ request: Request) async throws -> ResponseDto {
        let user = try request.content.decode(User.self)
        return try await self.userService.signUp(request: request, user: user)
        
    }
    
    @Sendable
    func signIn(_ request: Request) async throws -> AccessDto {
        let user = try request.content.decode(User.self)
        return try await self.userService.signIn(request: request, user: user)
    }
    
    @Sendable
    func refreshToken(_ request: Request) async throws -> AccessDto {
        let refreshTokenDto = try request.content.decode(RefreshTokenDto.self)
        return try await self.userService.refreshToken(request: request, refreshTokenDto: refreshTokenDto)
    }
    
    @Sendable
    func getUsers(_ request: Request) async throws -> [User] {
        return try await self.userService.getUsers(request: request)
    }
}

extension UsersController: RouteCollection, @unchecked Sendable {
    func boot(routes: any Vapor.RoutesBuilder) throws {
        let account = routes.grouped("v1","account")

        account.post("sign-up", use: self.signUp)
        account.post("sign-in", use: self.signIn)
        account.post("refresh-token", use: self.refreshToken)
        account.get("users", use: self.getUsers)
    }
}
