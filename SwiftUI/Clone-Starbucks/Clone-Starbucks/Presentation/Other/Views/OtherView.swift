//
//  OtherView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct OtherView: View {
    @AppStorage("nickname") private var nickname: String = "(작성한 닉네임)"
    
    var body: some View {
        NavigationStack {
            VStack {
                OtherHeaderView()
                
                VStack(alignment: .center) {
                    topView
                    
                    Spacer()
                    
                    centerView
                    
                    Divider()
                    
                    Spacer()
                    
                    bottomView
                }
                .background(.white01)
                .safeAreaPadding(EdgeInsets(top: 41, leading: 10, bottom: 41, trailing: 10))
            }
        }
    }
    
    /// 상단 뷰
    private var topView: some View {
        VStack(alignment: .center, spacing: 24) {
            Text("")
            + Text(nickname)
                .foregroundColor(.green01)
                .fontWeight(.bold)
            + Text("님 \n환영합니다!🙌🏻")
            
            HStack(spacing: 10.5) {
                
                NavigationLink(destination: ReceiptView()) {
                    ReusableButton(image: .starIcon, name: "별 히스토리")
                }
            
                NavigationLink(destination: ReceiptView()) {
                    ReusableButton(image: .receiptIcon, name: "전자 영수증")
                }
                
                NavigationLink(destination: ReceiptView()) {
                    ReusableButton(image: .myIcon, name: "나만의 메뉴")
                }
            }
        }
        .multilineTextAlignment(.center)
    }
    
    /// 가운데 뷰 - Pay
    private var centerView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Pay")
                .font(.mainTextSemiBold18)
            VStack {
                HStack {
                    makeButton(image: .registerCard, name: "스타벅스 카드 등록") {
                        print("스타벅스 카드 등록")
                    }
                    
                    Spacer()
                    
                    makeButton(image: .plusCard, name: "카드 교환권 등록") {
                        print("카드 교환권 등록")
                    }
                }
                .padding(.vertical, 16)
                
                HStack {
                    makeButton(image: .coupon, name: "쿠폰 등록") {
                        print("쿠폰 등록")
                    }
                    
                    Spacer()
                    
                    makeButton(image: .couponHistory, name: "쿠폰 히스토리") {
                        print("쿠폰 히스토리")
                    }
                    
                }
                .padding(.vertical, 16)
            }
        }
    }
    
    /// 하단 뷰 - 고객지원
    private var bottomView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("고객지원")
                .font(.mainTextSemiBold18)
            VStack(alignment: .leading) {
                HStack {
                    makeButton(image: .storeCare, name: "스토어 케어") {
                        print("스토어 케어")
                    }
                    
                    Spacer()
                    
                    makeButton(image: .sound, name: "고객의 소리") {
                        print("고객의 소리")
                    }
                }
                .padding(.vertical, 16)
                
                HStack {
                    makeButton(image: .marketInfo, name: "매장 정보") {
                        print("매장 정보")
                    }
                    
                    Spacer()
                    
                    makeButton(image: .returnInfo, name: "반납기 정보") {
                        print("반납기 정보")
                    }
                    
                }
                .padding(.vertical, 16)
                
                HStack {
                    makeButton(image: .myReview, name: "마이 스타벅스 리뷰") {
                        print("마이 스타벅스 리뷰")
                    }
                    Spacer()
                }
                .padding(.vertical, 16)
            }            
        }
    }
    
    /// centerView와 bottomView에 쓰이는 버튼
    private func makeButton(image: UIImage, name: String, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack(spacing: 4) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .foregroundStyle(.gray06)
                Text(name)
                    .font(.mainTextSemiBold16)
                    .foregroundStyle(.black)
                Spacer()
            }
        }
        .frame(maxWidth: 160)
    }
}

//#Preview {
//    OtherView()
//}

struct OtherView_Preview: PreviewProvider {
    static var devices = ["iPhone 11", "iPhone 16 Pro Max"]
    static var previews: some View {
        ForEach(devices, id: \.self) { device in
            OtherView()
                .previewDevice(PreviewDevice(rawValue: device))
                .previewDisplayName(device)
        }
    }
}
