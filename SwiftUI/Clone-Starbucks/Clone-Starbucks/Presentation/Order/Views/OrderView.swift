//
//  OrderView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 3/30/25.
//

import SwiftUI

struct OrderView: View {
    @Bindable var viewModel: OrderViewModel = .init()
    @State private var showStoreSelectionSheet = false
    
    var body: some View {
        VStack(spacing: 19) {
            
            HStack {
                Text("Order")
                    .font(.mainTextBold24)
                    .foregroundStyle(.black)
                    .padding(.leading, 16)
                Spacer()
            }
            
            HStack {
                ForEach(OrderSegment.allCases, id: \.id) { segment in
                    topSegment(segment: segment)
                }
            }
            
            menuListView
            
            storeSelectionView
        }
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0))
    }
    
    /// 탭바 밑에 VStack은 배경 위에!! 위치하도록 해야 색 지정이 달라짐
    /// Searchable
    
    @ViewBuilder
    func topSegment(segment: OrderSegment) -> some View {
        VStack {
            Text(segment.title)
                .font(.pretend(type: .bold, size: 16))
                .foregroundStyle(.gray04)
                .onTapGesture {
                    viewModel.selectedSegment = segment
                    withAnimation(.interactiveSpring()) {
                        
                    }
                }
            
            if viewModel.selectedSegment == segment {
                Rectangle()
                    .fill(.green01)
                    .frame(width: 119, height: 3)
            }
        }
        .frame(maxWidth: .infinity)
        
        if segment == .first {
            Spacer()
        }
    }
    
    /// 전체 메뉴 리스트
    private var menuListView: some View {
        ScrollView(.vertical) {
            LazyVStack(alignment: .leading, spacing: 26) {
                ForEach(viewModel.menuList) { menu in
                    OrderListView(orderModel: menu)
                }
            }
            .padding(.top, 19)
            .padding(.horizontal, 23)
        }
    }
    
    /// 주문할 매장 선택 뷰
    private var storeSelectionView: some View {
        VStack(spacing: 10) {
            Button {
                showStoreSelectionSheet = true
            } label: {
                HStack {
                    Text("주문할 매장을 선택해 주세요")
                        .font(.mainTextSemiBold16)
                        .foregroundStyle(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.white)
                }
            }
            .sheet(isPresented: $showStoreSelectionSheet) {
                OrderSheetView()
            }
            
            Rectangle()
                .frame(height: 1)
                .foregroundStyle(.gray06)
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .background(.black02)
    }
}

#Preview {
    OrderView()
}
