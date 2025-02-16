//
//  SearchViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 2/10/25.
//

import UIKit
import Then
import SnapKit

class SearchViewController: UIViewController {
    
    // MARK: - Properties
    
    /// 실시간 검색 및 검색 결과 데이터를 받아오는 API Manager
    private let searchAPI = SearchManager()
    
    /// 실시간 검색 데이터 저장 배열
    private var searchResults: [Product] = []
    
    /// 실시간 검색 시, 키보드 타이핑 시간 측정하여 실시간 검색 시간이 이루어지도록 설정
    private var searchTimer: Timer?
    
    /// 최근 검색어 단어 표시 위함, 최근 검색어 단어 저장 및 불러오기 기능
    private var searchModel = SearchModel()
    
    

    // MARK: - UI Components
    
    /// 검색 화면 뷰
    private lazy var searchView = SearchView().then {
        $0.searchBar.delegate = self
    }
    
    /// 검색 결과 화면 뷰
    private lazy var searchResultView = SearchResultView()
    

    // MARK: - Cycle

    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        loadRecentSearches()
        setSearchBarActions()
    }
    
    
    // MARK: - Function
    
    private func setNavigationBar() {
        searchView.searchBar.delegate = self
        navigationItem.titleView = searchView.searchBar
        navigationItem.hidesBackButton = true
        
        let customBackButton = UIBarButtonItem(
            image: UIImage(systemName:"arrow.backward")?
                .withRenderingMode(.alwaysOriginal)
                .withTintColor(.black),
            style: .plain,
            target: self,
            action: #selector(backAction)
        )
        navigationItem.leftBarButtonItem = customBackButton
    }
    
    /// 최근 검색어 단어를 클릭했을 때 일어나는 액션에 대해 정의
    /// 1. 최근 검색어 버튼 클릭시, 검색 필터에 해당 값이 적용돼야함
    /// 2. 해당 검색어 버튼의 검색어로 검색이 바로 진행돼야 함
    private func setSearchBarActions() {
        searchView.onSearchButtonTapped = { [weak self] keyword in
            self?.searchView.searchBar.text = keyword
            self?.performSearch(query: keyword)
        }
    }
    
    // MARK: - Search Methods
    

    /// 검색 수행 함수
    /// - Parameter qurey: 검색 바 필터에 넣은 값
    private func performSearch(query: String) {
        guard !query.isEmpty else { return }
        
        searchAPI.fetchSearchResults(query: query) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let searchResponse):
                self.searchResults = searchResponse.products
                self.updateSearchResults()
                self.changeSearchView()
            case .failure(let error):
                print("Search API error:", error)
                self.showErrorMessage(error)
            }
        }
    }
    
    /// 검색 결과로 받아온 데이터들을 뷰에 반영
    private func updateSearchResults() {
        let productTitles = searchResults.map { $0.title }
        searchResultView.updateResult(productTitles)
    }
    
    /// 검색 진행 시, 최근 검색어가 보이는 뷰가 아닌 검색 결과를 보이는 뷰로 전환
    /// 뷰 컨트롤러 자신의 뷰 자체를 바꿈
    private func changeSearchView() {
        view = searchResultView
    }
    
    /// API로 데이터를 받아오지 못했을 때, 사용자에게 알리기 위한 알림
    /// - Parameter error: API 에러 메시지
    private func showErrorMessage(_ error: Error) {
        let alert = UIAlertController(
            title: "Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    /// 최근 검색 데이터를 불러오고, 최근 검색어를 띄우는 뷰에 적용하여 뷰에 등장시킴
    private func loadRecentSearches() {
        let recentSearches = searchModel.loadRecentSearchWord()
        searchView.updateRecentSearchButton(recentSearches)
    }
    
    /// 검색 필터에 넣은 검색어를 최근 검색어로 저장 후에 뷰에 바로 나타날 수 있도록 등장시킴
    /// - Parameter query: 검색 필터에 넣은 검색어
    private func saveSearchQuery(_ query: String) {
        let updatedSearches = searchModel.saveSearchQuery(query)
        searchView.updateRecentSearchButton(updatedSearches)
    }
    
    /// 실시간 검색 중, 입력 속도를 조정하여 결과를 받아오도록 함
    /// - Parameter query: 검색 데이터 입력중인 데이터
    private func performRealTimeSearch(with query: String) {
        searchTimer?.invalidate()
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
            self?.performSearch(query: query)
        })
    }
    
    
    // MARK: - Action
    
    @objc
    private func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    /// 검색 필터에 값이 있을 경우 / 없을 경우
    /// - Parameters:
    ///     - searchBar: 현재 뷰의 검색바
    ///     - searchText: 검색바가 들고 있는 검색 데이터 값
    /// 검색바에 값이 없으면 최근 검색어를 보이는 뷰로 전환, 검색바에 값이 있으면 실시간 검색 기능으로 간주
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            self.view = searchView
        } else {
            performRealTimeSearch(with: searchText)
        }
    }
    
    /// 키보드에서 엔터를 클릭 시 일어나는 상황 정리
    /// - Parameter searchBar: 현재 뷰의 검색바
    /// 검색 바에서 값을 입력하고 키보드에서 엔터를 클릭 시 API로 값을 받아오고, 최근 검색어로 저장 후에 검색 액션을 종료함
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text, !query.isEmpty else { return }
        performSearch(query: query)
        self.saveSearchQuery(query)
        searchBar.resignFirstResponder()
    }
    
    /// 검색바에서 x버튼 즉, 취소 버튼 클릭시 행동
    /// - Parameter searchBar: 해당 뷰의 검색바
    /// 검색 취소 시 값을 비우고 검색 결과의 데이터 전부 삭제
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchResults.removeAll()
        updateSearchResults()
    }
}
