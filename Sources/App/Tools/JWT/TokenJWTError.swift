//
//  File.swift
//  
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import JWT

extension JWTError {
    static let payloadCreation = JWTError.generic(identifier: "TokenHelpers.createPayload", reason: "User ID not found")
    static let createJWT = JWTError.generic(identifier: "TokenHelpers.createJWT", reason: "Error getting token string")
    static let verificationFailed = JWTError.generic(identifier: "TokenHelpers.verifyToken", reason: "JWT verification failed")
}
