//
//  WeatherNetwork.swift
//  Weather
//
//  Created by Parth Patel on 2024-07-31.
//

import Foundation
import CoreLocation

class WeatherNetwork: ObservableObject {
    @Published var weatherModel: WeatherModel?
    @Published var errorMessage: String?

    private var baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=\(apikey)"

    func fetchWeather(cityName: String) {
        let urlString = "\(baseURL)&q=\(cityName)"
        performRequest(with: urlString)
    }

    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(baseURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }

    private func performRequest(with urlString: String) {
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received"
                }
                return
            }
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherModel.self, from: data)
                DispatchQueue.main.async {
                    self.weatherModel = weatherData
                    self.errorMessage = nil
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
        }
        task.resume()
    }
}
