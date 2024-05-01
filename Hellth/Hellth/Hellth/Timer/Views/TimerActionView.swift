//
//  TimerActionView.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-01.
//

import SwiftUI

struct TimerActionView: View {
    var startHour = 0
    var startMinute = 0
    var durationHour = 0
    
    var body: some View {
        VStack {
            Text("Start: \(startHour) : \(startMinute)")
            Text("Duration Hour: \(durationHour)")
        }
    }
}

#Preview {
    TimerActionView()
}
