//
//  MovieViewModel.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 3/20/25.
//

import Foundation
import SwiftUI

@Observable
class MovieViewModel {
    
    var currentIndex: Int = 0
    
    let movieModel: [MovieModel] = [
        .init(movieImage: .init(.movie01), movieName: "미키", movieLike: 972, movieReserCount: 30.8),
        .init(movieImage: .init(.movie02), movieName: "콘클라베", movieLike: 999, movieReserCount: 99.8),
        .init(movieImage: .init(.movie03), movieName: "브루탈리스트", movieLike: 302, movieReserCount: 24.8),
        .init(movieImage: .init(.movie04), movieName: "백설공주", movieLike: 302, movieReserCount: 3.8),
        .init(movieImage: .init(.movie05), movieName: "위플래시", movieLike: 604, movieReserCount: 62.2),
        .init(movieImage: .init(.movie06), movieName: "토이스토리", movieLike: 392, movieReserCount: 43.9),
        .init(movieImage: .init(.movie07), movieName: "더폴", movieLike: 30, movieReserCount: 2.1)
    ]
    
    /// 이전 영화로 돌아가기, 첫 번째 영화일 경우 마지막 영화로 전환
    public func previousMovie() {
        currentIndex = (currentIndex - 1 + movieModel.count) % movieModel.count
    }
    
    /// 오른쪽 버튼을 눌렀을 때 다음 영화로 이동하는 함수
    public func nextMovie() {
        currentIndex = (currentIndex + 1) % movieModel.count
    }
}
