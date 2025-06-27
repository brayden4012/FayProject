//
//  AppointmentsView.swift
//  FayProject
//
//  Created by Brayden Harris on 6/26/25.
//

import SwiftUI

struct AppointmentsView: View {
    @StateObject var viewModel: AppointmentsViewModel
    
    init(viewModel: AppointmentsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            header
            Spacer(minLength: 10)
            tabs
            content
        }
        .frame(maxWidth: .infinity)
        .toolbar(.hidden)
        .background(Color.primaryBackground)
    }
    
    private var header: some View {
        HStack {
            Text("Appointments")
                .foregroundStyle(Color.primaryText)
                .font(.title)
                .bold()
            Spacer()
            newAppointmentButton
        }
        .padding(.horizontal, 24)
        .padding(.top, 24)
    }
    
    private var tabs: some View {
        HStack(spacing: .zero) {
            ForEach(AppointmentStatus.displayStatuses, id: \.self) { status in
                button(for: status)
            }
        }
    }
    
    private func button(for status: AppointmentStatus) -> some View {
        Button {
            viewModel.selectStatus(status)
        } label: {
            Text(status.title)
                .font(.headline)
                .foregroundStyle(viewModel.selectedStatus == status ? .primaryTheme : .secondaryText)
                .frame(height: 45)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(viewModel.selectedStatus == status ? .primaryTheme : .stroke)
                        .frame(height: 1)
                }
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
        
    private var content: some View {
        List {
            if viewModel.isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity)
                    .transition(.opacity.combined(with: .scale))
                    .padding(.top, 50)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.primaryBackground)
            } else {
                if let appointments = viewModel.appointments[viewModel.selectedStatus],
                   !appointments.isEmpty {
                    ForEach(appointments) { appt in
                        AppointmentCard(
                            appointment: appt,
                            style: appt.status == .upcoming && appt.id == appointments.first?.id ? .featured : .default
                        )
                        .listRowBackground(Color.primaryBackground)
                        .listRowSeparator(.hidden)
                    }
                }
                
            }
        }
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .scrollDisabled(viewModel.isLoading)
        .animation(.default, value: viewModel.isLoading)
        .frame(maxWidth: .infinity)
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .refreshable {
            viewModel.refresh()
        }
    }
    
    private var newAppointmentButton: some View {
        Button {
            // TODO: Add action
        } label: {
            HStack(spacing: 10) {
                Images.addAppointment.image.renderingMode(.template)
                Text("New")
                    .font(.headline)
            }
            .foregroundStyle(Color.primaryText)
            .padding(15)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.stroke, lineWidth: 0.75)
                    .foregroundColor(.clear)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    AppointmentsView(viewModel: AppointmentsViewModel(services: CoreServices()))
}
