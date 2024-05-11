//  TimerView.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-01.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        NavigationStack {
            NavigationLink(destination: FastingSettingView()) {
                Text("단식 타이머 만들기")
                    .font(.title)
                    .padding(10)
                    .foregroundStyle(.white)
                    .background(RoundedRectangle(cornerRadius: 15, style: .circular))
                
            }
            .navigationTitle("단식 타이머")
        }
    }
}

#Preview {
    TimerView()
}
