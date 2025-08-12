//
//  CoffeeDetailView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

/// 커피 상세 정보를 보여주는 뷰
struct CoffeeDetailView: View {
    
    // MARK: - Property
    
    /// DI Container
    @EnvironmentObject var container: DIContainer
    
    /// 커피 상세 정보를 관리하는 뷰모델
    @State var viewModel: CoffeeDetailViewModel
    
    
    // MARK: - init
    
    init(coffeeId: UUID) {
        self.viewModel = .init(coffeeId: coffeeId)
    }
    
    
    // MARK: - Body
    
    var body: some View {
        VStack(spacing: 20) {
            topContents
            centerContents
            Spacer()
            bottomContents
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    container.navigationRouter.pop()
                } label: {
                    Image(.back)
                }
            }
            // 공유 버튼
            ToolbarItem(placement: .topBarTrailing) {
                Image(.share)
            }
        }
        .background(.white)
    }
    
    /// 상단 커피 이미지 영역
    @ViewBuilder
    private var topContents: some View {
        if let image = viewModel.selectedVariant?.image {
            Image(image)
                .resizable()
                .frame(maxWidth: .infinity)
                .aspectRatio(contentMode: .fit)
        }
    }
    
    /// 타이틀 + 설명 + 가격 + 토글버튼 뷰
    private var centerContents: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                coffeeNameGroup
                coffeeDescription
            }
        }
        .safeAreaPadding(.horizontal, 10)
    }
    
    /// 커피 이름 그룹
    private var coffeeNameGroup: some View {
        VStack {
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                // 커피 한글 이름
                Text(viewModel.currentName)
                    .font(.mainTextSemiBold24)
                    .foregroundStyle(.black03)
                
                // new 뱃지
                Image(.new)
            }
            
            // 커피 영어 이름
            Text(viewModel.currentSubName)
                .font(.mainTextSemiBold14)
                .foregroundStyle(.gray01)
        }
    }
    
    /// 커피 상세 정보
    private var coffeeDescription: some View {
        VStack(alignment: .leading, spacing: 20) {
            // 커피 설명
            if let description = viewModel.selectedVariant?.description {
                Text(description.customLineBreak())
                    .font(.mainTextSemiBold14)
                    .foregroundStyle(.gray06)
            }
            
            // 가격
            Text("\(viewModel.coffee.price)원")
                .font(.mainTextSemiBold24)
                .foregroundStyle(.black03)
        }
    }
    
    /// 온도 선택 토글 or 고정 텍스트 뷰
    @ViewBuilder
    private var coffeeTemperatureToggle: some View {
        if viewModel.coffee.availableTemperatures.count == 2 {
            TemperatureToggleView(
                selected: $viewModel.selectedTemperature,
                available: viewModel.coffee.availableTemperatures
            )
        } else {
            temperatureOnlyView
        }
    }
    
    /// 온도 고정 라벨 뷰
    private var temperatureOnlyView: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 999)
                .fill(.clear)
                .stroke(.gray00)
                .frame(maxWidth: .infinity)
                .frame(height: 36)
            
            Text(viewModel.coffee.temperatureLabel)
                .font(.mainTextSemiBold16)
                .foregroundStyle(
                    viewModel.coffee.temperatureLabel
                        .contains("HOT") ? .red01 : .blue01
                )
        }
    }
    
    /// 하단 컨텐츠
    private var bottomContents: some View {
        VStack {
            Rectangle()
                .fill(.gray00.opacity(0.3))
                .frame(height: 1)
                .shadow(color: .black.opacity(0.04), radius: 3.5, x: 0, y: -3)
            
            Button {
                print("주문하기 버튼입니다.")
            } label: {
                Text("주문하기")
                    .frame(maxWidth: .infinity)
                    .font(.mainTextMedium16)
                    .foregroundStyle(Color.white)
                    .padding(.top, 12)
                    .padding(.bottom, 15)
                    .background {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.green01)
                        
                    }
            }
            .padding(.horizontal, 20)
        }
    }
}
