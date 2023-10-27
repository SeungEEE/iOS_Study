//
//  ProfileViewController.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/16.
//

import UIKit

class ProfileViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK: - Properties
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var userPosts: [GetUserPost]? {
        didSet { self.profileCollectionView.reloadData() }
    }
    
    var deletedIndex: Int?

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        setupData()
    }
    
    //MARK: - Actions
    @objc
    func didLongPressCell(gestureRecognizer: UILongPressGestureRecognizer) { // 오래 눌렸음을 인지하는 함수
        if gestureRecognizer.state != .began { return }
        
        let position = gestureRecognizer.location(in: profileCollectionView)
        
        if let indexPath = profileCollectionView?.indexPathForItem(at: position) {
            print("DEBUG", indexPath.item)
            
            guard let userPosts = self.userPosts else { return }
            let cellData = userPosts[indexPath.item]
            self.deletedIndex = indexPath.item
            if let postInx = cellData.postIdx {
                // 삭제 API 호출
                UserFeedDataManager().deletegetUserFeed(self, postInx)
            }
        }
        
    }
    
    
    //MARK: - Helpers
    private func setupCollectionView() {
        // delegate 연결
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        // Cell 등록
        profileCollectionView.register(
            UINib(nibName: "ProfileCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ProfileCollectionViewCell.identifier)
        profileCollectionView.register(
            UINib(nibName: "PostCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: PostCollectionViewCell.identifier)
        
        let gesture = UILongPressGestureRecognizer(
            target: self, action: #selector(didLongPressCell(gestureRecognizer:)))
        gesture.minimumPressDuration = 0.66
        gesture.delegate = self
        gesture.delaysTouchesBegan = true
        profileCollectionView.addGestureRecognizer(gesture)
    }
    
    private func setupData() {
        UserFeedDataManager().getUserFeed(self)
    }
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    // Section의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // Cell의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        default: // 1
            return userPosts?.count ?? 0
        }
    }
    
    // Cell 생성
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let section = indexPath.section
        switch section {
        case 0: // Profile
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCollectionViewCell.identifier, for: indexPath) as? ProfileCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패...")
            }
            return cell
        default: // Post
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.identifier, for: indexPath) as? PostCollectionViewCell else {
                fatalError("셀 타입 캐스팅 실패...")
            }
            let itemIndex = indexPath.item
            
            if let cellData = self.userPosts {
                // 데이터가 있는 경우, cell에 데이터 전달
                cell.setupData(cellData[itemIndex].postImgUrl) // <- 데이터 전달
            }
            
            return cell
        }
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let section = indexPath.section
        switch section {
        case 0: // Profile
            return CGSize(width: collectionView.frame.width, height: 159)
        default: // Post
            let side = CGFloat((collectionView.frame.width / 3) - (4/3))
            return CGSize(width: side, height: side)
        }
        
    }
    // 행
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
    // 열
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 1
        }
    }
}

// MARK: - API 통신 메소드
extension ProfileViewController {
    func successFeedAPI(_ result: UserFeedModel) {
        self.userPosts = result.result.getUserPosts
    }
    
    func successDeletePostAPI(_ isSuccess: Bool) {
        guard isSuccess else { return }
        
        if let deletedIndex = self.deletedIndex {
            self.userPosts?.remove(at: deletedIndex)
        }
    }
}
