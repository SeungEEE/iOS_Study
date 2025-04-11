//
//  ImageHandling.swift
//  VisionPractice
//
//  Created by 이승진 on 4/10/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    /// 이미지 추가
    func addImage(_ images: UIImage)
    
    /// 추가된 이미지 가져오기
    func getImages() -> [UIImage]
    
    var recognizedText: String { get set }
}
