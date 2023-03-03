//
//  CalendarView.swift
//  CurrentWeek
//
//  Created by Batınay Ünsel on 3.03.2023.
//

import SwiftUI

struct CalendarView: View {
    //MARK: UI Properties
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                .datePickerStyle(GraphicalDatePickerStyle())
        }
        .frame(height: 300)
    }
}


