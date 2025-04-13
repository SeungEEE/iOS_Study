//
//  ReceiptsView.swift
//  SwiftUI-Workbook
//
//  Created by 이승진 on 4/12/25.
//

import SwiftUI
import Observation

struct ReceiptsView: View {
    @Bindable var viewModel: ReceiptsViewModel = .init()
    
    var body: some View {
        VStack(spacing: 42) {
            HStack {
                ForEach(ReceiptsSegement.allCases, id: \.id) { segment in
                    topSegment(segment: segment)
                }
            }
            
            tabView
        }
        .frame(maxWidth: 337, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func topSegment(segment: ReceiptsSegement) -> some View {
        VStack(spacing: 0) {
            Text(segment.title)
                .foregroundStyle(.black)
                .font(.system(size: 40))
                .onTapGesture {
                    viewModel.selectedSegment = segment
                }
            if viewModel.selectedSegment == segment {
                Rectangle()
                    .fill(.black)
                    .frame(width: 116, height: 2)
            }
        }
        .frame(maxWidth: .infinity)
        
        if segment == .first {
            Spacer()
        }
    }
    
    private var tabView: some View {
        TabView(selection: $viewModel.selectedSegment) {
            ForEach(ReceiptsSegement.allCases, id: \.id) { segment in
                VStack(spacing: 10) {
                    Image(segment.imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 490)
                    
                    if viewModel.selectedSegment == segment {
                        if let receipt = viewModel.currentReceipt {
                            ReceiptsInfoView(receipt: receipt)
                        } else  {
                            ProgressView("OCR 처리 중...")
                        }
                    }
                }
                .tag(segment)
                
                /// 세그먼트 탭 화면이 등장할 때 OCR 추출되어야 하기 때문에 task로 작성
                .task {
                    viewModel.startOCR(segment)
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

#Preview {
    ReceiptsView()
}
