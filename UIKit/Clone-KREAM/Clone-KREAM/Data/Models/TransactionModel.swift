//
//  TransactionModel.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/10/25.
//

import Foundation

struct TransactionModel: RequiredCellProtocol {
    var imageView: String
    var nameLabel: String
}

final class TransactionData {
    static let transactionData: [TransactionModel] = [
        .init(imageView: "blackJumper", nameLabel: "마땡킴 로고 코팅 점퍼 블랙"),
        .init(imageView: "blueJumper", nameLabel: "마땡킴 로고 코팅 점퍼 블루"),
        .init(imageView: "purpleJumper", nameLabel: "마땡킴 로고 코팅 점퍼 퍼플"),
        .init(imageView: "greenJumper", nameLabel: "마떙킴 로고 코팅 점퍼 그린"),
        .init(imageView: "brownJumper", nameLabel: "마땡킴 로고 코팅 점퍼 브라운"),
        .init(imageView: "redJumper", nameLabel: "마땡킴 로고 코팅 점퍼 레드"),
        .init(imageView: "yellowJumper", nameLabel: "마땡킴 로고 코팅 점퍼 엘로우")
    ]
}
