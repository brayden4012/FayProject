//
//  Appointment.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import CoreNetworking
import Foundation

struct Appointment: DomainModel, Identifiable {
    var id: String
    var patientId: String
    var providerId: String
    var status: AppointmentStatus
    var appointmentType: String
    var start: Date
    var end: Date
    var durationInMinutes: Int
    var recurrenceType: String
}
