import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                        
                    }
//                PostsListView()
                Text("Community")
                    .tabItem {
                        Label("Community", systemImage: "square.grid.2x2")
                        
                    }
                TimerView()
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
