//
//  Route.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import Foundation

enum Route: Hashable {
    enum TabBar: Hashable {
        case appointments, chat, journal, profile
    }
    case rootTabBar
}
