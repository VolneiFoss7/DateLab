//
//  SessionDateFormatter.swift
//  DateLab
//
//  Created by Volnei Foss on 02/03/26.
//

import SwiftUI
import Combine

class SessionDateFormatterViewModel: ObservableObject {
    enum DateDisplayType {
        case short, full, iso, medium, long
    }
    
    enum CurrentLocale {
        case pt_BR, en_US
        
        var locale: String {
            switch self {
            case .pt_BR:
               return "pt_BR"
            case .en_US:
                return "en_US"
            }
        }
    }
    
    private let currentDate: Date = .now
    @Published var dateDisplayType: DateDisplayType = .full
    @Published var currentLocale: CurrentLocale = .en_US
    
    var dateDisplay: String {
        switch dateDisplayType {
        case .full:
            return dateFormatter(dateStyle: .full, locale: Locale(identifier: currentLocale.locale)).string(from: currentDate)
        case .iso:
            return "\(currentDate.ISO8601Format())"
        case .short:
            return dateFormatter(dateStyle: .short, locale: Locale(identifier: currentLocale.locale)).string(from: currentDate)
        case .medium:
            return dateFormatter(dateStyle: .medium, locale: Locale(identifier: currentLocale.locale)).string(from: currentDate)
        case .long:
            return dateFormatter(dateStyle: .long, locale: Locale(identifier: currentLocale.locale)).string(from: currentDate)
        }
    }
    
    private func dateFormatter(dateStyle: DateFormatter.Style, locale: Locale) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.locale = locale
        return dateFormatter
    }
}

struct SessionDateFormatter: View {
    
    @ObservedObject var viewModel: SessionDateFormatterViewModel
    
    var body: some View {
        VStack(alignment: .leading){
            Text("Display types")
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 32)
            
            Text(viewModel.dateDisplay)
                .multilineTextAlignment(.leading)
            
            Picker("Date Display type", selection: $viewModel.dateDisplayType){
                Text("Short").tag(SessionDateFormatterViewModel.DateDisplayType.short)
                Text("Full").tag(SessionDateFormatterViewModel.DateDisplayType.full)
                Text("ISO").tag(SessionDateFormatterViewModel.DateDisplayType.iso)
                Text("Medium").tag(SessionDateFormatterViewModel.DateDisplayType.medium)
                Text("Long").tag(SessionDateFormatterViewModel.DateDisplayType.long)
            }
            .pickerStyle(.menu)
            
            if viewModel.dateDisplayType != .iso {
                Picker("Cureent Locale", selection: $viewModel.currentLocale){
                    Text("EUA").tag(SessionDateFormatterViewModel.CurrentLocale.en_US)
                    Text("BR").tag(SessionDateFormatterViewModel.CurrentLocale.pt_BR)
                }
                .pickerStyle(.menu)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
    }
}
