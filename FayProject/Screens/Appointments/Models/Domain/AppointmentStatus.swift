//
//  AppointmentStatus.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import CoreNetworking
import Foundation

enum AppointmentStatus: String, DomainModel {
    case upcoming = "Scheduled"
    case past = "Occurred"
    case unknown
    
    var title: String {
        return switch self {
        case .upcoming: "Upcoming"
        case .past: "Past"
        case .unknown: ""
        }
    }
    
    static var displayStatuses: [AppointmentStatus] {
        return [.upcoming, .past]
    }
}
