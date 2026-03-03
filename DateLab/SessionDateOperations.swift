//
//  SessionDateOperations.swift
//  DateLab
//
//  Created by Volnei Foss on 03/03/26.
//

import SwiftUI
import Combine

//MARK: ViewModel
class SessionDateOperationsViewModel: ObservableObject {
    
    enum Unit {
        case day, month, year, hour, minute
        
        var calendar: Calendar.Component {
            switch self {
            case .day:
                return .day
            case .month:
                return .month
            case .year:
                return .year
            case .hour:
                return .hour
            case .minute:
                return .minute
            }
        }
    }
    
    @Published var baseDate = Date()
    @Published var selectedUnit: Unit = .day
    @Published var amount: Int = 0
    
    var resultDate: String {
        guard let date = Calendar.current.date(byAdding: selectedUnit.calendar, value: amount, to: baseDate) else {
            return Date.now.formatted(date: .abbreviated, time: .shortened)
        }
        return date.formatted(date: .abbreviated, time: .shortened)
    }
    
    func incrementStep() {
        amount += 1
    }
    
    func decrementStep() {
        amount -= 1
    }
}

//MARK: View
struct SessionDateOperations: View {
    
    @ObservedObject var viewModel: SessionDateOperationsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16){
            Text("Date Operations")
                .font(.title)
                .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 0){
                Text("select unit type")
                Picker("Unit type", selection: $viewModel.selectedUnit){
                    Text("Year").tag(SessionDateOperationsViewModel.Unit.year)
                    Text("Month").tag(SessionDateOperationsViewModel.Unit.month)
                    Text("Day").tag(SessionDateOperationsViewModel.Unit.day)
                    Text("Hour").tag(SessionDateOperationsViewModel.Unit.hour)
                    Text("Minute").tag(SessionDateOperationsViewModel.Unit.minute)
                }
                .pickerStyle(.menu)
            }
            
            DatePicker("Date", selection: $viewModel.baseDate, displayedComponents: .date)
            
            Stepper {
                Text("Value: \(viewModel.amount)")
            } onIncrement: {
                viewModel.incrementStep()
            } onDecrement: {
                viewModel.decrementStep()
            }
            HStack {
                Text("Result date:")
                Text("\(viewModel.resultDate)")
                    .font(.system(.headline, weight: .bold))
            }
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}

//MARK: Preview
#Preview() {
    SessionDateOperations(viewModel: SessionDateOperationsViewModel())
}
