//
//  FeedUploadModel.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/20.
//

struct FeedUploadModel: Decodable {
    var isSucess : Bool
    var code : Int
    var message : String
    var result : FeedUploadResult
}

struct FeedUploadResult: Decodable {
    var postIdx : Int?
}
