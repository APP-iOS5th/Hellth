//  FastingSettingView.swift
//  Hellth
//
//  Created by Jungjin Park on 2024-05-01.
//

import SwiftUI

struct FastingSettingView: View {
    @State private var startDate = Date()
    @State private var startHour = 0
    @State private var startMinute = 0
    @State private var durationHour = 0
    private var currentDateTime = Date.now
    
    private func oneMonthFromToday() -> Date {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .day, value: 7, to: Date()) ?? Date()
    }
    
    var body: some View {
        let startDateTime = (Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate) ?? Date()).addingTimeInterval(TimeInterval(startHour*60*60 + startMinute*60))
        
        NavigationStack {
            ScrollView {
                VStack {
                    Section(header:
                                Text("시작 날짜")
                        .font(.title3)
                        .fontWeight(.bold)
                    ) {
                        DatePicker("Selcted Date", selection: $startDate, in: Date()...oneMonthFromToday(), displayedComponents: .date)
                            .frame(width: 300)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .labelsHidden()
                            .onChange(of: startDate) {
                                newValue in
                                startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: newValue) ?? Date()
                            }
                    }
                    Section(header:
                                Text("시작 시간")
                        .font(.title3)
                        .fontWeight(.bold)
                    ) {
                        VStack {
                            HStack {
                                Picker("Hour", selection: $startHour) {
                                    ForEach(0..<24) { hour in
                                        Text("\(hour)")
                                            .tag(hour)
                                    }
                                }
                                .frame(width: 100, height: 60)
                                .pickerStyle(.inline)
                                .labelsHidden()
                                Text("시")
                            }
                            HStack {
                                Picker("Minute", selection: $startMinute) {
                                    ForEach(0..<6) { minute in
                                        Text("\(minute * 10)")
                                            .tag(minute * 10)
                                    }
                                }
                                .frame(width: 300)
                                .pickerStyle(SegmentedPickerStyle())
                                .labelsHidden()
                                Text("분")
                            }
                        }
                        .padding(.bottom, 20)
                    }
                    Section(header:
                                Text("단식 유지 시간")
                        .font(.title3)
                        .fontWeight(.bold)
                    ) {
                        HStack {
                            Picker("시간", selection: $durationHour) {
                                ForEach(0..<49) { time in
                                    Text("\(time)")
                                        .tag(time)
                                }
                            }
                            .frame(width: 100, height: 60)
                            .pickerStyle(.inline)
                            .labelsHidden()
                            Text("시간")
                        }
                        .padding(.bottom, 20)
                    }
                    Spacer()
                }
                .navigationTitle("단식 계획 설정")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink(destination: {
                            TimerActionView(startDateTime: startDateTime, durationHour: durationHour)
                        }, label: {
                            Text("단식 시작")
                        })
                        .disabled(startDateTime.timeIntervalSince(currentDateTime) <= 0 || durationHour <= 0)
                    }
                }
            }
        }
    }
}

#Preview {
    FastingSettingView()
}
