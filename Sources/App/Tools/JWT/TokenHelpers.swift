//
//  TokenHelpers.swift
//
//
//  Created by Aike Fernández Roza on 20/5/24.
//

import JWT
import Vapor

class TokenHelpers {
    
    
    /// Create payload for Access Token
    fileprivate class func createPayload(from user: User) throws -> AccessTokenPayload {
        if let identifier = user.id {
            let payload = AccessTokenPayload(userID: identifier)
            return payload
        } else {
            throw JWTError.payloadCreation
        }
    }
    
    /// Create Access Token for user
    class func createAccessToken(from user: User, req: Request) throws -> String {
        do {
            let payload = try TokenHelpers.createPayload(from: user)
            let signed = try req.jwt.sign(payload, kid: .private)
            return signed
        } catch {
            throw JWTError.createJWT
        }
    }
    
    /// Get expiration date of token
    class func expiredDate(of token: String, req: Request) throws -> Date {
        
        do {
            let jwt = try req.jwt.verify(token, as: AccessTokenPayload.self)
            return jwt.expirationAt.value
        } catch {
            throw JWTError.malformedToken
        }
    }
    
    /// Verify token is valid or not
    class func verifyToken(_ token: String, req: Request) throws {
        do {
            let _ = try req.jwt.verify(token, as: AccessTokenPayload.self)
        } catch {
            throw JWTError.verificationFailed
        }
    }
    
    /// Get user ID from token
    class func getUserID(fromPayloadOf token: String, req: Request) throws -> UUID {
        do {
            let jwt = try req.jwt.verify(token, as: AccessTokenPayload.self)
            return jwt.userID
        } catch {
            throw JWTError.verificationFailed
        }
    }
    
    /// Generate new Refresh Token
    class func createRefreshToken() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0 ... 40).map { _ in letters.randomElement()! })
    }
}
