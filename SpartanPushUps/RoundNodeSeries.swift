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
    public var state: NodeState = .activeNext
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func fillTheLevel(level: inout[Int]) {
        for n in 1...5 {
            let randomNum = Int.random(in: 3 ... 6)
            level.append(randomNum)
            print("Number \(randomNum) is added to the \(n). place in the level array")
        }
    }
    
    func setup() {
        
        var series: [Int] = []
        
        fillTheLevel(level: &series)
        
        for i in 0...4 {
            let item = SeriaItem()
            if i == 4 {
                item.horizontalLine.isHidden = true
                item.setup(withLine: false)
                item.dynamicSetup(state: .activeNext, labelNumber: series[i])
                nekiWidth += 38
            } else {
                item.setup(withLine: true)
                item.dynamicSetup(state: .activeNext, labelNumber: series[i])
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
        }
        
        self.frame.size.width = w
        self.frame.size.height = 38
        
        addSubview(circleNode)
        circleNode.layer.cornerRadius = 18
        circleNode.layer.borderWidth = 2
        circleNode.layer.shadowColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
        circleNode.layer.shadowOpacity = 1
        circleNode.layer.shadowOffset = .init(width: 0, height: 4)
        circleNode.layer.shadowRadius = 5
        
        circleNode.addSubview(pushUpLabel)
        pushUpLabel.font = UIFont(name: Font.exoBoldItalic, size: 16)
        pushUpLabel.textAlignment = .center
        pushUpLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
    func setNodeByState(state: NodeState) {
        switch state {
            case .activeDone:
                circleNode.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
            case .activeNext:
                circleNode.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
                circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
            default:
                circleNode.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.54)
                circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 0.54)
                horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 0.5388484589)
        }
    }
    
    
    func dynamicSetup(state: NodeState, labelNumber: Int) {
        setNodeByState(state: state)
        pushUpLabel.text = String(labelNumber)
    }
    
    
    fileprivate func layout() {
        circleNode.onSide(.left, 0, width: 38, height: 38)
        if !horizontalLine.isHidden {
            horizontalLine.onSide(.right, 0, width: 18, height: 3)
        }
        pushUpLabel.fillSuperView()
    }    
}
