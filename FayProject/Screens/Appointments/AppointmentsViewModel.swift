//
//  AppointmentsViewModel.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import Combine
import CoreNetworking
import Foundation

final class AppointmentsViewModel: ObservableObject {
    @Published var appointments = [AppointmentStatus: [Appointment]]()
    @Published var selectedStatus: AppointmentStatus = .upcoming
    @Published var isLoading = true
    private let services: CoreServices
    private var cancellables = Set<AnyCancellable>()
    private var isInitialAppear = true
    
    init(services: CoreServices) {
        self.services = services
    }
    
    func onDisappear() {
        cancellables.removeAll()
    }
    
    func onAppear() {
        if isInitialAppear {
            getAppointments()
            isInitialAppear.toggle()
        }
    }
    
    func refresh() {
        getAppointments()
    }
    
    private func getAppointments() {
        isLoading = true
        do {
            try services.networkingService.get(
                AppointmentsRequest()
            )
            .mapTo(type: [Appointment].self)
            .receive(on: RunLoop.main)
            .sink { [weak self] result in
                switch result {
                case .finished: break
                case .failure(let error):
                    print(error)
                }
                self?.isLoading = false
            } receiveValue: { [weak self] appointments in
                self?.appointments = Dictionary(grouping: appointments, by: { $0.status })
            }
            .store(in: &cancellables)
        } catch {
            isLoading = false
            print("TODO: Error handling: \(error)")
        }
    }
    
    func selectStatus(_ status: AppointmentStatus) {
        selectedStatus = status
    }
}
