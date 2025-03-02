//
//  WeatherManager.swift
//  Weather-URLSession
//
//  Created by 이승진 on 3/2/25.
//

import Foundation
import CoreLocation

class WeatherManager {
    var apiKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "WEATHER_API_KEY") as? String ?? ""
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (WeatherData?) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)&units=metric"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                    DispatchQueue.main.async {
                        completion(weather) // UI 업데이트를 위해 메인 스레드에서 실행
                    }
                } catch {
                    print("JSON Parsing Error: \(error.localizedDescription)")
                    completion(nil)
                }
            } else {
                print("Network Error: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
            }
        }.resume()
    }
}

