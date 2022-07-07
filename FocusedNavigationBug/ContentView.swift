//
//  ContentView.swift
//  FocusedNavigationBug
//
//  Created by Jason Ji on 7/6/22.
//

import Combine
import SwiftUI

struct ContentView: View {
    @State var isShowing = false
    var body: some View {
        Button("Sheet") {
            isShowing.toggle()
        }
        .sheet(isPresented: $isShowing) {
            RootSheetView()
        }
    }
}

class Coordinator: ObservableObject {
    @Published public var navigationStack = [Int]()
    
    public init() {}
}

struct RootSheetView: View {
    @StateObject var coordinator = Coordinator()
    
    @FocusState private var focusedField: Int?
    
    var body: some View {
        let _ = Self._printChanges()
        NavigationStack(path: $coordinator.navigationStack) {
            Form {
                TextField("Recipe Name", text: Binding.constant(""))
                    .focused($focusedField, equals: 1)

                NavigationLink(value: 0) {
                    Text("Manage Reminders")
                }
            }
            .safeAreaInset(edge: .bottom) {
                if focusedField == nil {
                    Text("Hmm").padding()
                }
            }
            .navigationTitle("First Sheet")
            .navigationDestination(for: Int.self) { screen in
                ManageRemindersView()
            }
        }
    }
}

struct ManageRemindersView: View {
    @State var isShowing = false
    
    var body: some View {
        Button("Show") {
            isShowing.toggle()
        }
        .sheet(isPresented: $isShowing) {
            NavigationStack {
                AddReminderView() {
                    isShowing = false
                }
                .navigationTitle("Second Sheet")
            }
        }
        .navigationTitle("Detail Screen")
    }
}

struct AddReminderView: View {
    let onReminderAdded: () -> ()
    
    var body: some View {
        Button("Dismiss") {
            onReminderAdded()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
