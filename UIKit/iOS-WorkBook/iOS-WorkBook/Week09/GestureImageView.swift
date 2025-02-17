//
//  GestureImageView.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 2/17/25.
//

import UIKit
import Then
import Kingfisher
import SnapKit

class GestureImageView: UIView {
    
    // MARK: - UI Components

    private lazy var imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = true
    }
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    // MARK: - Function
    
    private func setup() {
        addSubview(imageView)
        addGestureRecognizers()
    }
    
    private func addGestureRecognizers() {
        /// 드래그
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        imageView.addGestureRecognizer(panGesture)
        
        /// 회전
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(handleRotationGesture(_:)))
        imageView.addGestureRecognizer(rotationGesture)
        
        /// 확대 / 축소
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture(_:)))
        imageView.addGestureRecognizer(pinchGesture)
    }
    
    public func loadImage(from url: String) {
        if let imageURL = URL(string: url) {
            imageView.kf.setImage(with: imageURL)
        }
    }
    
    private func setConstraints() {
        imageView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.height.width.equalTo(300)
        }
    }
    
    
    // MARK: - Action
    
    @objc
    private func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        if let gestureView = sender.view {
            gestureView.center = CGPoint(x: gestureView.center.x + translation.x, y: gestureView.center.y + translation.y)
        }
        sender.setTranslation(.zero, in: self)
    }
    
    @objc
    private func handleRotationGesture(_ sender: UIRotationGestureRecognizer) {
        if let gestureView = sender.view {
            gestureView.transform = gestureView.transform.rotated(by: sender.rotation)
            sender.rotation = 10
        }
    }
    
    @objc
    private func handlePinchGesture(_ sender: UIPinchGestureRecognizer) {
        if let gestureView = sender.view {
            gestureView.transform = gestureView.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
        }
    }
}
