//
//  ViewController.swift
//  RPSGame
//
//  Created by 이승진 on 2023/08/30.
//

import UIKit

class ViewController: UIViewController {

    // 변수 / 속성
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var comImageView: UIImageView!
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var comChoiceLabel: UILabel!
    @IBOutlet weak var myChoiceLabel: UILabel!
    
    let viewModel = RPSViewModel(rpsManager: RPSManager())
    
    // 함수 / 메서드
    // 앱의 화면에 들어오면 처음 실행되는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onCompleted = { [unowned self] resultString in
            self.comImageView.image = self.viewModel.computerRPSimage
            self.comChoiceLabel.text = self.viewModel.computerRPStext
            
            self.myImageView.image = self.viewModel.userRPSimage
            self.myChoiceLabel.text = self.viewModel.userRPStext
            
            self.mainLabel.text = resultString
        }
        
        viewModel.reset()
    }
    
    @IBAction func rpsButtonTapped(_ sender: UIButton) {
        viewModel.rpsButtonTapped()
        
        guard let title = sender.currentTitle else { return }
        viewModel.userGetSelected(title: title)
    }
    
    @IBAction func selectButtonTapped(_ sender: UIButton) {
        viewModel.selectButtonTapped()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        viewModel.reset()
    }
}
