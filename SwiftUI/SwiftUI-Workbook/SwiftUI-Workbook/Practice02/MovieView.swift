//
//  MovieView.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 3/20/25.
//

import SwiftUI
import Observation

struct MovieView: View {
    @AppStorage("movieName") private var movieName: String = ""
    private var viewModel: MovieViewModel = .init()
    
    var body: some View {
        VStack {
            MovieCard(movieInfo: viewModel.movieModel[viewModel.currentIndex])
            
            Spacer()
            
            changeButtonGroup
            
            Spacer()
            
            setButton
            
            Spacer()
            
            savedMovieText
            
            Button {
            
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .stroke(.black, style: .init(lineWidth: 1))
                        
                    Text("대표 영화로 설정")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundStyle(.black)
                        
                }
            }
        }
        .frame(width: 379, height: 594)
        
        
    }
    
    /// 영화 바꾸기 버튼 그룹
    private var changeButtonGroup: some View {
        HStack {
            makeButton(name: "chevron.left", action: viewModel.previousMovie)
            
            Spacer()
            
            Text("영화 바꾸기")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black)
            
            Spacer()
            
            makeButton(name: "chevron.right", action: viewModel.previousMovie)

        }
        .frame(width: 256, height: 64)
        .padding(.vertical, 17)
        .padding(.horizontal, 22)
    }
    
    /// 화살표 버튼 재사용 함수
    /// - Parameters:
    ///     - name: 이미지 이름 설정
    ///     - action: 버튼이 가지는 액션 기능
    /// - Returns: some View 타입 반환
    private func makeButton(name: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: name)
                .resizable()
                .frame(width: 17.47, height: 29.73)
                .foregroundStyle(.black)
        }
    }
    
    /// 대표 영화로 설정하기
    private var setButton: some View {
        Button {
            /// 현재 영화 이름 AppStoragedp 저장
            self.movieName = viewModel.movieModel[viewModel.currentIndex].movieName
        } label: {
            Text("대표 영화로 설정")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.black)
                .padding(.top, 21)
                .padding(.bottom, 20)
                .padding(.leading, 53)
                .padding(.trailing, 52)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .stroke(.black, style: .init(lineWidth: 1))
                }
        }
    }
    
    /// @AppStorage에 저장된 영화
    private var savedMovieText: some View {
        VStack(spacing: 17) {
            Text("@AppStorage에 저장된 영화")
                .font(.system(size: 30, weight: .regular))
                .foregroundStyle(.black)
            
            Text("현재 저장된 영화: \(movieName)")
                .font(.system(size: 20, weight: .regular))
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    MovieView()
}
