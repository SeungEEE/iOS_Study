//
//  ImageHandling.swift
//  Clone-Starbucks
//
//  Created by 이승진 on 4/15/25.
//

import UIKit

protocol ImageHandling: AnyObject {
    func addImage(_ image: UIImage)
    func getImages() -> [UIImage]
    var recognizedText: String { get set }
}
