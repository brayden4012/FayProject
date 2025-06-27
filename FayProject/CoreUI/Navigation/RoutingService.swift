//
//  RoutingService.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import Foundation
import SwiftUI

class RoutingService: ObservableObject {
    @Published var selectedTab: RootTab = .appointments
    @Published var route: Route?
    
    init() { }
    
    func route(to route: Route) {
        self.route = route
    }
    
    func selectTab(_ tab: RootTab) {
        selectedTab = tab
    }
}
