//
//  ViewController.swift
//  Weather-URLSession
//
//  Created by 이승진 on 3/2/25.
//

import UIKit
import Then
import SnapKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    let weatherManager = WeatherManager()
    
    lazy var titleLabel = UILabel().then {
        $0.text = "나의 위치"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .medium)
    }
    
    lazy var cityLabel = UILabel().then {
        $0.text = "도시"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 26, weight: .bold)
    }
    
    lazy var temperatureLabel = UILabel().then {
        $0.text = "온도"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 36, weight: .semibold)
    }
    
    lazy var descriptionLabel = UILabel().then {
        $0.text = "설명"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    lazy var weatherIcon = UIImageView().then {
        $0.image = UIImage(systemName: "sun.min")
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLocation()
        setup()
        setConstraints()
    }
    
    func setLocation() {
        locationManager.delegate = self
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            print("위치 서비스가 거부되었습니다. 설정에서 변경하세요.")
        @unknown default:
            break
        }
    }

    func setup() {
        view.backgroundColor = .white
        [titleLabel, cityLabel, temperatureLabel, descriptionLabel, weatherIcon].forEach { view.addSubview($0) }
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            $0.centerX.equalToSuperview()
        }
        
        cityLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        temperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(temperatureLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
        weatherIcon.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-60)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
    }
    
    /// UI 업데이트
    func updateUI(with weather: WeatherData) {
        cityLabel.text = weather.name
        temperatureLabel.text = "\(Int(weather.main.temp))°"
        descriptionLabel.text = weather.weather.first?.description.capitalized
        
        if let getIcon = weather.weather.first?.icon, let iconURL = URL(string: "https://openweathermap.org/img/wn/\(getIcon)@2x.png") {
            URLSession.shared.dataTask(with: iconURL) { data, _, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.weatherIcon.image = image
                    }
                } else {
                    print("Icon Download Error: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    /// 위치 정보를 가져오는 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        if let location = locations.first {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            weatherManager.fetchWeather(latitude: latitude, longitude: longitude) { weather in
                if let weather = weather {
                    DispatchQueue.main.async {
                        self.updateUI(with: weather)
                    }
                }
            }
        }
    }
    
    /// 위치 정보 가져오기 실패 시 에러 메시지 표시
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.cityLabel.text = "위치 가져오기 실패"
            self.temperatureLabel.text = "재시도"
            self.descriptionLabel.text = error.localizedDescription
        }
        print("Location Error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            print("위치 서비스가 거부되었습니다. 설정에서 변경하세요.")
        case .notDetermined:
            print("위치 권한 요청 중...")
        @unknown default:
            break
        }
    }
}
