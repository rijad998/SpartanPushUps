//
//  Data Handler.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 16/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

public class DataHandler {
    
    static var seriesArray: [Int] = []
    
    static func generateTheSeries() {
        for n in 1...limit {
            let randomNum = Int.random(in: 3 ... 6)
            seriesArray.append(randomNum)
            print("Number \(randomNum) is added to the \(n). place in the level array")
            print("--------\nDataHandler: \(n). clan niza je \(seriesArray[n])\n--------")
        }
    }
    
    static func cleanArray(){
        seriesArray.removeAll()
    }
}
