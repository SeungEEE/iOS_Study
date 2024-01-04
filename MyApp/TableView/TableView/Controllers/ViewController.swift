//
//  ViewController.swift
//  TableView
//
//  Created by 이승진 on 2024/01/02.
//

import UIKit

class ViewController: UIViewController {
    // 테이블 뷰의 데이터를 표시하기 위한 배열
//    var moviesArray: [Movie] = []
    // MVC 패턴을 위한 데이터 매니저 (배열 관리 - 데이터)
    var movieDataManager = DataManager()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "영화목록"
        
        setupTableView()
        setupDatas()
    }
    
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        movieDataManager.updateMovieData()
        tableView.reloadData()
    }
    
    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 120
    }
    
    func setupDatas() {
        movieDataManager.makeMovieData() // 일반적으로는 서버에 요청
//        moviesArray = movieDataManager.getMovieData() // 데이터 받아서 뷰칸의 배열에 저장
    }
}

extension ViewController: UITableViewDataSource {
    // 1) 데이블뷰에 몇개의 데이터를 표시할 것인지(셀이 몇개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return movieDataManager.getMovieData().count
    }
    // 2) 셀의 구성(셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
    
        // (힙에 올라간) 재사용 가능한 셀을 꺼내서 사용하는 메서드
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        
        let array = movieDataManager.getMovieData()
        let movie = array[indexPath.row]
        
        cell.mainImageView.image = movie.movieImage
        cell.movieNameLabel.text = movie.movieName
        cell.descriptionLabel.text = movie.movieDescription
        cell.selectionStyle = .none
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    // 셀이 선택이 되었을 때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 세그웨이 실행
        performSegue(withIdentifier: "toDetail", sender: indexPath)
    }
    // prepare 세그웨이(데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! DetailViewController
            let array = movieDataManager.getMovieData()
            let indexPath = sender as! IndexPath
            
            // 배열에서 아이템을 꺼내서, 다음 화면으로 =전달
            detailVC.movieData = array[indexPath.row]
        }
    }
}
