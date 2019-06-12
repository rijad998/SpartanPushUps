//
//  RoundSeriesNode.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 07/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

enum NodeState {
    case activeDone
    case activeNext
    case inactive
}

class RoundNodeSeries: UIView {
    
    fileprivate var items: [SeriaItem] = []
    fileprivate var nodeSeries = UIView()
    fileprivate var nekiWidth: CGFloat = 0
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        for i in 0...4 {
            let item = SeriaItem()
            if i == 4 {
                item.horizontalLine.isHidden = true
                item.setup(withLine: false)
                nekiWidth += 38
            } else {
                item.setup(withLine: true)
                nekiWidth += 56
            }
            items.append(item)
            nodeSeries.addSubview(item)
        }
        addSubview(nodeSeries)
    }
    
    func layout() {
        nodeSeries.onCenter(nekiWidth, self.frame.height)
        var xOffset: CGFloat = 0
        for item in items {
            item.onSide(.left, xOffset, width: item.width, height: item.height)
            xOffset += item.width
        }
    }
    
}


class SeriaItem: UIView {
    
    fileprivate var circleNode = UIView()
    fileprivate var horizontalLine = UIView()
    fileprivate var pushUpLabel = UILabel()
    
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    fileprivate func setup(withLine: Bool) {
        var w:CGFloat = 0
        if !withLine {
            horizontalLine.isHidden = true
            w = 38
        } else {
            w = 56
            addSubview(horizontalLine)
            horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 0.5388484589)
        }
        self.frame.size.width = w
        self.frame.size.height = 38
        addSubview(circleNode)
        circleNode.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.54)
        circleNode.layer.cornerRadius = 18
        circleNode.layer.borderWidth = 2
        circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 0.54)
    }
    
    fileprivate func layout() {
        circleNode.onSide(.left, 0, width: 38, height: 38)
        if !horizontalLine.isHidden {
            horizontalLine.onSide(.right, 0, width: 18, height: 2)
        }
    }
    
}
