//
//  ContentView.swift
//  TaskCancelKitExample
//
//  Created by 김인섭 on 4/2/24.
//

import SwiftUI
import TaskCancelKit

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text("Count: \(viewModel.count)")
                .font(.title)
                .padding(.bottom, 8)
            Button("Start Counting") {
                viewModel.startCountFive()
            }
            Button("Cancel Count") {
                viewModel.cancelTask()
            }
        }
        .padding()
    }
}

class ViewModel: ObservableObject {
    
    @Published var count = 0
    private let taskBag = TaskCancelBag<TaskID>()
    
    enum TaskID {
        case countFive
    }
    
    func startCountFive() {
        Task { @MainActor in
            for i in 0...5 {
                count = i
                try await Task.sleep(for: .seconds(1))
            }
        }.store(in: taskBag, id: .countFive)
    }
    
    func cancelTask() {
        taskBag.cancel(id: .countFive)
    }
}

#Preview {
    ContentView()
}
