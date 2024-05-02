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
    init(startDateTime: Date, durationHour: Int) {
        self.startDateTime = startDateTime
        self.durationHour = durationHour
        self.durationSeconds = durationHour * 60 * 60
    }
    var body: some View {
        VStack {
            Text("Duration Hour: \(durationHour)")
            Text("\(isFasting ? "\(durationHour)시간 단식중" : "단식 시작까지")")
            Text("\(isFasting ? durationSeconds : Int(remainingSeconds))")
                .onReceive(timer){ time in
                    if !isFasting {
                        self.remainingSeconds = startDateTime.timeIntervalSince(Date())
                        if remainingSeconds < 0 {
                            isFasting.toggle()
                        }
                    } else if self.durationSeconds > 0{
                        self.durationSeconds -= 1
                    }
                    
                }
                .onAppear(perform: {
                    self.remainingSeconds = startDateTime.timeIntervalSince(Date())
                })
        }
    }
}

#Preview {
    TimerActionView(startDateTime: Date(), durationHour: 1)
}
