//
//  CoffeeDetailView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/7/25.
//

import SwiftUI

struct CoffeeDetailView: View {
    let coffee: DetailCoffee
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        Image(uiImage: coffee.coffeeImage)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 355)
                            .background(.clear)
                            .ignoresSafeArea(edges: .top)
                            
                        
                        centerView
                            .background(Color.white)
                    }
                    
                }
                
                bottomView
            }
            
            DetailNavigationBar()
            
        }
        .navigationBarBackButtonHidden(true)
    }
    
    /// 타이틀 + 설명 + 가격 + 토글버튼 뷰
    private var centerView: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 4) {
                Text(coffee.title)
                    .font(.mainTextSemiBold24)
                    .foregroundStyle(.black)
                
                Text(coffee.titleInEnglish)
                    .font(.pretend(type: .semiBold, size: 14))
                    .foregroundColor(.gray01)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 20) {
                Text(coffee.Description)
                    .font(.pretend(type: .semiBold, size: 14))
                    .foregroundColor(.gray06)
                
                Text(coffee.price)
                    .font(.mainTextBold24)
            }
            
            Spacer()
            
            CoffeeStateToggleButton(currentState: coffee.state)
            
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 0)
        .frame(maxWidth: .infinity, minHeight: 256, maxHeight: 256, alignment: .leading)
    }
    
    private var bottomView: some View {
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


#Preview {
    CoffeeDetailView(coffee: .init(coffeeId: 1, coffeeImage: .detailCoffee01, title: "에스프레소 콘 파나", titleInEnglish: "Espresso Con Panna", Description: "신선한 에스프레소 샷에 풍부한 휘핑크림을 얹은 커피 음료로서, 뜨거운 커피의 맛과 차갑고 달콤한 생크림의 맛을 같이 즐길 수 있는 커피 음료", price: "4,100원", state: .hot))
}
