//
//  CoreNetworkingService.swift
//  FayProject
//
//  Created by Brayden Harris on 6/25/25.
//

import Combine
import CoreNetworking
import Foundation

final class CoreNetworkingService {
    private var jwtTokenProvider: JWTTokenProvider
    private var service: RESTNetworkingService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        jwtTokenProvider: JWTTokenProvider = DefaultJWTTokenProvider()
    ) {
        self.jwtTokenProvider = jwtTokenProvider
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        service = BasicRESTNetworkingService(
            host: URL(string: "https://node-api-for-candidates.onrender.com")!,
            headers: ["Content-Type": "application/json"],
            encoder: encoder,
            decoder: decoder
        )
        observeJwtChanges()
    }
    
    func provideJWT(token: String) {
        jwtTokenProvider.token.send(token)
    }
    
    func get<Request: NetworkRequest>(_ request: Request) throws -> AnyPublisher<Request.ExpectedResponseType, NetworkingError> {
        try service.get(request)
    }
    func post<Request: NetworkInputRequest>(_ request: Request) throws -> AnyPublisher<Request.ExpectedResponseType, NetworkingError> {
        try service.post(request)
    }
    
    private func observeJwtChanges() {
        jwtTokenProvider.token.sink { [weak self] token in
            if let token {
                self?.service.headers["Authorization"] = "Bearer \(token)"
            } else {
                self?.service.headers.removeValue(forKey: "Authorization")
            }
        }
        .store(in: &cancellables)
    }
}
