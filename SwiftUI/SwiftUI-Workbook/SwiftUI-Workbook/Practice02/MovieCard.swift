//
//  MovieCard.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 3/21/25.
//

import SwiftUI

struct MovieCard: View {
    
    let movieInfo: MovieModel
    
    init(movieInfo: MovieModel) {
        self.movieInfo = movieInfo
    }
    
    var body: some View {
        VStack(spacing: 5) {
            movieInfo.movieImage
            
            Text(movieInfo.movieName)
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(Color.black)
            
            HStack {
                movieLike
                
                Spacer()
                
                Text("예매율 \(String(format: "%.1f", movieInfo.movieReserCount))%")
                    .font(.system(size: 9, weight: .regular))
                    .foregroundStyle(Color.black)
            }
        }
        .frame(width: 120, height: 216)
    }
    
    private var movieLike: some View {
        HStack(spacing: 6) {
            Image(systemName: "heart.fill")
                .foregroundStyle(Color.red)
                .frame(width: 15, height: 14)
            Text("\(movieInfo.movieLike)")
                .font(.system(size: 9, weight: .regular))
                .foregroundStyle(Color.black)
        }
    }
        
}

#Preview {
    MovieCard(movieInfo: .init(movieImage: .init(.movie01), movieName: "미키", movieLike: 972, movieReserCount: 30.8))
}
