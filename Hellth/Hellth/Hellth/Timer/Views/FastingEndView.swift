//
//  FastingEndView.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-03.
//

import SwiftUI

struct FastingEndView: View {
    var fastingTime: String
    var ramainingTime: String
    
    var body: some View {
//        NavigationStack {
            VStack {
                Text("딘식 실시 시간")
                    .font(.title)
                Text("\(fastingTime)")
                    .kerning(3)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 22)
                Text("남은 시간")
                    .font(.title)
                Text("\(ramainingTime)")
                    .kerning(3)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 22)
            }
            .navigationTitle("단식 결과")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        TimerView()
                    }, label: {
                        Text("단식 타이머 만들기")
                    })
                }
            }
//        }
    }
}

#Preview {
    FastingEndView(fastingTime: "00:00:00", ramainingTime: "00:00:00")
}
