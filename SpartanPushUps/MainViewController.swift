//
//  ViewController.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 31/05/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

enum MuteBtnState {
    case muted
    case unmuted
}

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
    fileprivate let currentTimerLbl = UILabel()
    fileprivate let muteBtn = UIButton()
    fileprivate var muteBtnState: MuteBtnState = .unmuted
    
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
        muteBtn.frame = CGRect(x: frameWidth - 50, y: separatorTwo.frame.maxY + 20, width: 28, height: 28)
        
        let spaceBetween = (openSetupBtn.frame.minY - separatorTwo.frame.maxY)
        let middleCount = (spaceBetween - roundProgressCircle) / 2
        
        roundProgressView.onSide(.top, separatorTwo.frame.maxY + middleCount, width: roundProgressCircle, height: roundProgressCircle)
        
        roundBgImgView.fillSuperView()
        currentTimerLbl.fillSuperView()
    }
    
    
    func controlSuperView() {
        
        mainViewModel.delegate = self
        
        for hr in [separatorOne, separatorTwo] {
            hr.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        for subview in [openSetupBtn, progressBar, roundNodeSeries, separatorOne, separatorTwo, roundProgressView, muteBtn] {
            self.view.addSubview(subview)
        }

        for roundSubview in [roundBgImgView, currentTimerLbl] {
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
            
        currentTimerLbl.font = UIFont(name: Font.exoBoldItalic, size: 60)
        currentTimerLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        currentTimerLbl.textAlignment = .center
        
        mainViewModel.setAndFireTimer()
        
        audioPlayer.playingSoundWith(fileName: "beep")
        
        let randomNum = ceil(CGFloat.random(in: 1 ... 100))
        progressBar.dynamicSetup(progress: randomNum)
        
        let speaker = UIImage(named: "speaker.png")
        muteBtn.setImage(speaker, for: .normal)
        muteBtn.addTarget(self, action: #selector(muteUnmute(sender:)), for: .touchUpInside)
    }
    
    @objc func openSetup(sender: UIButton) {
        let setupController = SetupViewController()
        self.navigationController?.pushViewController(setupController, animated: true)
    }
    
    func setMuteUnmuteByState(state: MuteBtnState) {
        switch state {
        case .muted:
            muteBtnState = .unmuted
        default:
            muteBtnState = .muted
        }
    }
    
//    func muteUnmute() {
//        if let audioP = audioPlayer.audioPlayer {
//            if audioPlayer.audioPlayer.volume == 1 {
//                audioPlayer.audioPlayer.setVolume(0, fadeDuration: 0)
//            } else {
//                audioPlayer.audioPlayer.setVolume(1, fadeDuration: 0)
//            }
//        } else {
//            print("------------------------")
//            print("ERROR SA AUDIO PLAYEROM")
//            print("------------------------")
//        }
//    }
    
    
    @objc func muteUnmute(sender: UIButton) {
        setMuteUnmuteByState(state: muteBtnState)
    }
}

extension MainViewController: MainViewModelDelegate {
    
    func generateSeries(series: inout [Int]) {
        
    }
    
    func sendTimeAndSound(currentTime: Int) {
        
        if muteBtnState == .unmuted {

            if currentTime > 0 && currentTime < 14 {
                audioPlayer.playingSoundWith(fileName: "beep")
                if let audioP = audioPlayer.audioPlayer {
                    audioP.play()
                } else {
                    print("---------------\nERROR SA AUDIO PLAYEROM 222222\n----------------")
                }
            }
            
            if currentTime == 0 {
                audioPlayer.playingSoundWith(fileName: "finish_beeb")
                if let audioP = audioPlayer.audioPlayer {
                    audioP.play()
                } else {
                    print("---------------\nERROR SA AUDIO PLAYEROM 333333\n----------------")
                }
            }
        }
        currentTimerLbl.text = String(currentTime)
    }
}

