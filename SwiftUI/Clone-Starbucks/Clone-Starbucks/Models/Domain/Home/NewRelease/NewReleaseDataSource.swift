//
//  NewReleaseDataSource.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 8/5/25.
//

import Foundation

/// What's New 더미 데이터
struct NewReleaseDataSource {
    static let newReleaseItem: [NewReleaseItem] = [
        .init(
            image: .ad01,
            name: "25년 3월 일회용컵 없는 날 캠페..",
            description: "매월 10일은 일회용컵 없는 날! 스타벅스 에모매장에서 개인컵 및 다회용 컵을 이용하세요."
        ),
        .init(
            image: .ad02,
            name: "스타벅스 ooo점을 찾습니다",
            description: "스타벅스 커뮤니티 스토어 파트너를 웅영할 기관을 공모합니다."
        ),
        .init(
            image: .ad03,
            name: "2월 8일, 리저브 스프링 신규 커...",
            description: "산뜻하고 달콤한 풍미가 가득한 리저브를 맛보세요."
        )
    ]
}
