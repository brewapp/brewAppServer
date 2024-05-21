//
//  AccessTokenPayload.swift
//
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import Foundation
import JWT

struct AccessTokenPayload: JWTPayload, Equatable {
    
    var issuer: IssuerClaim
    var issuedAt: IssuedAtClaim
    var expirationAt: ExpirationClaim
    var userID: User.IDValue
    
    init(issuer: String = "BrewApp",
         issuedAt: Date = Date(),
         expirationAt: Date = Date().addingTimeInterval(100),
         userID: User.IDValue) {
        self.issuer = IssuerClaim(value: issuer)
        self.issuedAt = IssuedAtClaim(value: issuedAt)
        self.expirationAt = ExpirationClaim(value: expirationAt)
        self.userID = userID
        
        
    }
    
    func verify(using signer: JWTSigner) throws {
        try self.expirationAt.verifyNotExpired()
    }
}
