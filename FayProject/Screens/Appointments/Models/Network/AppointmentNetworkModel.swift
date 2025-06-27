//
//  AppointmentNetworkModel.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import CoreNetworking
import Foundation

struct AppointmentNetworkModel: NetworkModel {
    var appointmentId: String
    var patientId: String
    var providerId: String
    var status: String
    var appointmentType: String
    var start: Date
    var end: Date
    var durationInMinutes: Int
    var recurrenceType: String
}
