//
//  RainbowView.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 12/28/24.
//

import UIKit
import Then
import SnapKit

class RainbowView: UIView {
    
    // MARK: - UI Component
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = true
    }
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setColorView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func setColorView() {
        var previousView: UIView? = nil
        
        for color in RainbowColors.colors {
            let colorView = UIView()
            colorView.backgroundColor = color
            scrollView.addSubview(colorView)
            
            colorView.snp.makeConstraints {
                $0.left.right.equalToSuperview() // 좌우로 스크롤 없이 화면 크기에 맞춤
                $0.width.equalTo(self.snp.width) // 피그마 디자인
                $0.height.equalTo(176) // 피그마 디자인 높이
                
                if let previousView = previousView {
                    $0.top.equalTo(previousView.snp.bottom) // 이전 뷰의 하단에 배치
                } else {
                    $0.top.equalToSuperview() // 첫 번째 뷰는 스크롤뷰 상단에 맞춤
                }
            }
            
            previousView = colorView
        }
        
        // 마지막 뷰의 하단을 스크롤뷰의 하단에 맞춤으로써 스크롤 가능하게 설정
        if let lastView = previousView {
            lastView.snp.makeConstraints {
                $0.bottom.equalToSuperview()
            }
        }
    }
}
