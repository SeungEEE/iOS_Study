//
//  WeatherData.swift
//  Weather-URLSession
//
//  Created by 이승진 on 3/2/25.
//

import Foundation

struct WeatherData: Codable {
    let name: String // 도시 이름
    let main: Main
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double // 현재 온도
}

struct Weather: Codable {
    let description: String // 날씨 설명
    let icon: String // 아이콘
}
