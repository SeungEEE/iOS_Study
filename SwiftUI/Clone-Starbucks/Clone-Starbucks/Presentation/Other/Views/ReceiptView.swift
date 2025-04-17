//
//  ReceiptView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/15/25.
//

import SwiftUI
import PhotosUI

struct ReceiptView: View {
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var showCamera = false
    @State private var showActionSheet = false
    @State private var showPhotoPicker = false
    
    private var viewModel: ReceiptsViewModel = .init()
    
    var body: some View {
        VStack {
            CustomNavigationBar(
                title: "전자영수증",
                rightButtonImage: Image(systemName: "plus")) {
                    showActionSheet = true
                }
            
            ZStack {
                Color.white01
                VStack(spacing: 24) {
                    
                    titleView
                    
                    ForEach(viewModel.receipts, id: \.id) { receipt in
                        ReceiptInfoView(receipt: receipt)
                    }
                    
                    Spacer()
                }
                .safeAreaPadding(EdgeInsets(top: 16, leading: 19, bottom: 0, trailing: 19))
            }
        }
        .navigationBarBackButtonHidden(true)
        .confirmationDialog("사진을 어떻게 추가할까요?", isPresented: $showActionSheet, titleVisibility: .visible) {
            Button("앨범에서 가져오기") {
                showPhotoPicker = true
            }
            
            Button("카메라로 촬영하기") {
                showCamera = true
            }
            
            Button("취소", role: .cancel) {}
         }
        .sheet(isPresented: $showCamera) {
            CameraPicker { image in
                viewModel.addImage(image)
            }
        }
        .photosPicker(isPresented: $showPhotoPicker, selection: $selectedItems, maxSelectionCount: 5, matching: .images)
        .onChange(of: selectedItems) { oldValue, newItems in
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        viewModel.addImage(image)
                    }
                }
            }
        }
    }
    
    private var titleView: some View {
        HStack {
            HStack {
                Text("총 ")
                    .font(.pretend(type: .regular, size: 18))
                    .foregroundStyle(.black)
                + Text("\(viewModel.receipts.count)건")
                    .font(.pretend(type: .semiBold, size: 18))
                    .foregroundStyle(.brown01)
            }
            
            Spacer()
            
            HStack {
                Text("사용합계 ")
                    .font(.pretend(type: .regular, size: 18))
                    .foregroundStyle(.black)
                + Text("\(viewModel.receipts.map { $0.totalAmount }.reduce(0, +))원")
                    .font(.pretend(type: .semiBold, size: 18))
                    .foregroundStyle(.brown01)
            }
        }
    }
}

#Preview {
    ReceiptView()
}
