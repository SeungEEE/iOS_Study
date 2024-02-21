//
//  DetailViewController.swift
//  MemberList
//
//  Created by 이승진 on 2024/01/23.
//

import UIKit
import PhotosUI

final class DetailViewController: UIViewController {
    
    private let detailView = DetailView()
    
    // 서로 가리키지 않기 위해서 약한 참조
    weak var delegate: MemberDelegate?
    
    var member: Member?
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        setupButtonAction()
        setupTapGesture()
    }
    
    private func setupData() {
        detailView.member = member
    }
    
    // 뷰에 있는 버튼의 타겟 설정
    func setupButtonAction() {
        detailView.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    //MARK: - 이미지뷰가 눌렸을 때 동작 설정
    // 제스쳐 설정(이미지뷰가 눌리면, 실행)
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(touchUpImageView))
        detailView.mainImageView.addGestureRecognizer(tapGesture)
        detailView.mainImageView.isUserInteractionEnabled = true
    }
    
    @objc func touchUpImageView() {
        print("이미지뷰 터치")
        
        // 기본 설정 세팅
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0 // 무제한
        configuration.filter = .any(of: [.images, .videos])
        
        // 기본 설정을 가지고, 피커뷰컨트롤러 생성
        let picker = PHPickerViewController(configuration: configuration)
        // 피커뷰 컨트롤러의 대리자 설정
        picker.delegate = self
        // 피커뷰 띄우기
        self.present(picker, animated: true, completion: nil)
    }
    
    @objc func saveButtonTapped() {
        print("버튼 눌림")
        
        // [1] 멤버가 없다면 (새로운 멤버를 추가하는 화면)
        if member == nil {
            // 입력이 안되어 있다면.. (일반적으로) 빈문자열로 저장
            let name = detailView.nameTextField.text ?? ""
            let age = Int(detailView.ageTextField.text ?? "")
            let phoneNumber
            = detailView.phoneNumberTextField.text ?? ""
            let address = detailView.addressTextField.text ?? ""
            
            // 새로운 멤버 (구조체) 생성
            var newMember =
            Member(name: name, age: age, phone: phoneNumber, address: address)
            newMember.memberImage = detailView.mainImageView.image
            
            // 1) 델리게이트 방식이 아닌 구현
//            let index = navigationController!.viewControllers.count - 2
//            // 전 화면애 접근하기 위함
//            let vc = navigationController?.viewControllers[index] as! ViewController
//            // 전 화면이 모델에 접근해서 멤버를 추가
//            vc.memberListManager.makeNewMember(newMember)
            
            // 2) 델리게이트 방식으로 구현
            delegate?.addNewMember(newMember)
            
        // [2] 멤버가 있다면 (멤버의 내용을 업데이트 하기 위한 설정)
        } else {
            // 이미지 뷰에 있는 것을 그대로 다시 멤버에 저장
            member!.memberImage = detailView.mainImageView.image
            
            let memberId = Int(detailView.memberIdTextField.text!) ?? 0
            member!.name = detailView.nameTextField.text ?? ""
            member!.age = Int(detailView.ageTextField.text ?? "") ?? 0
            member!.phone = detailView.phoneNumberTextField.text ?? ""
            member!.address = detailView.addressTextField.text ?? ""
            
            // 뷰에도 바뀐 멤버를 전달 (뷰컨트롤러 -> 뷰)
            detailView.member = member
            
            // 1) 델리게이트 방식이 아닌 구현 (ViewController, DetailViewController 두개가 있으니 -2)
//            let index = navigationController!.viewControllers.count - 2
//            // 전 화면에 접근하기 위함
//            let vc = navigationController?.viewControllers[index] as! ViewController
//            // 전 화면의 모델에 접근해서 멤버를 업데이트
//            vc.memberListManager.updateMemberInfo(index: memberId, member!)
            
            // 델리게이트 방식으로 구현
            delegate?.update(index: memberId, member!)
        }
        
        // (일처리를 다한 후에) 전 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        print("디테일 뷰 컨트롤러 해제")
    }
}

extension DetailViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProvider = results.first?.itemProvider
        
        if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                DispatchQueue.main.async {
                    // 이미지뷰에 표시
                    self.detailView.mainImageView.image = image as? UIImage
                }
            }
        } else {
            print("이미지 불러오지 못함")
        }
    }
}


