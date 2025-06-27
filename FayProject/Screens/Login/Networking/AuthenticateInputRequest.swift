//
//  AuthenticateInputRequest.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import CoreNetworking
import Foundation

struct AuthenticateInputRequest: NetworkInputRequest {
    typealias InputNetworkModel = CredentialsNetworkModel
    typealias InputDomainModel = Credentials
    typealias ExpectedResponseType = LoginNetworkResponse
    var input: Credentials
    var path: String = "/signin"
}
