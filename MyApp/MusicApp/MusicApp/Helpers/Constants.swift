//
//  Constants.swift
//  MusicApp
//
//  Created by 이승진 on 2024/05/11.
//

import UIKit

//MARK: - Name Space 만들기

// 데이터 영역에 저장 (열거형, 구조체 다 가능 / 전역 변수로도 선언 가능)
// 사용하게 될 API 문자열 묶음
public enum MusicApi {
    static let requestUrl = "https://itunes.apple.com/search?"
    static let mediaParam = "media=music"
}

// 사용하게 될 Cell 문자열 묶음
public struct Cell {
    static let musicCellIdentifier = "MusicCell"
    static let musicCollectionViewCellIdentifier = "MusicCollectionViewCell"
    private init() {} // 생성할 수 없게 막아둠 -> 타입 저장 속성에만 접근
}

// 컬랙션뷰 구성을 위한 설정
public struct CVCell {
    static let spacingWidth: CGFloat = 1
    static let cellColums: CGFloat = 3
    private init() {}
}

//let REQUEST_URL = "https://itunes.apple.com/search?"
