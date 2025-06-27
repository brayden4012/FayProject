//
//  DefaultJWTTokenProvider.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import Combine
import Foundation

final class DefaultJWTTokenProvider: JWTTokenProvider {
    var token: CurrentValueSubject<String?, Never> = .init(nil)
}
