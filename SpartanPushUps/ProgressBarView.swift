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
    fileprivate let progressHoldWidth = UIScreen.main.bounds.width - 40
    
    
    init(level: String) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        self.level = level
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    
    fileprivate func setup() {
        
        levelLabel.font = UIFont(name: Font.roboto, size: 16)
        levelLabel.text = level
        
        progressLabel.font = UIFont(name: Font.exoBoldItalic, size: 20)
        
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
    
    func dynamicSetup(progress: CGFloat) {
        
        progressLabel.text = "\(progress)% completed"
        
        let progressPercentage = (progress * progressHoldWidth) / 100
        
        let w: CGFloat = progressPercentage - 6
        progressResult.onSide(.left, 3, width: w, height: 4)
        
        progressResult.removeFromSuperview()
        progressHolder.addSubview(progressResult)
    }
    
    func layout() {
        
        levelLabel.onSide(.top, 0, width: progressHoldWidth - 12, height: 18)
        progressLabel.onSide(.top, 24, width: progressHoldWidth - 12, height: 24)
        progressHolder.onSide(.top, 52, width: progressHoldWidth, height: 10)
    }
    
}
