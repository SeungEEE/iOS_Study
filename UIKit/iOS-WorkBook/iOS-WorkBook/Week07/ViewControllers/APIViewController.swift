//
//  APIViewController.swift
//  iOS-WorkBook
//
//  Created by 이승진 on 1/17/25.
//

import UIKit
import Then

class APIViewController: UIViewController {
    
    private lazy var testView = APITestView().then {
        $0.searchButton.addTarget(self, action: #selector(searchText), for: .touchUpInside)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view = testView
    }
    
    // MARK: - Function

    private func search(query: String) {
        let url = "https://dapi.kakao.com/v2/search/web"
        let parameters: [String: Any] = ["query": query]
        
        APIClient.shared.request(url, method: .get, parameters: parameters) { (result: Result<SearchModel, Error>) in
            switch result {
            case .success(let response):
                self.updateView(response)
            case .failure(let error):
                print("네트워킹 오류: \(error)")
            }
        }
    }
    
    private func updateView(_ model: SearchModel) {
        testView.responseTitle.text = model.documents.first?.title
        testView.responseContentTitle.text = model.documents.first?.contents
    }
    
    
    // MARK: - Action

    @objc
    private func searchText() {
        let query = testView.searchTextField.text ?? ""
        search(query: query)
    }

}
