//
//  AccessDto.swift
//
//
//  Created by Aike Fernández Roza on 21/5/24.
//

import Vapor

struct AccessDto: Content {
    let refreshToken: String
    let accessToken: String
    let expiredAt: Date
}
