//
//  ViewController.swift
//  TableViewCode
//
//  Created by 이승진 on 2024/01/04.
//

import UIKit

final class ViewController: UIViewController {
    
    private let tableView = UITableView()
    
    // 테이블뷰의 데이터를 표시하기 위한 배열
    var moviesArray: [Movie] = []
    
    // MVC 패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var movieDataManager = DataManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNaviBar()
        setupTableView()
        setupDatas()
        setupTableViewConstraints()
    }
    
    func setupNaviBar() {
        title = "영화목록"
        
        // (네비게이션바 설정 관련) iOS버전 업데이트 되면서 바뀐 설정
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground() // 불투명
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setupTableView() {
        // 델리게이트 패턴 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 120
        
        // 셀의 등록 과정(스토리보드 사용시에는 스토리보드에서 자동 등록)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MovieCell")
    }
    
    func setupDatas() {
        movieDataManager.makeMovieData() // 일반적으로는 서버에 요청
        moviesArray = movieDataManager.getMovieData() // 데이터 받아서 뷰컨의 배열에 저장
    }
    
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return moviesArray.count
    }
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        // (힙에 올라간) 재사용 가능한 셀을 꺼내서 사용하는 메서드
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MyTableViewCell
        
        cell.mainImageView.image = moviesArray[indexPath.row].movieImage
        cell.movieNameLabel.text = moviesArray[indexPath.row].movieName
        cell.descriptionLabel.text = moviesArray[indexPath.row].movieDescription
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    // 셀이 선택되었을 때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음 화면으로 이동
        let detailVC = DetailViewController()
        detailVC.movieData = moviesArray[indexPath.row]
        show(detailVC, sender: nil)
    }
}

