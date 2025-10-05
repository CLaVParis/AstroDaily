//
//  Coordinator.swift
//  AstroDaily
//
//  Created by Hu AN on 05/10/2025.
//

import SwiftUI
import Combine

// MARK: - Base Coordinator
class BaseCoordinator: CoordinatorProtocol {
    typealias Route = AnyHashable
    
    @Published var path = NavigationPath()
    @Published var presentedSheet: AnyView?
    @Published var isSheetPresented = false
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
    
    private func setupBindings() {
        $isSheetPresented
            .sink { [weak self] isPresented in
                if !isPresented {
                    self?.presentedSheet = nil
                }
            }
            .store(in: &cancellables)
    }
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func presentSheet<Content: View>(_ content: Content) {
        presentedSheet = AnyView(content)
        isSheetPresented = true
    }
    
    func dismissSheet() {
        isSheetPresented = false
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}

// MARK: - App Coordinator
final class AppCoordinator: BaseCoordinator {
    enum Route: Hashable {
        case mainTab
        case apodDetail(APOD)
        case datePicker
        case history
    }
    
    func navigate(to route: Route) {
        super.navigate(to: route)
    }
    
    func showDatePicker(selectedDate: Date, onDateSelected: @escaping (Date) -> Void) {
        let datePickerView = DatePickerView(
            selectedDate: .constant(selectedDate),
            isPresented: .constant(true),
            onDateSelected: { [weak self] date in
                onDateSelected(date)
                self?.dismissSheet()
            }
        )
        presentSheet(datePickerView)
    }
    
    func showAPODDetail(_ apod: APOD) {
        navigate(to: Route.apodDetail(apod))
    }
    
    func showHistory() {
        navigate(to: Route.history)
    }
}

// MARK: - APOD Coordinator
final class APODCoordinator: BaseCoordinator {
    enum Route: Hashable {
        case detail(APOD)
        case datePicker
    }
    
    @Published var viewModel: APODViewModel
    
    init(viewModel: APODViewModel) {
        self.viewModel = viewModel
        super.init()
        setupViewModelBindings()
    }
    
    private func setupViewModelBindings() {
        // Handle any view model events that should trigger navigation
        viewModel.$state
            .sink { state in
            }
            .store(in: &cancellables)
    }
    
    func navigate(to route: Route) {
        super.navigate(to: route)
    }
    
    func showDatePicker() {
        let datePickerView = DatePickerView(
            selectedDate: .constant(viewModel.currentRequestedDate),
            isPresented: .constant(true),
            onDateSelected: { [weak self] date in
                self?.viewModel.loadCustomDateAPOD(for: date)
                self?.dismissSheet()
            }
        )
        presentSheet(datePickerView)
    }
    
    func showAPODDetail(_ apod: APOD) {
        navigate(to: Route.detail(apod))
    }
}

// MARK: - Coordinator Environment
struct CoordinatorEnvironmentKey: EnvironmentKey {
    static let defaultValue: AppCoordinator = AppCoordinator()
}

extension EnvironmentValues {
    var coordinator: AppCoordinator {
        get { self[CoordinatorEnvironmentKey.self] }
        set { self[CoordinatorEnvironmentKey.self] = newValue }
    }
}

// MARK: - Coordinator View Modifier
struct CoordinatorViewModifier: ViewModifier {
    @StateObject private var coordinator = AppCoordinator()
    
    func body(content: Content) -> some View {
        content
            .environment(\.coordinator, coordinator)
            .navigationDestination(for: AppCoordinator.Route.self) { route in
                destinationView(for: route)
            }
            .sheet(isPresented: $coordinator.isSheetPresented) {
                coordinator.presentedSheet
            }
    }
    
    @ViewBuilder
    private func destinationView(for route: AppCoordinator.Route) -> some View {
        switch route {
        case .mainTab:
            MainTabView()
        case .apodDetail(let apod):
            APODDetailView(apod: apod)
        case .datePicker:
            EmptyView() // Handled by sheet
        case .history:
            APODHistoryView()
        }
    }
}

extension View {
    func withCoordinator() -> some View {
        modifier(CoordinatorViewModifier())
    }
}
