//
//  LoginResponse+Mapping.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import CoreNetworking
import Foundation

extension LoginResponse {
    class LoginNetworkResponseMapping: DomainModelMapping {
        func createDomainModel(from networkModel: LoginNetworkResponse) -> LoginResponse {
            LoginResponse(token: networkModel.token)
        }
        func createNetworkModel(from domainModel: LoginResponse) -> LoginNetworkResponse {
            LoginNetworkResponse(token: domainModel.token)
        }
    }
}

extension LoginResponse: Mappable {
    static var mappings: [AnyMapping] {
        [
            LoginNetworkResponseMapping().toAnyMapping()
        ]
    }
}
