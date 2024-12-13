//
//  MyView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit
import Then
import SnapKit

class MyView: UIView {
    
    // MARK: - UI Components
    public lazy var myTopView = MyTopView().then {
        $0.backgroundColor = .white
    }
    
    public lazy var myBottomView = UIView().then {
        $0.backgroundColor = .white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        backgroundColor = .lightGray
        [myTopView, myBottomView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        myTopView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
        
        myBottomView.snp.makeConstraints {
            $0.top.equalTo(myTopView.snp.bottom).offset(24)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }    
}
