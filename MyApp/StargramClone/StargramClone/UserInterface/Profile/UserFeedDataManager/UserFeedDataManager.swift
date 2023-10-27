//
//  UserFeedDataManager.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/26.
//


import Alamofire

class UserFeedDataManager {
    
    //MARK: - 유저 피드 조회 API
    func getUserFeed(_ viewController: ProfileViewController, _ userID: Int = 2) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/users/\(userID)",
                   method: .get,
                   parameters: nil)
        .validate()
        .responseDecodable(of: UserFeedModel.self) { response in
            
            switch response.result {
            case .success(let result):
                viewController.successFeedAPI(result)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - 게시물 삭제 API
    func deletegetUserFeed(_ viewController: ProfileViewController, _ postIdx: Int = 2) {
        // 통신
        AF.request("https://edu-api-ios-test.softsquared.com/posts/\(postIdx)/status",
                   method: .patch,
                   parameters: nil)
        .validate()
        .responseDecodable(of: DeleteUserFeed.self) { response in
            
            switch response.result {
            case .success(let result):
                viewController.successDeletePostAPI(result.isSuccess ?? false)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
