import SwiftUI



extension Color {
    static let randomColors: [Color] = [ .red, .orange, .yellow, .green, .blue, .purple, .pink, .teal, .brown, .gray, .black, .white, .mint, .indigo]
}

extension View {
    func customStyled() -> some View {
        self.padding()
            .foregroundStyle(.black)
            .background(RoundedRectangle(cornerRadius: 15).fill(Color.white).shadow(color: .gray, radius: 3, x: 8, y: 8))
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
    }
}

extension View {
    func nutrientTextField(_ placeholder: String, text: Binding<String>, unit: String) -> some View {
        HStack {
            TextField(placeholder, text: text)
                .keyboardType(.numberPad)
                .padding()
                .background(Color.secondary.opacity(0.1))
                .cornerRadius(8)
            
            Text(unit)
                .foregroundColor(.secondary)
                .padding()
        }
    }
}
