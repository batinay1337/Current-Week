//
//  ContentView.swift
//  CurrentWeek
//
//  Created by Batınay Ünsel on 3.03.2023.
//


import SwiftUI

struct ContentView: View {
    //MARK: UI Properties
    @State var currentWeek: [Date] = []
    @State var currentDay: Date = Date()
    @State var isPresentingCalendar = false
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Week")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button {
                    
                    withAnimation {
                        isPresentingCalendar.toggle()
                        }
                    
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                }
            }
            
            
            //MARK: CURRENT WEEK VIEW
            
            HStack(spacing: 10) {
                ForEach(currentWeek, id: \.self){date in
                    Text(extracDate(date: date))
                        .fontWeight(isSameDay(date1: currentDay, date2: date) ? .bold : .semibold)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, isSameDay(date1: currentDay, date2: date) ? 6 : 0)
                        .padding(.horizontal, isSameDay(date1: currentDay, date2: date) ? 12 : 0)
                        .frame(width: isSameDay(date1: currentDay, date2: date) ? 140 : nil)
                        .background{
                            Capsule()
                                .fill(.ultraThinMaterial)
                                .environment(\.colorScheme, .light)
                                .opacity(isSameDay(date1: currentDay, date2: date) ? 0.8 : 0)
                        }
                        .onTapGesture {
                            withAnimation {
                                currentDay = date
                            }
                        }
                        
                }
            }
            .padding(.top,10)
        }
        .padding()
        .onAppear(perform: extractCurrentWeek)
        .sheet(isPresented: $isPresentingCalendar, content: {
            withAnimation(.easeInOut(duration: 0.3)) {
                CalendarView(selectedDate: $currentDay)
                    .transition(.move(edge: .bottom))
            }
            
                })
    }
    
    //MARK: Extracting Current Week
    func extractCurrentWeek() {
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let firstday = week?.start else {
            return
        }
        (0..<7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstday) {
                currentWeek.append(weekDay)
            }
        }
    }
    
    //MARK: Extracting Custom Date Compomemts
    func extracDate(date: Date)->String {
        let formatter = DateFormatter()
        formatter.dateFormat = (isSameDay(date1: currentDay, date2: date) ? "dd MMM" : "dd")
        
        return (isDateToday(date: date) && isSameDay(date1: currentDay, date2: date) ? "Today, " : "") + formatter.string(from: date)
    }
    
    //MARK: Check Date is Today or Not
    func isDateToday(date: Date)->Bool {
        let calendar = Calendar.current
        
        return calendar.isDateInToday(date)
    }
    
    func isSameDay(date1:  Date, date2: Date)->Bool {
        let calendar = Calendar.current
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
