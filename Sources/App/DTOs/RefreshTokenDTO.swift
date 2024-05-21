//
//  RefreshTokenDto.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Vapor

struct RefreshTokenDto: Content, Sendable {
    let refreshToken: String
}
