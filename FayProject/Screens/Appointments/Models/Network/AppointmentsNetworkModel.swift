//
//  AppointmentsNetworkModel.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import CoreNetworking
import Foundation

struct AppointmentsNetworkModel: NetworkModel {
    var appointments: [AppointmentNetworkModel]
}
