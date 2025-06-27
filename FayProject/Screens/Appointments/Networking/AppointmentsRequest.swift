//
//  AppointmentsRequest.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import CoreNetworking
import Foundation

struct AppointmentsRequest: NetworkRequest {
    typealias ExpectedResponseType = AppointmentsNetworkModel
    
    var path: String = "/appointments"
    
    
}
