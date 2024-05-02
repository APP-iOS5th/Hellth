//
//  TimerActionView.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-01.
//

import SwiftUI

struct TimerActionView: View {
    let startDateTime: Date
    let durationHour: Int
    
    @State private var remainingSeconds: Double = 0.0
    @State private var durationSeconds: Int = 0
    @State private var isFasting: Bool = false
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            Text("Duration Hour: \(durationHour)")
            Text(printTime())
                .onReceive(timer){ _ in
                    if !isFasting {
                        remainingSeconds = startDateTime.timeIntervalSince(Date())
                        if remainingSeconds <= 0 {
                            isFasting = true
                        }
                    } else if durationSeconds > 0 {
                        durationSeconds -= 1
                    }
                    
                }
                .onAppear(perform: {
                    remainingSeconds = startDateTime.timeIntervalSince(Date())
                    durationSeconds = durationHour * 10
                })
        }
    }
    
    func printTime() -> String {
        if !isFasting {
            return "단식 시작까지\n남은 시간: \(Int(remainingSeconds))"
        } else if durationSeconds > 0 {
            return "\(durationHour)시간 단식중\n남은 시간: \(durationSeconds)"
        } else {
            return "\(durationHour)시간 단식 완료"
        }
    }
}

#Preview {
    TimerActionView(startDateTime: Date(), durationHour: 1)
}
