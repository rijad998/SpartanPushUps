//
//  ProgressBarView.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 06/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

class ProgressBarView: UIView {
    
    fileprivate var levelLabel = UILabel()
    fileprivate var progressLabel = UILabel()
    fileprivate var progressHolder = UIView()
    fileprivate var progressResult = UIView()
    fileprivate var level: String = ""
    fileprivate let progHoldWidth = UIScreen.main.bounds.width - 40
    
    
    init(level: String) {
        super.init(frame: CGRect(x: 0, y: 55, width: UIScreen.main.bounds.width, height: 64))
        self.level = level
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    fileprivate func setup() {
        
        levelLabel.font = UIFont(name: Font.roboto, size: 16)
        levelLabel.text = level
        
        progressLabel.font = UIFont(name: Font.roboto, size: 20)
        
        [levelLabel, progressLabel].forEach { label in
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.addSubview(label)
        }
        
        // setup progressHolder
        progressHolder.layer.borderWidth = 1
        progressHolder.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        progressHolder.layer.cornerRadius = 6
        
        // setup progressResult
        progressResult.layer.cornerRadius = 3
        progressResult.backgroundColor = #colorLiteral(red: 0.1882352941, green: 0.3098039216, blue: 0.9960784314, alpha: 1)
        
        addSubview(progressHolder)
        progressHolder.addSubview(progressResult)
        
    }
    
    
    func setup(progress: CGFloat) {
        
        layout()
        setup()
        
        progressLabel.text = "\(progress)% completed"
        
        let progressPercentage = (progress * progHoldWidth) / 100
        
        let w: CGFloat = progressPercentage - 6
        progressResult.onSide(.left, 3, width: w, height: 4)
    }
    
    
    func layout() {
        
        levelLabel.frame = CGRect(x: 26, y: 0, width: progHoldWidth - 12, height: 18)
        progressLabel.frame = CGRect(x: 26, y: 24, width: progHoldWidth - 12, height: 24)
        progressHolder.frame = CGRect(x: 20, y: 52, width: progHoldWidth, height: 10)
    }
    
}
