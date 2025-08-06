//
//  NewReleaseView.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/5/25.
//

import SwiftUI

/// What's New 섹션 뷰
struct NewReleaseView: View {
    
    // MARK: - Property
    
    /// 섹션 타이틀
    let title: String
    
    /// 표시할 항목 리스트
    let items: [NewReleaseItem]
    
    // MARK: - init
    init(title: String, items: [NewReleaseItem]) {
        self.title = title
        self.items = items
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            newHeader
            newContents
        }
    }
    
    /// 섹션 헤더 제목
    private var newHeader: some View {
        Text(title)
            .font(.mainTextBold24)
            .foregroundStyle(.black03)
    }
    
    /// 가로 스크롤 가능한 항목 리스트
    private var newContents: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(items, id: \.id) { item in
                    newCard(item)
                }
            }
        }
    }
    
    /// 각 항목 카드 뷰
    private func newCard(_ item: NewReleaseItem) -> some View {
        VStack(alignment:. leading, spacing: 16) {
            Image(item.image)
                .fixedSize()
            cardString(name: item.name, description: item.description)
        }
    }
    
    /// 카드 구성 (이름 + 설명)
    private func cardString(name: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 9) {
            Text(name)
                .font(.mainTextSemiBold18)
                .foregroundStyle(.black02)
            
            Text(description)
                .frame(
                    maxWidth: 250,
                    minHeight: 36,
                    alignment: .leading
                )
                .font(.mainTextSemiBold13)
                .foregroundStyle(.gray03)
                .lineLimit(2)
                .lineSpacing(2)
                .multilineTextAlignment(.leading)
        }
    }
}
