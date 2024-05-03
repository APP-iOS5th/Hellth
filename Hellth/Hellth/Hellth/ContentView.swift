import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                LoginView()
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
        }
    }
}

#Preview {
    ContentView()
}
