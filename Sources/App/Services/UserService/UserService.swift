//
//  UserService.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Vapor

protocol UserService {
    func signUp(request: Request, user: User) async throws -> ResponseDto
    func signIn(request: Request, user: User) async throws -> AccessDto
    func refreshToken(request: Request, refreshTokenDto: RefreshTokenDto) async throws -> AccessDto
    func getUsers(request: Request) async throws -> [User]
}
