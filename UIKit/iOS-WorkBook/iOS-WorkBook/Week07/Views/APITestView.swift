//
//  APITestView.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 1/17/25.
//

import UIKit
import Then
import SnapKit

final class APITestView: UIView {
    
    // MARK: - UI Component
    private lazy var placeholderContainer: [NSAttributedString.Key : Any] = {
        var value = [NSAttributedString.Key : Any]()
        value[.foregroundColor] = UIColor.gray
        value[.font] = UIFont.systemFont(ofSize: 12)
        return value
    }()
    
    public lazy var searchTextField = UITextField().then {
        $0.attributedPlaceholder = NSAttributedString(string: "검색하고 싶은 것을 넣으세요!", attributes: placeholderContainer)
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 1))
        $0.textColor = .black
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.layer.borderColor = UIColor.black.cgColor
    }
    
    public lazy var searchButton = UIButton().then {
        $0.setTitle("검색", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .regular)
        $0.backgroundColor = .lightGray
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    private lazy var title: UILabel = makeTitleLabel("타이틀", font: UIFont.systemFont(ofSize: 20, weight: .bold))
    private lazy var contentTitle: UILabel = makeTitleLabel("컨텐츠", font: UIFont.systemFont(ofSize: 20, weight: .bold))
    
    public lazy var responseTitle: UILabel = makeTitleLabel("이 부분에 title 값이 들어오게 해주세요!", font: UIFont.systemFont(ofSize: 20, weight: .light))

    public lazy var responseContentTitle: UILabel = makeTitleLabel("이 부분에 content 값이 들어오게 해주세요!", font: UIFont.systemFont(ofSize: 20, weight: .light))
    
    /// searchTextField + searchButton
    private lazy var searchStackView: UIStackView = makeStack(axis: .horizontal, spacing: 21)
    
    /// title + responseTitle
    private lazy var titleStackView: UIStackView = makeStack(axis: .vertical, spacing: 14)
    
    /// contentTitle + responseContentTitle
    private lazy var contentStackView: UIStackView = makeStack(axis: .vertical, spacing: 14)
    
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Function
    
    private func makeTitleLabel(_ text: String, font: UIFont) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textAlignment = .center
        label.textColor = UIColor.black
        label.numberOfLines = 0
        return label
    }
    
    private func makeStack(axis: NSLayoutConstraint.Axis, spacing: CGFloat) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.distribution = .fill
        return stack
    }
    
    private func setup() {
        /// 스택뷰
        [searchTextField, searchButton].forEach { searchStackView.addArrangedSubview($0) }
        [title, responseTitle].forEach { titleStackView.addArrangedSubview($0) }
        [contentTitle, responseContentTitle].forEach { contentStackView.addArrangedSubview($0) }
        
        /// 컴포넌트
        [searchStackView, titleStackView, contentStackView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        searchStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(94)
            $0.leading.equalToSuperview().offset(26)
            $0.trailing.equalToSuperview().offset(-26)
            $0.height.equalTo(43)
        }
        
        searchTextField.snp.makeConstraints {
            $0.width.equalTo(262)
        }
        
        titleStackView.snp.makeConstraints {
            $0.top.equalTo(searchStackView.snp.bottom).offset(91)
            $0.leading.equalToSuperview().offset(18.5)
            $0.trailing.equalToSuperview().offset(-18.5)
            $0.height.lessThanOrEqualTo(110)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(titleStackView.snp.bottom).offset(91)
            $0.leading.equalToSuperview().offset(18.5)
            $0.trailing.equalToSuperview().offset(-18.5)
            $0.height.greaterThanOrEqualTo(10)
        }
    }
}
