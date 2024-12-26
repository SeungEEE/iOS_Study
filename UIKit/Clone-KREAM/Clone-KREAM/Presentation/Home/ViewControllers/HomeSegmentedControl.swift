//
//  HomeSegmentedControl.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/18/24.
//

import UIKit

class HomeSegmentedControl: UISegmentedControl {

    let selectedView = UIView()
    
    // MARK: - init
    init(items: [String]) {
        super.init(items: items)
        configure()
        selectedIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateIndicatorPosition(animated: true)
    }
    
    // MARK: - Function
    /// 컨트롤 커스텀
    private func configure() {
        backgroundColor = .clear
        selectedSegmentTintColor = .clear
        
        // 경계선 및 배경 제거
        let clearImage = UIImage()
        setBackgroundImage(clearImage, for: .normal, barMetrics: .default)
        setBackgroundImage(clearImage, for: .selected, barMetrics: .default)
        setDividerImage(clearImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        // 세그먼트 선택되었을 때 폰트 값
        let selectedFont = makeAttributes(color: .black, weight: .bold)
        
        // 세그먼트 선택되지 않았을 때 폰트 값
        let normalFont = makeAttributes(color: .darkGray, weight: .regular)
        
        
        // 세그먼트 선택되었을 때 폰트 설정
        setTitleTextAttributes(selectedFont, for: .selected)
        
        // 세그먼트 기본 상태 폰트 설정
        setTitleTextAttributes(normalFont, for: .normal)
        
        // 세그먼트 버튼 클릭 시 변화
        addTarget(self, action: #selector(segmentChange), for: .valueChanged)
    }
    
    // 세그먼트 글자 커스텀
    private func makeAttributes(color: UIColor, weight: UIFont.Weight) ->[NSAttributedString.Key: Any] {
        var value = [NSAttributedString.Key: Any]()
        value[.foregroundColor] = color
        value[.font] = UIFont.systemFont(ofSize: 16, weight: weight)
        return value
    }
}

// MARK: - SegmentExtension
extension HomeSegmentedControl {
    // MARK: - IndicatorFunction
    
    // 세그먼트 막대 추가
    private func selectedIndicator() {
        selectedView.backgroundColor = .black
        selectedSegmentIndex = 0
        addSubview(selectedView)
        
        updateIndicatorPosition(animated: false)
    }
    
    // 세그먼트 막대 포지션 이동 설정
    private func updateIndicatorPosition(animated: Bool) {
        let segmentWidth = bounds.width / CGFloat(numberOfSegments)
        
        // 세그먼트 인디케이터와 텍스트 중간 정렬을 위한 여백 값
        let leftOffset: CGFloat = 1
        
        // 선택된 세그먼트의 텍스트 길이에 맞춰 막대의 가로 길이 설정
        let indicatorWidth = calculateLabelWidth(for: selectedSegmentIndex)
        
        let indicatorPositionX = segmentWidth * CGFloat(selectedSegmentIndex) + (segmentWidth - indicatorWidth) / 2 - leftOffset
        let indicatorFrame = CGRect(x: indicatorPositionX, y: bounds.height - 3, width: indicatorWidth, height: 2)
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.selectedView.frame = indicatorFrame
            })
        } else {
            self.selectedView.frame = indicatorFrame
        }
    }
    
    /// 각 세그먼트 버튼 위치의 텍스트 사이즈 계산
    private func calculateLabelWidth(for index: Int) -> CGFloat {
        guard let title = titleForSegment(at: index) else { return 0 }
        let attributes: [NSAttributedString.Key : Any] = [.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
        let textSize = (title as NSString).size(withAttributes: attributes)
        return textSize.width
    }
    
    @objc
    private func segmentChange() {
        updateIndicatorPosition(animated: true)
    }
}
