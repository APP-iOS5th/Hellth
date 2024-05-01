import SwiftUI


struct ContentView: View {
    @State private var isLoggedIn = true
    var body: some View {
        VStack {
            if isLoggedIn {
                TabView {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                            
                        }
                    Text("Community")
                        .tabItem {
                            Label("Community", systemImage: "square.grid.2x2")
                            
                        }
                    
                    Text("Timer")
                        .tabItem {
                            Label("Timer", systemImage: "clock")
                            
                        }
                    
                    Text("Profile")
                        .tabItem {
                            Label("Profile", systemImage: "person")
                        }
                }
                .accentColor(.green)
            } else {
                LoginView()
            }
        }
    }
}

#Preview {
    ContentView()
}
