//
//  ContentView.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import SwiftUI

final class CoreServices: ObservableObject {
    @Published var networkingService: CoreNetworkingService = CoreNetworkingService(
        jwtTokenProvider: DefaultJWTTokenProvider()
    )
    @Published var routingService: RoutingService = RoutingService()
}

struct ContentView: View {
    @StateObject var services = CoreServices()
    @State var navPath = NavigationPath()

    var body: some View {
        NavigationStack(path: $navPath) {
            LoginView(
                viewModel: LoginViewModel(services: services)
            )
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .rootTabBar:
                    RootTabBarView(services: services)
                }
            }
            .onReceive(services.routingService.$route) { newRoute in
                guard let newRoute else {
                    navPath.removeLast(navPath.count)
                    return
                }
                navPath.append(newRoute)
            }
        }
        .environmentObject(services)
    }
}

#Preview {
    ContentView()
}
