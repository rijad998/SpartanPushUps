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
    fileprivate let separatorOne = UIView()
    fileprivate let separatorTwo = UIView()
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
        
        let frameWidth = self.view.frame.width
        let roundProgressCircle: CGFloat = 260
        
        progressBar.onSide(.top, statusBarHeight + 5, width: progressBar.width, height: progressBar.height)
        separatorOne.onSide(.top, progressBar.frame.maxY + 20, width: frameWidth - 20, height: 2)
        roundNodeSeries.onSide(.top, separatorOne.frame.maxY + 20, width: roundNodeSeries.width, height: roundNodeSeries.height)
        separatorTwo.onSide(.top, roundNodeSeries.frame.maxY + 20, width: frameWidth - 20, height: 2)
        openSetupBtn.onSide(.bottom, bottomOffset, width: frameWidth - 38, height: 50)
        
        let spaceBetween = (openSetupBtn.frame.minY - separatorTwo.frame.maxY)
        let middleCount = (spaceBetween - roundProgressCircle) / 2
        
        roundProgressView.onSide(.top, separatorTwo.frame.maxY + middleCount, width: roundProgressCircle, height: roundProgressCircle)
        
        roundBgImgView.fillSuperView()
        lbl.fillSuperView()
    }
    
    
    func controlSuperView() {
        
        mainViewModel.delegate = self
        
        for hr in [separatorOne, separatorTwo] {
            hr.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        for subview in [openSetupBtn, progressBar, roundNodeSeries, separatorOne, separatorTwo, roundProgressView] {
            self.view.addSubview(subview)
        }

        for roundSubview in [roundBgImgView, lbl] {
            roundProgressView.addSubview(roundSubview)
        }
        
        setup()
    }
    
    
    func setup() {
        
        openSetupBtn.layer.cornerRadius = 25
        openSetupBtn.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.3098039216, blue: 0.9960784314, alpha: 1)
        openSetupBtn.setTitle("SETUP", for: .normal)
        openSetupBtn.addTarget(self, action: #selector(openSetup(sender:)), for: .touchUpInside)
        
        roundBgImgView.image = UIImage(cgImage: roundBgImg!)
        
        progressBar.dynamicSetup(progress: 87)
        
        roundNodeSeries.layout()
        
        lbl.font = UIFont(name: Font.exoBoldItalic, size: 60)
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.textAlignment = .center
        
        mainViewModel.setAndFireTimer()
        
        audioPlayer.playingSoundWith(fileName: "beep")
    }
    
    
    @objc func openSetup(sender: UIButton) {
        let setupController = SetupViewController()
        self.navigationController?.pushViewController(setupController, animated: true)
    }
    
}

extension MainViewController: MainViewModelDelegate {
    
    func sendTimeAndSound(currentTime: Int) {
        if currentTime > 0 && currentTime < 4 {
            audioPlayer.audioPlayer.play()
        }
        if currentTime == 0 {
            audioPlayer.playingSoundWith(fileName: "finish_beeb")
            audioPlayer.audioPlayer.play()
        }
        lbl.text = String(currentTime)
    }
}

