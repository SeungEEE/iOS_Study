//
//  SearchResultView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/10/25.
//

import UIKit
import Then
import SnapKit

class SearchResultView: UIView {
    
    // MARK: - UI Components
    
    /// 검색 결과 담는 스택뷰
    private lazy var resultStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 10
        $0.alignment = .fill
    }

    /// 검색 결과 데이터의 양을 알 수 없기 때문에 스크롤뷰로 감싸기
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = true
        $0.showsHorizontalScrollIndicator = false
        $0.bounces = true
    }
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Function
    
    /// 검색 결과로 받아온 데이터를 반복문을 이용하여 스택뷰에 추가
    /// - Parameter results: 검색 결과 데이터 배열값
    func updateResult(_ results: [String]) {
        resultStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for result in results {
            let label = createResultLabel(result)
            resultStackView.addArrangedSubview(label)
        }
    }
    
    /// 검색 결과로 받아온 데이터의 값을 사용하는 Label을 생성하여 스택뷰에 추가
    /// - Parameter text: 검색 결과로 받아온 값
    /// - Returns: 검색 결과를 갖는 라벨
    private func createResultLabel(_ text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        return label
    }
    
    private func setup() {
        backgroundColor = .white
        
        addSubview(scrollView)
        scrollView.addSubview(resultStackView)
    }
    
    private func setConstraints() {
        scrollView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        resultStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.width.equalToSuperview()
        }
    }
}
