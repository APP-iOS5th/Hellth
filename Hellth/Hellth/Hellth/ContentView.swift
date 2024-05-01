import SwiftUI


struct ContentView: View {
    var body: some View {
        VStack {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                        
                    }
                PostListView(posts: Post.sample)
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
//            .accentColor(.green)
        }
    }
}

#Preview {
    ContentView()
}
