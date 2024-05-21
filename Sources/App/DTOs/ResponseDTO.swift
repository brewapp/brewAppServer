//
//  ResponseDto.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Vapor

struct ResponseDto: Content, Sendable {
    let message: String
}
