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
    private let currentDate = Date.now
    
    @State private var remainingSeconds: Double = 0.0
    
    var body: some View {
        let totalSeconds = startDateTime.timeIntervalSince(currentDate)
        VStack {
            Text("Duration Hour: \(durationHour)")
            Text("Start: \(startDateTime), \nCurrent: \(currentDate)")
            Text("\(startDateTime.timeIntervalSince(currentDate))")
            Text("단식 시작까지")
        }
    }
}

#Preview {
    TimerActionView(startDateTime: Date(), durationHour: 1)
}
