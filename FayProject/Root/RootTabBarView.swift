//
//  RootTabBarView.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

struct RootTabBarView: View {
    @ObservedObject var services: CoreServices
    
    init(services: CoreServices) {
        self.services = services
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.primaryBackground)
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.primaryText)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.primaryText)]
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        TabView(selection: $services.routingService.selectedTab) {
            ForEach(RootTab.allCases) { tab in
                VStack(spacing:.zero) {
                    tab.screen(services: services)
                    Rectangle()
                        .fill(Color.stroke)
                        .frame(height: 1)
                }
                .tag(tab)
                .tabItem {
                    tab.icon(isSelected: selectedTab == tab)
                    Text(tab.title)
                }
            }
        }
        .accentColor(.primaryTheme)
    }
    
    private var selectedTab: RootTab {
        services.routingService.selectedTab
    }
}

#Preview {
    RootTabBarView(services: CoreServices())
}
