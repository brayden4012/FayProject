//
//  JWTTokenProvider.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import Combine
import Foundation

protocol JWTTokenProvider {
    var token: CurrentValueSubject<String?, Never> { get }
}
