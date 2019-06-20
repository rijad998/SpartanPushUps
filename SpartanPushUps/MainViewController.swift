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

enum SetupResetBtnState {
    case setup
    case reset
}

class MainViewController: UIViewController {
    
    fileprivate let mainViewModel = MainViewModel()
    
    fileprivate let progressBar = ProgressBarView(level: "NOVICE")
    fileprivate let roundNodeSeries = RoundNodeSeries()
    fileprivate let separatorOne = UIView()
    fileprivate let separatorTwo = UIView()
    
    fileprivate let roundProgressView = UIView()
    fileprivate var noseTap = UITapGestureRecognizer()
    fileprivate let roundBgImg = UIImage.loadImageData("bg-circle.png")?.cgImage
    fileprivate let roundBgImgView = UIImageView()
    fileprivate let currentTimerLbl = UILabel()
    
    fileprivate let muteBtn = UIButton()
    fileprivate let audioPlayer = AudioPlayer()
    fileprivate var muteBtnState: MuteBtnState = .unmuted
    
    fileprivate var tempArray: [Int] = []
    
    fileprivate let setupResetBtn = UIButton()
    fileprivate let setupResetBtnState: SetupResetBtnState = .setup
    
    // ---- BUTTON FOR TESTING ----
    let testBtn = UIButton()
    // ---- BUTTON FOR TESTING ----
    
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
        setupResetBtn.onSide(.bottom, bottomOffset, width: frameWidth - 38, height: 50)
        muteBtn.frame = CGRect(x: frameWidth - 50, y: separatorTwo.frame.maxY + 20, width: 28, height: 28)
        
        // ---- BUTTON FOR TESTING ----
        testBtn.onSide(.top, separatorTwo.frame.maxY + 10, width: 100, height: 50)
        // ---- BUTTON FOR TESTING ----
        
        let spaceBetween = (setupResetBtn.frame.minY - separatorTwo.frame.maxY)
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
        
        for subview in [setupResetBtn, progressBar, roundNodeSeries, separatorOne, separatorTwo, roundProgressView, muteBtn] {
            self.view.addSubview(subview)
        }

        for roundSubview in [roundBgImgView, currentTimerLbl] {
            roundProgressView.addSubview(roundSubview)
        }
        
        setup()
        
    }
    
    func setMuteUnmuteByState(state: MuteBtnState) {
        switch state {
        case .muted:
            muteBtnState = .unmuted
        default:
            muteBtnState = .muted
        }
    }
    
//
    func setSetupResetBtnByState(state: SetupResetBtnState) {
        
        setupResetBtn.removeTarget(nil, action: nil, for: .allEvents)
        
        switch state {
        case .setup:
            setupResetBtn.backgroundColor = UIColor.init(hex: "304FFE").withAlphaComponent(1)
            setupResetBtn.setTitle("SETUP", for: .normal)
            setupResetBtn.addTarget(self, action: #selector(openSetupController(sender:)), for: .touchUpInside)
        default:
            setupResetBtn.backgroundColor = UIColor.init(hex: "FFFFFF").withAlphaComponent(0.12)
            setupResetBtn.setTitle("RESET", for: .normal)
            setupResetBtn.addTarget(self, action: #selector(resetWorkout(sender:)), for: .touchUpInside)
        }
    }
    
    func setup() {
        
        setupResetBtn.layer.cornerRadius = 25
        setSetupResetBtnByState(state: .setup)
        
        roundBgImgView.image = UIImage(cgImage: roundBgImg!)
            
        currentTimerLbl.font = UIFont(name: Font.exoBoldItalic, size: 35)
        currentTimerLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        currentTimerLbl.textAlignment = .center
        currentTimerLbl.numberOfLines = 0
        currentTimerLbl.text = "TAP TO\nSTART!"
        
        audioPlayer.playingSoundWith(fileName: "beep")
        
        let randomNum = ceil(CGFloat.random(in: 1 ... 100))
        progressBar.dynamicSetup(progress: randomNum)
        
        let speaker = UIImage(named: "speaker.png")
        muteBtn.setImage(speaker, for: .normal)
        muteBtn.addTarget(self, action: #selector(muteUnmute(sender:)), for: .touchUpInside)
        
        noseTap = UITapGestureRecognizer(target: self, action: #selector(self.handleNoseTap(_:)))
        currentTimerLbl.addGestureRecognizer(noseTap)
        currentTimerLbl.isUserInteractionEnabled = true
        
        // ---- BUTTON FOR TESTING ----
        testBtn.setTitle("TEST", for: .normal)
        testBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        testBtn.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        testBtn.addTarget(self, action: #selector(testBtnFunc(sender:)), for: .touchUpInside)
        self.view.addSubview(testBtn)
        // ---- BUTTON FOR TESTING ----
    }
    
    @objc func handleNoseTap(_ sender: UIGestureRecognizer? = nil) {
        mainViewModel.decreaseValue()
    }
    
    @objc func testBtnFunc(sender: UIButton) {
        DataHandler.generateTheSeries()
        transferSeriesDataToRound()
        mainViewModel.controlLoop()
        // doPushups()
    }
    
    @objc func openSetupController(sender: UIButton) {
        let setupController = SetupViewController()
        self.navigationController?.pushViewController(setupController, animated: true)
    }
    
    @objc func resetWorkout(sender: UIButton) {
        mainViewModel.timer.invalidate()
        for item in roundNodeSeries.items {
            item.setNodeByState(state: .activeNext)
        }
        mainViewModel.index = 0
        mainViewModel.controlLoop()
    }
    
//    func switchSetupResetBtnState(state: SetupResetBtnState) {
//
//    }
    
    @objc func muteUnmute(sender: UIButton) {
        setMuteUnmuteByState(state: muteBtnState)
    }
    
    func transferSeriesDataToRound() {
        tempArray.append(contentsOf: DataHandler.seriesArray)
        roundNodeSeries.update(receivedArray: tempArray)
    }
}

extension MainViewController: MainViewModelDelegate {
    
    func switchStateSetupReset(setupReset: Bool) {
        currentTimerLbl.font = UIFont(name: Font.exoBoldItalic, size: 60)
        if setupReset == true {
            setSetupResetBtnByState(state: .setup)
        } else {
            setSetupResetBtnByState(state: .reset)
        }
    }
    
    func enableDisableTap(enabled: Bool, index: Int) {
        if enabled == true {
            noseTap.isEnabled = true
            if index < limit {
                roundNodeSeries.updateStateByIndex(index: index, state: .activeDone)
            }
        } else {
            noseTap.isEnabled = false
        }
    }
    
    func sendCurrentPushup(currentPushup: Int) {
        currentTimerLbl.text = String(currentPushup)
    }
    
    func activateRest() {
        mainViewModel.setAndFireTimer(counter: shortPause)
    }
    
    func sendTimeAndSound(currentTime: Int) {
        
        if muteBtnState == .unmuted {
            if currentTime > 0 && currentTime < 4 {
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

