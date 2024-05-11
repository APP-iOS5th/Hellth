//
//  FastingRecords.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-11.
//

import SwiftUI

struct FastingRecords: View {
    @StateObject private var fastingManager:FastingManager = FastingManager()
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(fastingManager.fastings.filter { $0.passedSeconds > 0}) { fasting in
                    VStack(alignment: .leading) {
                        HStack {
                            Text("단식 지속 시간:")
                            Text("\(printClockFormat(fasting.passedSeconds))")
                        }
                        .font(.headline)
                        HStack {
                            Text("단식 시작:")
                            Text("\(dateFormat(fasting.startDateTime))")
                        }
                        HStack {
                            Text("단식 계획 시간:")
                            Text("\(fasting.durationHour) 시간")
                        }
                    }
                    .padding(.bottom, 10)
                }
            }
            .navigationTitle("단식 기록")
        }
    }
    func printClockFormat(_ seconds: Int) -> String {
        let hour = Int(seconds / 3600)
        let minute = (Int(seconds) % 3600) / 60
        let second = Int(seconds) % 60
        
        return String(format: "%02d", hour) + ":" + String(format: "%02d", minute) + ":" + String(format: "%02d", second)
    }
    let dateTimeFormatter = DateFormatter()
    func dateFormat(_ date: Date) -> String {
        dateTimeFormatter.locale = Locale(identifier: "ko_KR")
        dateTimeFormatter.dateFormat = "yyyy년 M월 d일 a H:mm"
        let dateString = dateTimeFormatter.string(from: date)
        
        return "\(dateString)"
    }
}

#Preview {
    FastingRecords()
}
