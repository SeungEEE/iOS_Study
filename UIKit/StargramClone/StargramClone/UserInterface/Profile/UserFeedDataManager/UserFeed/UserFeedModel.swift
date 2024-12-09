//
//  UserFeedModel.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/26.
//

import Foundation

struct UserFeedModel: Decodable {
    
        let isSuccess: Bool?
        let code: Int?
        let message: String?
        let result: UserFeedModelResult
    
}

struct UserFeedModelResult: Decodable {
    let _isMyFeed: Bool?
    let getUserInfo: GetUserInfo?
    let getUserPosts: [GetUserPost]?
}

struct GetUserInfo: Decodable {
    let userIdx: Int?
    let nickName: String?
    let name: String?
    let profileImgUrl: String?
    let website: String?
    let introduction: String?
    let followerCount: Int?
    let followingCount: Int?
    let postCount: Int?
}

struct GetUserPost: Decodable {
    let postIdx: Int?
    let postImgUrl: String?
}


