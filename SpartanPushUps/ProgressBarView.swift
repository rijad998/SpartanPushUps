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
    var levelLabel = UILabel()
    var progressLabel = UILabel()
    var progressHolder = UIView()
    var progressResult = UIView()
    
    //dodati level
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // pozicije objekata
    }
    
    
    
    fileprivate func setup() {
        
        levelLabel.font = UIFont(name: Font.roboto, size: 16)
        
        progressLabel.font = UIFont(name: Font.roboto, size: 20)
        
        [levelLabel, progressLabel].forEach { label in
            label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            self.addSubview(label)
        }
        
        // setup progressHolder
        //border
        //radius
        
        // setup progressResult
        //radius
        //bckg
        
        addSubview(progressHolder)
        progressHolder.addSubview(progressResult)
        
        
    }
    
    //u procentima
    func setup(progress: CGFloat) {
        //procente na title
        
        // layout???
        
        let w: CGFloat = 55
        progressResult.onSide(.left, 3, width: w, height: 6)
    }
    
    
    func layout() {
        // labels
        // holder
    }
    
}
