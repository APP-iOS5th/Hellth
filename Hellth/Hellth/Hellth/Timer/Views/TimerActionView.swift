//
//  TimerActionView.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-01.
//

import SwiftUI

struct TimerActionView: View {
    var startDate: Date
    var startHour: Int
    var startMinute: Int
    var durationHour: Int
    
    var currentDate = Date.now
    
    var body: some View {
        let startDateTime = startDate.addingTimeInterval(TimeInterval(startHour*60*60 + startMinute*60))
        VStack {
            Text("\(startDate)")
            Text("Start: \(startDate.formatted(.dateTime.day().month().year())) \(startHour) 시 \(startMinute)분")
            Text("Duration Hour: \(durationHour)")
            Text("Start: \(startDateTime), \nCurrent: \(currentDate)")
            Text("\(currentDate.timeIntervalSince(startDateTime) )")
        }
    }
}

#Preview {
    TimerActionView(startDate: Date(), startHour: 17, startMinute: 0, durationHour: 1)
}
