//
//  ContentView.swift
//  DateLab
//
//  Created by Volnei Foss on 02/03/26.
//

import SwiftUI
import Combine

struct DateSession: Identifiable {
    var id: UUID = UUID()
    let title: String
}

struct DateItem: View {
    
    let dateSession: DateSession
    let onTap: () -> Void
    
    var body: some View {
        Text(dateSession.title)
            .frame(maxWidth: .infinity)
            .frame(height: 150)
            .font(.subheadline)
            .overlay {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.black ,lineWidth: 1)
            }
            .padding(8)
    }
}

class ContentViewViewModel {
    
    enum Constants {
        static let dateFormatter = "Date Formatter"
        static let dateComponents = "Date Components"
        static let dateOperations = "Date Operations"
        static let timezoneExplorer = "Timezone Explorer"
        static let realCases = "Real Cases"
    }
    
    let dateSessions: [DateSession] = [
        DateSession(title: Constants.dateFormatter),
        DateSession(title: Constants.dateComponents),
        DateSession(title: Constants.dateOperations),
        DateSession(title: Constants.timezoneExplorer),
        DateSession(title: Constants.realCases)
    ]
}

struct ContentView: View {
    
    let viewModel: ContentViewViewModel
    let columns = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(viewModel.dateSessions) { session in
                            NavigationLink {
                                destinationView(for: session)
                            } label: {
                                DateItem(dateSession: session, onTap: {})
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    private func destinationView(for session: DateSession) -> some View {
        switch session.title {
        case "Date Formatter":
            SessionDateFormatter(viewModel: SessionDateFormatterViewModel())
        case "Date Components":
            SessionDateComponents()
        case "Date Operations":
            SessionDateOperations()
        case "Timezone Explorer":
            SessionTimezoneExplorer()
        case "Real Cases":
            Text("Real Cases")
        default:
            Text(session.title)
        }
    }
}

struct SessionDateOperations: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct SessionTimezoneExplorer: View {
    var body: some View {
        VStack {
            
        }
    }
}

struct SessionRealCases: View {
    var body: some View {
        VStack {
            
        }
    }
}

#Preview {
    //ContentView(viewModel: ContentViewViewModel())
    //SessionDateFormatter(viewModel: SessionDateFormatterViewModel())
    //SessionDateComponents()
}
