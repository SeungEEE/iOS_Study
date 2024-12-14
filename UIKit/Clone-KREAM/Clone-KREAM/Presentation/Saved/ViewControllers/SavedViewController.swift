//
//  SavedViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 12/11/24.
//

import UIKit
import Then

class SavedViewController: UIViewController {
    
    let data = SavedModelData.dataList
    
    private lazy var savedView = SavedView(frame: .zero, count: data.count).then {
        $0.tableView.dataSource = self
        $0.tableView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = savedView
    }
}

extension SavedViewController : UITableViewDataSource, UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SavedCell.identifier, for: indexPath) as? SavedCell else {
            return UITableViewCell()
        }
        cell.configure(model: data[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 99
    }
}
