//
//  Appointment+Mapping.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import CoreNetworking
import Foundation

extension Appointment: Mappable {
    class AppointmentNetworkMapping: DomainModelMapping {
        func createDomainModel(from networkModel: AppointmentNetworkModel) -> Appointment {
            Appointment(
                id: networkModel.appointmentId,
                patientId: networkModel.patientId,
                providerId: networkModel.providerId,
                status: AppointmentStatus(rawValue: networkModel.status) ?? .unknown,
                appointmentType: networkModel.appointmentType,
                start: networkModel.start,
                end: networkModel.end,
                durationInMinutes: networkModel.durationInMinutes,
                recurrenceType: networkModel.recurrenceType
            )
        }
        
        func createNetworkModel(from domainModel: Appointment) -> AppointmentNetworkModel {
            AppointmentNetworkModel(
                appointmentId: domainModel.id,
                patientId: domainModel.patientId,
                providerId: domainModel.providerId,
                status: domainModel.status.rawValue,
                appointmentType: domainModel.appointmentType,
                start: domainModel.start,
                end: domainModel.end,
                durationInMinutes: domainModel.durationInMinutes,
                recurrenceType: domainModel.recurrenceType
            )
        }
    }
    static var mappings: [CoreNetworking.AnyMapping] {
        [
            AppointmentNetworkMapping().toAnyMapping()
        ]
    }
}

extension [Appointment]: MappableDomainModel {
    class AppointmentsNetworkMapping: DomainModelMapping {
        func createDomainModel(from networkModel: AppointmentsNetworkModel) -> [Appointment] {
            networkModel.appointments.compactMap {
                try? Appointment(from: $0)
            }
        }
        
        func createNetworkModel(from domainModel: [Appointment]) -> AppointmentsNetworkModel {
            AppointmentsNetworkModel(
                appointments: domainModel.compactMap {
                    try? $0.networkModel(for: AppointmentNetworkModel.self)
                }
            )
        }
    }
    public static var mappings: [AnyMapping] {
        [
            AppointmentsNetworkMapping().toAnyMapping()
        ]
    }
}
