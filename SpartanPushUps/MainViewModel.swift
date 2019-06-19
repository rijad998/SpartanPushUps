//
//  MainViewModel.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 11/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

protocol MainViewModelDelegate {
    func sendTimeAndSound(currentTime: Int)
    func sendCurrentPushup(currentPushup: Int)
    func activateRest(index: Int)
}

class MainViewModel {
    
    var timerCount = 5
    var delegate: MainViewModelDelegate?
    var simpleCount = 1
    var timer = Timer()
    var index = 0
    var inValue = 0
    
    init(){
    }
    
    func controlLoop(){
        inValue = DataHandler.seriesArray[index]
        index += 1
    }
    
    func decreaseValue(){
        inValue -= 1
        delegate?.sendCurrentPushup(currentPushup: inValue)
        if inValue == 0 {
            delegate?.activateRest(index: index)
            sleep(1)
            if index < limit { controlLoop() }
            else  { print("\n\n-----KRAJ-----\n\n") }
        }
    }
    
    func setAndFireTimer(counter: Int){
        timerCount = counter
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func timerAction(){
        // print("Timer okinut \(self.simpleCount). put")
        self.simpleCount += 1
        self.delegate?.sendTimeAndSound(currentTime: self.timerCount)
        if timerCount == 0 {
            self.timer.invalidate()
        }
        self.timerCount -= 1
    }
}
