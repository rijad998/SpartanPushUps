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
    func generateSeries(series: [Int])
}

class MainViewModel {
    
    var timerCount = 18
    var delegate: MainViewModelDelegate?
    var simpleCount = 1
    var timer = Timer()
    
    init(){
        
    }
    
    func generateTheSeries() {
        var startingArray: [Int] = []
        for n in 1...5 {
            let randomNum = Int.random(in: 3 ... 6)
            startingArray.append(randomNum)
            print("Number \(randomNum) is added to the \(n). place in the level array")
        }
        for n in 0...4 {
            print("--------\nMain View Model: \(n+1). clan niza je \(startingArray[n])\n--------")
        }
        delegate?.generateSeries(series: startingArray)
    }
    
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
