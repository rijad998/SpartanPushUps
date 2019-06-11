//
//  ViewController.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 31/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

class MainViewController: UIViewController {
    
    fileprivate let openSetupBtn = UIButton()
    fileprivate let progressBar = ProgressBarView(level: "NOVICE")
    fileprivate let roundNodeSeries = RoundNodeSeries()
    fileprivate let horizontalRule = HorizontalRule()
    fileprivate let horizontalRuleTwo = HorizontalRule()
    fileprivate let mainViewModel = MainViewModel()
    fileprivate let roundProgressView = UIView()
    fileprivate let roundBgImg = UIImage.loadImageData("bg-circle.png")?.cgImage
    fileprivate let roundBgImgView = UIImageView()
    fileprivate let audioPlayer = AudioPlayer()
    fileprivate let lbl = UILabel()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        view.layer.contents = UIImage.loadImageData("bg.png")?.cgImage
        
        controlSuperView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        layout()
    }
    
    func layout(){
        
        progressBar.onSide(.top, statusBarHeight + 5, width: progressBar.width, height: progressBar.height)
        horizontalRule.onSide(.top, statusBarHeight + progressBar.height + 5, width: horizontalRule.width, height: horizontalRule.height)
        roundNodeSeries.onSide(.top, statusBarHeight + progressBar.height + horizontalRule.height + 10, width: roundNodeSeries.width, height: roundNodeSeries.height)
        horizontalRuleTwo.onSide(.top, statusBarHeight + progressBar.height + horizontalRule.height +  roundNodeSeries.height + 15, width: horizontalRuleTwo.width, height: horizontalRuleTwo.height)
        
        let frameWidth = self.view.frame.width
        let frameHeight: CGFloat
        
        if DeviceProperty.isTypeX() {
            frameHeight = self.view.frame.height - 20
        } else {
            frameHeight = self.view.frame.height
        }
        
        roundProgressView.frame = CGRect(x: frameWidth / 2 - 130, y: frameHeight - 510, width: 260, height: 260)
        roundBgImgView.frame = CGRect(x: 0, y: 0, width: roundProgressView.width, height: roundProgressView.height)
        
        openSetupBtn.frame = CGRect(x: 19, y: frameHeight - 70, width: frameWidth - 38, height: 50)
        openSetupBtn.titleLabel?.frame = CGRect(x: self.view.frame.width / 2 - 25, y: self.view.frame.height / 2 - 13, width: 50, height: 26)
        lbl.onCenter(260, 260)
    }
    
    
    func controlSuperView() {
        mainViewModel.delegate = self
        self.view.addSubview(openSetupBtn)
        self.view.addSubview(progressBar)
        self.view.addSubview(roundNodeSeries)
        self.view.addSubview(horizontalRule)
        self.view.addSubview(horizontalRuleTwo)
        roundProgressView.addSubview(roundBgImgView)
        self.view.addSubview(roundProgressView)
        roundProgressView.addSubview(lbl)
        setup()
    }
    
    
    func setup() {
        
        openSetupBtn.layer.cornerRadius = 25
        openSetupBtn.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.3098039216, blue: 0.9960784314, alpha: 1)
        openSetupBtn.setTitle("SETUP", for: .normal)
        openSetupBtn.addTarget(self, action: #selector(openSetup(sender:)), for: .touchUpInside)
        
        roundBgImgView.image = UIImage(cgImage: roundBgImg!)
        
        progressBar.setup(progress: 87)
        
        roundNodeSeries.layout()
        
        lbl.font = UIFont(name: Font.exoBoldItalic, size: 60)
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //mainViewModel.playTimer()
    }
    
    
    @objc func openSetup(sender: UIButton) {
        
        let setupController = SetupViewController()
        self.navigationController?.pushViewController(setupController, animated: true)
    }
    
}

extension MainViewController: MainViewModelDelegate {
    func sendTimeAndSound(currentTime: Int) {
        print("Delegat Data prije zvuka \(currentTime)")
        if currentTime > 0 && currentTime < 4 {
            audioPlayer.playingSoundWith(fileName: "beep")
        }
        if currentTime == 0 {
            audioPlayer.playingSoundWith(fileName: "finish_beeb")
        }
        print("Delegat Data prije labele: \(currentTime)")
        lbl.text = String(currentTime)
        print("Data prosla do delegata a current time je \(currentTime)")
        print("--------------------------------")
    }
}

