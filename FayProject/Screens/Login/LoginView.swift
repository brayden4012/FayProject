//
//  LoginView.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    
    init(
        viewModel: LoginViewModel
    ) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()

            Images.fayLogo.image.resizable().aspectRatio(contentMode: .fit)
                .padding(.bottom, 12)

            TextField("Username", text: $viewModel.username)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color.primaryBackground.opacity(0.5))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            viewModel.errorMessage != nil ? Color.red : Color.stroke,
                            lineWidth: 1
                        )
                )

            SecureField("Password", text: $viewModel.password)
                .padding()
                .background(Color.primaryBackground.opacity(0.5))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(
                            viewModel.errorMessage != nil ? Color.red : Color.stroke,
                            lineWidth: 1
                        )
                )
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.callout)
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Spacer()
                .frame(height: 12)

            Button {
                login()
            } label: {
                if viewModel.isLoggingIn {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(Color.primaryTheme)
                } else {
                    Text("Login")
                        .foregroundColor(viewModel.isFormValid ? .white : .secondaryText)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 54)
                        .background(viewModel.isFormValid ? Color.primaryTheme : Color.secondaryBackground)
                }
            }
            .cornerRadius(10)
            .buttonStyle(.plain)
            .disabled(!viewModel.isFormValid || viewModel.isLoggingIn)
            .animation(.default, value: viewModel.isFormValid)

            Spacer()
            HStack {
                Text("Don't have an account?")
                    .foregroundColor(.secondaryText)
                Button {
                    // TODO: Navigate to sign-up
                } label: {
                    Text("Sign Up")
                        .fontWeight(.medium)
                        .foregroundStyle(Color.primaryTheme)
                }
                .buttonStyle(.plain)
            }
            .font(.footnote)
            
        }
        .padding()
        .background(
            LinearGradient(
                colors: [
                    Color.primaryTheme,
                    Color.primaryTheme.opacity(colorScheme == .light ? 0.1 : 0.2)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }

    private func login() {
        viewModel.authenticate()
    }
}


#Preview {
    LoginView(viewModel: LoginViewModel(services: CoreServices()))
}
