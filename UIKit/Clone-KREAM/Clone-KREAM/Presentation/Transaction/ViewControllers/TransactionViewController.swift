//
//  TransactionViewController.swift
//  Clone-KREAM
//
//  Created by 이승진 on 1/9/25.
//

import UIKit
import Then

class TransactionViewController: UIViewController {
    
    let data = TransactionData.transactionData
    
    private lazy var transactionView = TransactionView().then {
        $0.productCollectionView.delegate = self
        $0.productCollectionView.dataSource = self
    }
    
    override func loadView() {
        view = transactionView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        addTapGesture()
        setDefaultSelection()
    }
    
    // MARK: - Function
    
    /// 네비게이션바 세팅
    private func setNavigationBar() {
        let item = UIBarButtonItem(image: UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor.black), style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = item
    }
    
    /// 커스텀한 구매 또는 판매 버튼은 UIButton 타입이 아닌 UIView 타입이기 때문에 Gesture를 추가하여 사용자의 인터랙션을 감지 할 수 있도록 한다
    /// 구매하기 버튼의 액션 추가
    private func addTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        transactionView.purchaseButton.addGestureRecognizer(tapGesture)
    }
    
    /// 하나의 상품에 대해 다른 색상의 상품 셀을 클릭했을 때, 대표 사진 및 설명 텍스트 부분 바뀌도록 설정하는 함수
    /// - Parameter indexPath: 선택한 셀의 인덱스
    private func updateSelectedImage(for indexPath: IndexPath) {
        transactionView.productImageView.image = UIImage(named: data[indexPath.item].imageView)
        transactionView.descriptionLabel.text = data[indexPath.item].nameLabel
    }
    
    /// 구매 뷰에 처음 접근했을 때, 컬렉션의 첫번째 셀이 대표 사진으로 선택되어 있으면서, 첫번째 셀의 값이 다른 UIComponents의 값으로 사용되도록 지정
    private func setDefaultSelection() {
        let firstIndexPath = IndexPath(item: 0, section: 0)
        updateSelectedImage(for: firstIndexPath)
    }
    
    // MARK: - Action
    
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc
    private func buttonTapped() {
        let newVC = SelectSizeViewController()
        newVC.receiveData = ReceiveTransactionData(
            image: transactionView.productImageView.image ?? UIImage(),
            productName: transactionView.nameLabel.text ?? "전달 못함",
            productDescription: transactionView.descriptionLabel.text ?? "전달 못함"
        )
        
        let navigationController = UINavigationController(rootViewController: newVC)
        navigationController.modalPresentationStyle = .pageSheet
        present(navigationController, animated: true, completion: nil)
    }
}

extension TransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransactionCell.identifier, for: indexPath) as? TransactionCell
        else { return UICollectionViewCell() }
        cell.configure(model: data[indexPath.row])
        return cell
    }
    
    /// 컬렉션 뷰 섹션 내부 여백 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
    }
    
    /// 컬렉션 뷰의 아이템(하나의 셀)을 클릭했을 때, 처리되어야 하는 것 지정
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelectedImage(for: indexPath)
    }
}
