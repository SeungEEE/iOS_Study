//
//  SelectSizeViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/10/25.
//

import UIKit
import Then

struct ReceiveTransactionData {
    let image: UIImage
    let productName: String
    let productDescription: String
}

class SelectSizeViewController: UIViewController {
    
    // MARK: - Property
    let data = SizeData.sizeData
    var receiveData: ReceiveTransactionData?
    
    private lazy var selectSizeView = SelectSizeView().then {
        $0.collectionView.delegate = self
        $0.collectionView.dataSource = self
    }
    
    // MARK: - init
    
    override func loadView() {
        view = selectSizeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changValue()
        setNavigationBar()
    }
    
    // MARK: - Function
    
    private func changValue() {
        if let data = receiveData {
            selectSizeView.changeValue(data: data)
        }
    }
    
    private func setNavigationBar()  {
        navigationItem.titleView = CustomNavigationTitle(frame: .zero, titleText: "구매하기", subTitleText: "(가격 단위:원)")
        let closeButton = UIBarButtonItem(
            image: UIImage(systemName: "xmark"),
            style: .plain,
            target: self,
            action: #selector(closeButtonTapped)
        )
        
        closeButton.tintColor = .black
        navigationItem.rightBarButtonItem = closeButton
    }
    
    // MARK: - Action
    @objc
    private func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension SelectSizeViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SizeCell.identifier, for: indexPath) as? SizeCell else { return UICollectionViewCell() }
        cell.configure(model: data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 47)
    }
    
    /// 셀 내부 여백 처리
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    /// 셀 아이템 선택 시 처리
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SizeCell {
            cell.changeOption(isSelected: true)
        }
    }
    /// 셀 아이템 선택 해제 시 처리
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SizeCell {
            cell.changeOption(isSelected: false)
        }
    }
}
