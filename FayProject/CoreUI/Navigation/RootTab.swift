//
//  RootTab.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import Foundation

enum RootTab: Hashable, CaseIterable, Identifiable {
    case appointments, chat, journal, profile
    
    var id: Int {
        hashValue
    }
}
