//
//  LoginViewModel.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import Combine
import CoreNetworking
import Foundation

final class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var isLoggingIn = false
    @Published var errorMessage: String?
    private let services: CoreServices
    private var cancellables = Set<AnyCancellable>()
    private lazy var networkingService = services.networkingService
    
    init(
        services: CoreServices
    ) {
        self.services = services
        
        $username
            .combineLatest($password)
            .sink { [weak self] _, _ in
                self?.clearErrors()
            }
            .store(in: &cancellables)
    }
    
    var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty
    }
    
    func authenticate() {
        isLoggingIn = true
        do {
            try networkingService
                .post(
                    AuthenticateInputRequest(
                        input: Credentials(username: username, password: password)
                    )
                )
                .mapTo(type: LoginResponse.self)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { [weak self] response in
                    self?.isLoggingIn = false
                    switch response {
                    case .finished: break
                    case .failure(let failure):
                        switch failure {
                        case .urlError:
                            self?.errorMessage = "Invalid credentials. Please try again."
                        default:
                            self?.errorMessage = "\(failure.errorDescription) Please contact customer support"
                        }
                    }
                }, receiveValue: { [weak self] loginResponse in
                    self?.networkingService.provideJWT(token: loginResponse.token)
                    self?.isLoggingIn = false
                    self?.services.routingService.route(to: .rootTabBar)
                })
                .store(in: &cancellables)
        } catch {
            isLoggingIn = false
            print("Uh oh! Something went wrong: \(error.localizedDescription)")
        }
    }
    
    private func clearErrors() {
        if errorMessage != nil {
            errorMessage = nil
        }
    }
}
