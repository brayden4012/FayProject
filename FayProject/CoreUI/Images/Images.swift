//
//  Images.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

enum Images: String, CaseIterable {
    enum RootTabs: String, CaseIterable {
        case appointments, appointmentsSelected, chat, chatSelected, journal, journalSelected, profile, profileSelected
    }
    case addAppointment, videoCamera, fayLogo
}

extension Images: ImageAsset {}
extension Images.RootTabs: ImageAsset {}

