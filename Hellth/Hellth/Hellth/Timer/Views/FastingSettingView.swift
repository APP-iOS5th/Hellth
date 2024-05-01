//
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
    
    private func oneMonthFromToday() -> Date {
        let calendar = Calendar.current
        
        return calendar.date(byAdding: .month, value: 1, to: Date()) ?? Date()
    }
    var body: some View {
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
                                Picker(selection: $startHour, label: Text("Hour")) {
                                    ForEach(0..<24) { hour in
                                        Text("\(hour)")
                                    }
                                }
                                .frame(width: 80)
                                .pickerStyle(MenuPickerStyle())
                                .labelsHidden()
                                Text("시")
                            }
                            HStack {
                                Picker(selection: $startMinute , label: Text("Minute")) {
                                    ForEach(0..<6) { minute in
                                        Text("\(minute * 10)")
                                            .tag(minute * 10)
                                    }
                                }
                                .frame(width: 200)
                                .pickerStyle(SegmentedPickerStyle())
                                .labelsHidden()
                                Text("분")
                            }
                        }
                    }
                    Section(header:
                                Text("단식 유지 시간")
                        .font(.title3)
                        .fontWeight(.bold)
                    ) {
                        HStack {
                            TextField("시간", value: $durationHour, format: .number)
                                .keyboardType(.numberPad)
                                .frame(width: 80)
                            Text("시간")
                        }
                        .padding(.bottom, 20)
                    }
                    NavigationLink {
                        TimerActionView(startDate: startDate, startHour: startHour, startMinute: startMinute, durationHour: durationHour)
                    } label: {
                        Text("단식 시작")
                    }
                    Spacer()
                }
                .navigationTitle("단식 계획 설정")
            }
        }
    }
}

#Preview {
    FastingSettingView()
}
