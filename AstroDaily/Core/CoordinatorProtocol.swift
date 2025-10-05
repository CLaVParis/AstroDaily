//
//  CoordinatorProtocol.swift
//  AstroDaily
//
//  Created by Hu AN on 05/10/2025.
//

import SwiftUI
import Combine

// MARK: - Coordinator Protocol
protocol CoordinatorProtocol: ObservableObject {
    associatedtype Route
    var path: NavigationPath { get set }
    var presentedSheet: AnyView? { get set }
    var isSheetPresented: Bool { get set }
    func navigate(to route: Route)
    func presentSheet<Content: View>(_ content: Content)
    func dismissSheet()
    func popToRoot()
}

