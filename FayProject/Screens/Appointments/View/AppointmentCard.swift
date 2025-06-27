//
//  AppointmentCard.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

struct AppointmentCard: View {
    enum Style {
        case `default`, featured
        
        func backgroundColor(colorScheme: ColorScheme) -> Color {
            switch self {
            case .default:
                    return .primaryBackground
            case .featured:
                switch colorScheme {
                case .light:
                    return .primaryBackground
                case .dark:
                    return .secondaryBackground
                @unknown default:
                    return .secondaryBackground
                }
            }
        }
        var borderColor: Color {
            switch self {
            case .default:
                return .stroke
            case .featured:
                return .clear
            }
        }
        
        func shadowColor(colorScheme: ColorScheme) -> Color {
            switch self {
            case .default:
                return .clear
            case .featured:
                return switch colorScheme {
                case .light: .primary.opacity(0.1)
                case .dark: .clear
                @unknown default: .clear
                }
            }
        }
    }
    
    @Environment(\.colorScheme) var colorScheme
    let appointment: Appointment
    let style: Style
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 16) {
                DateView(
                    date: appointment.start,
                    theme: appointment.status == .upcoming ? .upcoming : .past
                )
                
                details
            }
            
            if style == .featured {
                joinAppointmentButton
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .cornerRadius(16)
        .background {
            RoundedRectangle(cornerRadius: 16)
                .fill(style.backgroundColor(colorScheme: colorScheme))
                .shadow(
                    color: style.shadowColor(colorScheme: colorScheme),
                    radius: 6,
                    x: 0,
                    y: 4
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 16)
                .stroke(style.borderColor, lineWidth: 1)
        }
    }

    private var details: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(appointmentTimesDisplay)
                .font(.callout)
                .bold()
                .foregroundStyle(Color.primaryText)
            
            Text(appointmentTypeDisplay)
                .font(.caption)
                .foregroundStyle(Color.secondaryText)
        }
    }
    
    private var appointmentTimesDisplay: String {
        let start = dateFormatter.string(from: appointment.start)
        let end = dateFormatter.string(from: appointment.end)
        let timezone = Calendar.current.timeZone.abbreviation()
        var display = "\(start) - \(end)"
        if let timezone {
            display += " (\(timezone))"
        }
        return display
    }
    
    private var appointmentTypeDisplay: String {
        var display = appointment.appointmentType
        if style == .featured {
            display += " with Jane Williams, RD"
        }
        return display
    }
    
    private var joinAppointmentButton: some View {
        Button {
            // TODO: Add action
        } label: {
            HStack(spacing: 8) {
                Images.videoCamera.image
                Text("Join Appointment")
                    .font(.headline)
                    .foregroundStyle(Color.white)
            }
            .frame(height: 44)
            .frame(maxWidth: .infinity)
            .background(Color.primaryTheme)
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    Group {
        AppointmentCard(
            appointment: Appointment(
                id: "12345",
                patientId: "",
                providerId: "",
                status: .upcoming,
                appointmentType: "Follow up",
                start: Date(),
                end: Date().addingTimeInterval(60 * 30),
                durationInMinutes: 30,
                recurrenceType: ""
            ),
            style: .featured
        )
        
        AppointmentCard(
            appointment: Appointment(
                id: "12345",
                patientId: "",
                providerId: "",
                status: .upcoming,
                appointmentType: "Follow up",
                start: Date(),
                end: Date().addingTimeInterval(60 * 30),
                durationInMinutes: 30,
                recurrenceType: ""
            ),
            style: .default
        )
    }.padding(15)
}
