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
    
    private let videoURLStrArr = ["dummyVideo", "dummyVideo02"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupcollectionView()
        
    }
    
    //MARK: -Actions
    
    //MARK: -Helpers
    private func setupcollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            UINib(nibName: "ReelsCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier: ReelsCollectionViewCell.identifier)
    }
}

//MARK: -UICollectionViewDelegate, UICollectionViewDataSource
extension ReelsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ReelsCollectionViewCell.identifier,
            for: indexPath) as? ReelsCollectionViewCell else { fatalError() }
        return cell
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
