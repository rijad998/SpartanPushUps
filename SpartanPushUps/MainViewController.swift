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
    fileprivate var tempArray: [Int] = []
    var testStates: [NodeState] = []
    fileprivate var currentNodePushups = 0
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
        openSetupBtn.onSide(.bottom, bottomOffset, width: frameWidth - 38, height: 50)
        muteBtn.frame = CGRect(x: frameWidth - 50, y: separatorTwo.frame.maxY + 20, width: 28, height: 28)
        
        // ---- BUTTON FOR TESTING ----
        testBtn.onSide(.top, separatorTwo.frame.maxY + 10, width: 100, height: 50)
        // ---- BUTTON FOR TESTING ----
        
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
        openSetupBtn.addTarget(self, action: #selector(openSetupController(sender:)), for: .touchUpInside)
        
        roundBgImgView.image = UIImage(cgImage: roundBgImg!)
            
        currentTimerLbl.font = UIFont(name: Font.exoBoldItalic, size: 60)
        currentTimerLbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        currentTimerLbl.textAlignment = .center
        
        // mainViewModel.setAndFireTimer()
        
        audioPlayer.playingSoundWith(fileName: "beep")
        
        let randomNum = ceil(CGFloat.random(in: 1 ... 100))
        progressBar.dynamicSetup(progress: randomNum)
        
        let speaker = UIImage(named: "speaker.png")
        muteBtn.setImage(speaker, for: .normal)
        muteBtn.addTarget(self, action: #selector(muteUnmute(sender:)), for: .touchUpInside)
        
        let noseTap = UIGestureRecognizer(target: self, action: #selector(self.handleNoseTap(_:)))
        roundProgressView.addGestureRecognizer(noseTap)
        
        // ---- BUTTON FOR TESTING ----
        testBtn.setTitle("TEST", for: .normal)
        testBtn.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        testBtn.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        testBtn.addTarget(self, action: #selector(testBtnFunc(sender:)), for: .touchUpInside)
        self.view.addSubview(testBtn)
        // ---- BUTTON FOR TESTING ----
    }
    
    @objc func handleNoseTap(_ sender: UIGestureRecognizer? = nil) {
        currentNodePushups -= 1
    }
    
    func doPushups(){
        print("\n\nDO PUSHUPS!!!\n\n------START------\n\n")
        for (index, i) in tempArray.enumerated() {
            currentNodePushups = i
            while currentNodePushups > 0 {
                print("-----\(currentNodePushups)-----")
                currentTimerLbl.text = String(currentNodePushups)
                handleNoseTap()
            }
            if index != tempArray.count-1 {
                mainViewModel.setAndFireTimer(counter: shortPause)
            }
            testStates[index] = .activeDone
            roundNodeSeries.update(receivedArray: tempArray, arrayOfStates: testStates)
        }
        print("\n\n------END------\n\n")
    }
    
    @objc func testBtnFunc(sender: UIButton) {
        DataHandler.generateTheSeries()
        transferSeriesDataToRound()
        //doPushups()
    }
    
    @objc func openSetupController(sender: UIButton) {
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
    
    @objc func muteUnmute(sender: UIButton) {
        setMuteUnmuteByState(state: muteBtnState)
    }
    
    func transferSeriesDataToRound() {
        testStates.append(.activeNext)
        testStates.append(.activeNext)
        testStates.append(.activeNext)
        testStates.append(.activeNext)
        testStates.append(.activeNext)
        
        tempArray.append(contentsOf: DataHandler.seriesArray)
        roundNodeSeries.update(receivedArray: tempArray, arrayOfStates: testStates)
        
        //doPushups(pushupSeries: tempArray)
    }
}

extension MainViewController: MainViewModelDelegate {
    
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

