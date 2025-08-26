import Foundation
import CoreLocation

class SpeedTestViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var startTime: Date?

    @Published var currentSpeed: Double = 0.0
    @Published var testInProgress = false
    @Published var elapsedTime: Double = 0.0

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.activityType = .automotiveNavigation
        locationManager.requestWhenInUseAuthorization()
    }

    func startUpdatingSpeed() {
        locationManager.startUpdatingLocation()
    }

    func startTest() {
        testInProgress = true
        startTime = nil
        elapsedTime = 0.0
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let speed = locations.last?.speed, speed >= 0 else { return }
        currentSpeed = speed * 3.6 // m/s to km/h

        if testInProgress {
            if currentSpeed > 1.0 && startTime == nil {
                startTime = Date()
            }

            if let start = startTime {
                elapsedTime = Date().timeIntervalSince(start)

                if currentSpeed >= 100 {
                    testInProgress = false
                }
            }
        }
    }
}