//
//  Credentials+Mapping.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import CoreNetworking
import Foundation

extension Credentials {
    class CredentialsNetworkModelMapping: DomainModelMapping {
        init() { }
        func createDomainModel(from networkModel: CredentialsNetworkModel) -> Credentials {
            Credentials(
                username: networkModel.username,
                password: networkModel.password
            )
        }
        
        func createNetworkModel(from domainModel: Credentials) -> CredentialsNetworkModel {
            CredentialsNetworkModel(
                username: domainModel.username,
                password: domainModel.password
            )
        }
    }
}

extension Credentials: Mappable {
    static var mappings: [AnyMapping] {
        [
            CredentialsNetworkModelMapping().toAnyMapping()
        ]
    }
}
