//
//  HorizontalRule.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 10/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//
import Foundation
import UIKit

class HorizontalRule: UIView {
    
    fileprivate let line = UIView()
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 38))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        line.frame = CGRect(x: 13, y: 18, width: self.width - 26, height: 2)
        line.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        //line.onCenter(UIScreen.main.bounds.width, 38)
        self.addSubview(line)
    }
    
}
