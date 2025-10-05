//
//  DIContainer.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import Foundation

// MARK: - Safe APOD Service
// Fallback service when APODService is not available
class SafeAPODService: APODServiceProtocol {
    func fetchTodaysAPOD() async throws -> APODResult {
        throw NetworkError.networkError(NSError(domain: "SafeAPODService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Service not available"]))
    }
    
    func fetchAPOD(for date: Date) async throws -> APODResult {
        throw NetworkError.networkError(NSError(domain: "SafeAPODService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Service not available"]))
    }
}

// MARK: - Dependency Injection Container
final class DIContainer {
    static let shared = DIContainer()
    
    private var services: [String: Any] = [:]
    private let queue = DispatchQueue(label: "di.container", attributes: .concurrent)
    
    private init() {}
    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        queue.async(flags: .barrier) {
            self.services[key] = factory
        }
        logInfo("Service registered: \(type)")
    }
    
    func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        queue.async(flags: .barrier) {
            
            let instance = factory()
            self.services[key] = instance
        }
        logInfo("Singleton registered: \(type)")
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        return queue.sync {
            // Return existing singleton instance
            if let service = services[key] as? T {
                return service
            }
            
            // Create new instance from factory
            if let factory = services[key] as? () -> T {
                return factory()
            }
            
            logError("Service not found: \(type)")
            
            // Try to create a default service
            if let defaultService = createDefaultService(for: type) {
                return defaultService
            }
            
            // Last resort: create a safe placeholder
            return createSafePlaceholder(for: type)
        }
    }
    
    private func createDefaultService<T>(for type: T.Type) -> T? {
        if type == NetworkServiceProtocol.self {
            return NetworkService() as? T
        } else if type == CacheServiceProtocol.self {
            return CacheService() as? T
        } else if type == ImageServiceProtocol.self {
            return ImageService() as? T
        } else if type == LoggerProtocol.self {
            return Logger.shared as? T
        }
        
        return nil
    }
    
    private func createSafePlaceholder<T>(for type: T.Type) -> T {
        if type == APODServiceProtocol.self {
            return SafeAPODService() as! T
        }
        
        logError("Cannot create safe placeholder for type: \(type)")
        return createEmptyObject(for: type)
    }
    
    private func createEmptyObject<T>(for type: T.Type) -> T {
        fatalError("Cannot create safe placeholder for type: \(type). Please register this service.")
    }
    
}

// MARK: - Property Wrapper
@propertyWrapper
struct Injected<T> {
    private let type: T.Type
    
    init(_ type: T.Type) {
        self.type = type
    }
    
    var wrappedValue: T {
        return DIContainer.shared.resolve(type)
    }
}

// MARK: - Service Registry
final class ServiceRegistry {
    static func registerAllServices() {
        let container = DIContainer.shared
        
        container.registerSingleton(LoggerProtocol.self) { Logger.shared }
        container.registerSingleton(ErrorHandler.self) { ErrorHandler.shared }
        
        container.registerSingleton(NetworkServiceProtocol.self) { NetworkService() }
        container.registerSingleton(APODServiceProtocol.self) { APODService() }
        
        container.registerSingleton(CacheServiceProtocol.self) { CacheService() }
        container.registerSingleton(ImageServiceProtocol.self) { ImageService() }
        
        container.register(APODViewModel.self) { 
            APODViewModel()
        }
        
        logInfo("All services registered successfully")
    }
}
