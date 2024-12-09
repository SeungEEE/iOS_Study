//
//  ViewController.swift
//  FirstNewApp
//
//  Created by 이승진 on 2023/09/16.
//

import UIKit
import AVFoundation // timer

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    weak var timer: Timer?
    
    var number = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
    }

    @IBAction func sliderChanged(_ sender: UISlider) {
        // 슬라이더의 밸류값을 가지고 메인레이블의 텍스트를 셋팅
        number = Int(slider.value * 60) // 0.0 ~ 1.0 -> 0 ~ 60
        mainLabel.text = "\(number)초"
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // 1초씩 지나갈 때마다 무언가를 실행
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
        
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
//            // 반복을 하고 싶은 코드
//            if number > 0 {
//                number -= 1
//                // 슬라이더도 줄여야함
//                slider.value = Float(number) / Float(60)
//                // 레이블 표시도 다시 해줘야 함
//                mainLabel.text = "\(number)초"
//            } else {
//                number = 0
//                mainLabel.text = "초를 선택하세요"
//                timer?.invalidate() // 타이머 설정 무효화
//                // 알람 울리기
//                AudioServicesPlayAlertSound(SystemSoundID(1322))
//            }
//        }
    }
    
    @objc func doSomethingAfter1Second() {
        // 반복을 하고 싶은 코드
        if number > 0 {
            number -= 1
            // 슬라이더도 줄여야함
            slider.value = Float(number) / Float(60)
            // 레이블 표시도 다시 해줘야 함
            mainLabel.text = "\(number)초"
        } else {
            number = 0
            mainLabel.text = "초를 선택하세요"
            timer?.invalidate() // 타이머 무효화
            // 알람 울리기
            AudioServicesPlayAlertSound(SystemSoundID(1322))
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        // 초기화 셋팅
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
        number = 0
        timer = nil

        // 슬라이더의 가운데 설정
        // slider.setValue(0.5, animated: true)
    }
}

