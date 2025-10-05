//
//  MainTabView.swift
//  AstroDaily
//
//  Created by Hu AN on 01/10/2025.
//

import SwiftUI

// MARK: - Main Tab View
struct MainTabView: View {
    var body: some View {
        TabView {
            APODContentView()
                .tabItem {
                    Image(systemName: "photo.on.rectangle")
                    Text("Today")
                }
            
            APODHistoryView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("History")
                }
        }
        .accentColor(ColorTheme.primary)
        .astroDarkModeSupport()
        .standardFontSize()
    }
}

#Preview {
    MainTabView()
}
