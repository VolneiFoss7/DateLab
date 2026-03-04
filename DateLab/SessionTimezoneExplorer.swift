//
//  SessionTimezoneExplorer.swift
//  DateLab
//
//  Created by Volnei Foss on 04/03/26.
//

import SwiftUI
import Combine

class SessionTimezoneExplorerViewModel: ObservableObject {

    enum TimeZoneOption: String, CaseIterable {
        
        case utc = "UTC"
        case saoPaulo = "America/Sao_Paulo"
        case newYork = "America/New_York"
        case london = "Europe/London"
        case tokyo = "Asia/Tokyo"
        
        var timeZone: TimeZone {
            TimeZone(identifier: self.rawValue)!
        }
        
        var name: String {
            switch self {
            case .utc:
                return "UTC"
            case .saoPaulo:
                return "São Paulo"
            case .newYork:
                return "New York"
            case .london:
                return "London"
            case .tokyo:
                return "Tokyo"
            }
        }
    }
    
    @Published var resultTimeZones: [String : TimeZoneOption] = [:]
    var date = Date()
    var selectedTimeZone: TimeZoneOption = .utc
    
    func addChoiceTimeZone(){
        self.resultTimeZones[selectedTimeZone.name] = selectedTimeZone
    }
    
    func formattedTime(for option: TimeZoneOption, at date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = option.timeZone
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        
        return formatter.string(from: date)
    }
}

struct SessionTimezoneExplorer: View {
    
    @ObservedObject var viewModel: SessionTimezoneExplorerViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("Select hour", selection: $viewModel.date, displayedComponents: .hourAndMinute)
            
            VStack(alignment: .leading){
                Text("Select time zone option")
                
                Picker("Time Zone option", selection: $viewModel.selectedTimeZone){
                    Text("UTC").tag(SessionTimezoneExplorerViewModel.TimeZoneOption.utc)
                    Text("São Paulo").tag(SessionTimezoneExplorerViewModel.TimeZoneOption.saoPaulo)
                    Text("New York").tag(SessionTimezoneExplorerViewModel.TimeZoneOption.newYork)
                    Text("London").tag(SessionTimezoneExplorerViewModel.TimeZoneOption.london)
                    Text("Tokyo").tag(SessionTimezoneExplorerViewModel.TimeZoneOption.tokyo)
                }
                .pickerStyle(.menu)
                
                Button(action: {
                    viewModel.addChoiceTimeZone()
                }) {
                    Text("Add choice")
                        .padding(6)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(lineWidth: 1)
                        }
                    
                }
                .buttonStyle(.plain)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 8) {
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(Array(viewModel.resultTimeZones), id: \.key) { key, option in
                            HStack(spacing: 12) {
                                VStack(alignment: .leading) {
                                    Text(key)
                                        .font(.headline)
                                    Text(option.timeZone.identifier)
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Text(viewModel.formattedTime(for: option, at: viewModel.date))
                                    .monospacedDigit()
                            }
                            .padding(8)
                            .overlay {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.gray.opacity(0.4), lineWidth: 1)
                            }
                        }
                    }
                    .padding(.top, 8)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
}

#Preview {
    SessionTimezoneExplorer(viewModel: SessionTimezoneExplorerViewModel())
}
