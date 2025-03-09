//
//  NotificationController.swift
//  WatchLandmarks Watch App
//
//  Created by 이승진 on 3/9/25.
//

import SwiftUI
import WatchKit
import UserNotifications

class NotificationController: WKUserNotificationHostingController<NotificationView> {
    var landmark: Landmark?
    var title: String?
    var message: String?
    
    let landmarkIndexKey = "landmarkIndex"
    
    override var body: NotificationView {
        NotificationView(
            title: title,
            message: message,
            landmark: landmark
        )
    }
    
    /// 컨트롤러 속성 업데이트 함수
    override func didReceive(_ notification: UNNotification) {
        let modelData = ModelData()
        
        let notificationData = notification.request.content.userInfo as? [String : Any]
        
        let aps = notificationData?["aps"] as? [String : Any]
        let alert = aps?["alert"] as? [String : Any]
        
        title = alert?["title"] as? String
        message = alert?["body"] as? String
        
        if let index = notificationData?[landmarkIndexKey] as? Int {
            landmark = modelData.landmarks[index]
        }
    }
}
