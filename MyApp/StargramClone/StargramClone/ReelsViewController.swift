//
//  ReelsViewController.swift
//  StargramClone
//
//  Created by 이승진 on 2023/10/27.
//

import UIKit

class ReelsViewController: UIViewController {

    //MARK: -Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var nowPage = 0
    
    private let videoURLStrArr = ["video01", "video02", "dummyVideo01", "dummyVideo02"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupcollectionView()
        
    }
    
    //MARK: -Actions
    
    //MARK: -Helpers
    private func setupcollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.decelerationRate = .fast // 스크롤이 빨리 되도록
        collectionView.register(
            ReelsCell.self,
            forCellWithReuseIdentifier: ReelsCell.identifier)
        
        startLoop()
    }
    
    private func startLoop() {
        let _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            self.moveNextPage()
        }
    }
    
    private func moveNextPage() {
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        nowPage += 1
        if (nowPage >= itemCount) {
            // 마지막 페이지
            nowPage = 0
        }
        
        collectionView.scrollToItem(
            at: IndexPath(item: nowPage, section: 0),
            at: .centeredVertically,
            animated: true)
    }
}

//MARK: -UICollectionViewDelegate, UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReelsCell.identifier,
            for: indexPath) as? ReelsCell else { return UICollectionViewCell() }
        cell.setupURL(videoURLStrArr.randomElement()!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ReelsCell {
            cell.videoView?.cleanUP()
        }
    }
}

//MARK: -UICollectionViewDelegateFlowLayout
extension ReelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        1
    }
}
