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
    @State private var passedSeconds: Int = 0
    @State private var isFasting: Bool = false
    
    let dateTimeFormatter = DateFormatter()
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            printTime()
                .multilineTextAlignment(.center)
                .padding()
                .onReceive(timer){ _ in
                    if !isFasting {
                        remainingSeconds = startDateTime.timeIntervalSince(Date())
                        if remainingSeconds <= 0 {
                            isFasting = true
                        }
                    } else if durationSeconds > 0 {
                        durationSeconds -= 1
                        passedSeconds += 1
                    }
                    
                }
                .onAppear(perform: {
                    remainingSeconds = startDateTime.timeIntervalSince(Date())
                    durationSeconds = durationHour * 3600
                    
                })
            Text(fastingDuration())
                .font(.system(size: 14))
        }
    }
    
    @ViewBuilder
    func printTime() -> some View {
        NavigationStack {
            VStack {
                if !isFasting {
                    Text("단식 시작까지")
                        .fontWeight(.bold)
                    Text("\(printClockFormat(Int(remainingSeconds)))")
                        .kerning(3)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 22)
                    
                } else if durationSeconds > 0 {
                    Text("\(durationHour)시간 단식 중")
                        .font(.headline)
                    Text("\(printClockFormat(passedSeconds))")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Text("\(printClockFormat(durationSeconds))")
                        .fontWeight(.bold)
                } else {
                    Text("\(durationHour)시간 단식 완료")
                    Text("")
                    Text("")
                }
            }
            .navigationTitle("단식 타이머")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: {
                        FastingSettingView()
                    }, label: {
                        Text("단식 종료")
                    })
                }
            }
        }
    }
    
    func printClockFormat(_ seconds: Int) -> String {
        let hour = Int(seconds / 3600)
        let minute = (Int(seconds) % 3600) / 60
        let second = Int(seconds) % 60
        
        return String(format: "%02d", hour) + ":" + String(format: "%02d", minute) + ":" + String(format: "%02d", second)
    }
    
    func fastingDuration() -> String {
        dateTimeFormatter.locale = Locale(identifier: "ko_KR")
        dateTimeFormatter.dateFormat = "M.d a H:mm"
        let startString = dateTimeFormatter.string(from: startDateTime)
//        let start = dateTimeFormatter.date(from: startString)
        let endDateTime = startDateTime.addingTimeInterval(TimeInterval(durationHour*60*60))
        let endString = dateTimeFormatter.string(from: endDateTime)
//        let end = dateTimeFormatter.date(from: endString)
        
        return "\(startString) ~ \(endString)"
    }
}

#Preview {
    TimerActionView(startDateTime: Date(), durationHour: 1)
}
