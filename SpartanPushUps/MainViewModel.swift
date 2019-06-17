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
}

class MainViewModel {
    
    
    var timerCount = 5
    var delegate: MainViewModelDelegate?
    var simpleCount = 1
    var timer = Timer()
    
    
    init(){}
    
    func setAndFireTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc func timerAction(){
        print("Timer okinut \(self.simpleCount). put")
        self.simpleCount += 1
        self.delegate?.sendTimeAndSound(currentTime: self.timerCount)
        if timerCount == 0 {
            self.timer.invalidate()
        }
        self.timerCount -= 1
    }
}
