//
//  JWTConfig.swift
//
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import JWTKit
import JWT

enum JWTConfig {
    static let signerKey = "JWT_API_SIGNER_KEY" // Key for signing JWT Access Token
    let aux = JWTSign
    static let header = JWTHeader() // Algorithm and Type
    static let signer = JWTSigner.hs256(key: JWTConfig.signerKey) // Signer for JWT
    static let expirationTime: TimeInterval = 100 // In seconds
}
