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
        VStack {
//            Text("Start: \(startDate.formatted(.dateTime.day().month().year().locale(Locale(identifier: "ko_KR")))) \(startHour) 시 \(startMinute)분")
            Text("Start: \(startDate.formatted(.dateTime.day().month().year())) \(startHour) 시 \(startMinute)분")
            Text("Duration Hour: \(durationHour)")
            Text("Start: \(startDate.addingTimeInterval(TimeInterval(startHour*60*60 + startMinute*60))), \nCurrent: \(currentDate)")
            Text("\(currentDate.timeIntervalSince(startDate) )")
        }
    }
}

#Preview {
    TimerActionView(startDate: Date(), startHour: 17, startMinute: 0, durationHour: 1)
}
