//
//  ContentView.swift
//  MyPinkFurnitureStore
//
//  Created by Hualiteq International on 2025/4/29.
//

import SwiftUI

struct ContentView: View {
    // State variable to track which tab is currently active
    @State var currentTab: Tab = .Home

    init() {
        // Hide "the default iOS tab bar" since we're creating a custom one !!
        UITabBar.appearance().isHidden = true
    }
    
    // Namespace for matched geometry effect animations
    // This allows smooth transitions between different views/states
    @Namespace var animation
    
    var body: some View {
        // Main TabView that handles switching between different tab content
        TabView(selection: $currentTab) {
          
            // Tab content views - currently just placeholder Text views
            // Each view is tagged with its corresponding Tab enum case
            Text("Home view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Home)
            Text("Search view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Search)
            Text("Notification view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Notifications)
            Text("Cart view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Cart)
            Text("Profile view")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background()
                .tag(Tab.Profile)
        }
        // Custom tab bar overlay at the bottom of the screen
        .overlay(
            HStack(spacing: 0){
                // Create tab buttons for each tab case
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                }
                .padding(.vertical)
                // COMPLEX PADDING EXPLANATION:
                // This padding adjusts the bottom space for the tab bar based on the device's safe area
                // If device has no bottom safe area (older phones with home button), use 5pt
                // If device has a bottom safe area (newer phones with notch/dynamic island), use (safeArea.bottom - 15)
                // This ensures the tab bar looks good on all device types
                .padding(.bottom, getSafeArea().bottom == 0 ? 5 : (getSafeArea().bottom - 15))
                .background(Color.kSecondary)
            }
            ,
            alignment: .bottom
        )
        // Ignore safe area at the bottom to allow the tab bar to extend to the edge of the screen
        // This removes the default separator line that appears at the edge of safe areas
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    // Custom tab button view builder function
    func TabButton(tab: Tab) -> some View {
        // GeometryReader allows us to get the dimensions of the parent view
        GeometryReader{ proxy in
            Button(action: {
                // Animate tab switching with spring animation for a bouncy effect
                withAnimation(.spring()) {
                    currentTab = tab
                }
            }, label: {
                VStack(spacing: 0) {
                    // Tab icon - shows filled version when selected, outline when not
                    Image(systemName: currentTab == tab ? tab.rawValue + ".fill" : tab.rawValue)
                        .resizable()
                        .foregroundColor(Color.kPrimary)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                        .background(
                            ZStack {
                                // Conditional appearance for the selected tab
                                if currentTab == tab {
                                    // Blurred circle background effect behind the selected tab icon
                                    MaterialEffect(style: .light)
                                        .clipShape(Circle())
                                        // This is the animation magic - it matches the geometry between states
                                        // for smooth transitions when switching tabs
                                        .matchedGeometryEffect(id: "Tab", in: animation)
                                    
                                    // Show tab name text only under the selected tab
                                    Text(tab.Tabname)
                                        .foregroundStyle(.primary)
                                        .font(.footnote)
                                        .padding(.top, 50)
                                }
                            }
                        )
                        // Make the entire area tappable
                        .contentShape(Rectangle())
                        // Move the selected tab icon up by 15 points for a raised effect
                        // Non-selected tabs remain at y-offset 0
                        .offset(y: currentTab == tab ? -15 : 0)
                }
            })
        }
        .frame(height: 25)
    }
}

#Preview {
    ContentView()
}

// Enum defining all possible tabs
enum Tab: String, CaseIterable {
    // Each case uses the SF Symbol name as its raw value
    case Home = "house"
    case Search = "magnifyingglass.circle"
    case Notifications = "bell"
    case Cart = "bag"
    case Profile = "person"
    
    // Computed property to get the display name for each tab
    var Tabname: String {
        switch self {
        case .Home:
            return "Home"
        case .Search:
            return "Search"
        case .Notifications:
            return "Notifications"
        case .Cart:
            return "Cart"
        case .Profile:
            return "Profile"
        }
    }
}

// Extension to get the safe area insets for the current device
extension View {
    func getSafeArea() -> UIEdgeInsets {
        // Get the first connected scene
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero // Return zero insets if no scene is found
        }
        // Get the safe area insets from the first window
        guard let safeArea = screen.windows.first?.safeAreaInsets else {
            return .zero // Return zero insets if no window is found
        }
        return safeArea
    }
}

// UIViewRepresentable struct to use UIKit's blur effect in SwiftUI
struct MaterialEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style  // Blur effect style (light, dark, etc.)
    
    // Create the UIKit view
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    // Update the view if needed (empty implementation since our view doesn't change)
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // No updates needed
    }
}
