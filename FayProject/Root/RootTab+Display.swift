//
//  RootTab+Display.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

extension RootTab {
    var title: String {
        return switch self {
        case .appointments: "Appointments"
        case .chat: "Chat"
        case .journal: "Journal"
        case .profile: "Profile"
        }
    }
    
    @ViewBuilder
    func icon(
        isSelected: Bool
    ) -> some View {
        if isSelected {
            selectedIcon
        } else {
            unselectedIcon.renderingMode(.template).foregroundStyle(Color.green)
        }
    }
    
    private var selectedIcon: Image {
        switch self {
        case .appointments:
            Images.RootTabs.appointmentsSelected.image
        case .chat:
            Images.RootTabs.chatSelected.image
        case .journal:
            Images.RootTabs.journalSelected.image
        case .profile:
            Images.RootTabs.profileSelected.image
        }
    }
    
    private var unselectedIcon: Image {
        switch self {
        case .appointments:
            Images.RootTabs.appointments.image
        case .chat:
            Images.RootTabs.chat.image
        case .journal:
            Images.RootTabs.journal.image
        case .profile:
            Images.RootTabs.profile.image
        }
    }
    
    @ViewBuilder
    func screen(services: CoreServices) -> some View {
        switch self {
        case .appointments:
            AppointmentsView(
                viewModel: AppointmentsViewModel(
                    services: services
                )
            )
        default:
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.primaryBackground.ignoresSafeArea())
        }
    }
}
