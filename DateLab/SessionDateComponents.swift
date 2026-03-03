//
//  SessionDateComponents.swift
//  DateLab
//
//  Created by Volnei Foss on 02/03/26.
//
import SwiftUI

struct SessionDateComponents: View {
    
    let date = Date()

    var body: some View {
        VStack(alignment: .leading){
            
            Text("Calendar Components")
                .font(.title)
                .padding(.bottom, 16)
            
            Text("Year: \(getCalendarInfo(info: .year))")
            Text("Month: \(getCalendarInfo(info: .month))")
            Text("Day: \(getCalendarInfo(info: .day))")
            Text("Hour: \(getCalendarInfo(info: .hour))")
            Text("Minute: \(getCalendarInfo(info: .minute))")
            Text("Second: \(getCalendarInfo(info: .second))")
            
            Text("Derived Components")
                .font(.title)
                .padding(.vertical, 16)
            
            Text("Weekday: \(getCalendarInfo(info: .weekday))")
            Text("Week of the year: \(getCalendarInfo(info: .weekOfYear))")
            Text("Day of the year: \(getCalendarInfo(info: .dayOfYear))")
            Text("Quarter: \(getCalendarInfo(info: .quarter))")
            
            Text("Calendar Configuration")
                .font(.title)
                .padding(.vertical, 16)
            
            Text("identifier: \(Calendar.current.identifier)")
            Text("firstWeekday: \(Calendar.current.firstWeekday)")
            Text("minimumDaysInFirstWeek: \(Calendar.current.minimumDaysInFirstWeek)")
            
            Text("Time zone")
                .font(.title)
                .padding(.vertical, 16)
            
            Text("timezone : \(Calendar.current.timeZone.secondsFromGMT() / 3600)")
                .multilineTextAlignment(.leading)
            Text("identifier: \(Calendar.current.timeZone.identifier)")
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
    
    private func getCalendarInfo(info: Calendar.Component) -> Int {
        return Calendar.current.component(info, from: date)
    }
}


#Preview {
    SessionDateComponents()
}
