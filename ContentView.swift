import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = SpeedTestViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Velocidad: \(Int(viewModel.currentSpeed)) km/h")
                .font(.largeTitle)
                .bold()

            if viewModel.testInProgress {
                Text("⏱ Tiempo: \(String(format: "%.2f", viewModel.elapsedTime)) s")
                    .font(.title2)
            }

            Button(action: {
                viewModel.startTest()
            }) {
                Text(viewModel.testInProgress ? "En progreso..." : "Iniciar prueba 0–100 km/h")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(viewModel.testInProgress)
        }
        .padding()
        .onAppear {
            viewModel.startUpdatingSpeed()
        }
    }
}