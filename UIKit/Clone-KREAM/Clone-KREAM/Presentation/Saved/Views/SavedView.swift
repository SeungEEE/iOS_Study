//
//  SavedView.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/14/24.
//

import UIKit
import Then
import SnapKit

class SavedView: UIView {
    
    // MARK: - Properties
    
    let count: Int
    
    // MARK: - UI Components
    
    /// Saved 라벨
    private let mainLabel = UILabel().then {
        $0.text = "Saved"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 28, weight: .semibold)
    }
    
    /// 물건 전체 개수 라벨
    private lazy var totalLabel = UILabel().then {
        $0.text = "전체 \(count)개"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 14, weight: .regular)
    }
    
    /// TableView
    public lazy var tableView = UITableView().then {
        $0.register(SavedCell.self, forCellReuseIdentifier: SavedCell.identifier)
        $0.separatorStyle = .singleLine
    }
    
    // MARK: - init

    init(frame: CGRect, count: Int) {
        self.count = count
        super.init(frame: frame)
        
        setup()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    private func setup() {
        [mainLabel, totalLabel, tableView].forEach { addSubview($0) }
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(61)
            $0.leading.equalToSuperview().offset(10)
        }
        
        totalLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(13)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(totalLabel.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}
