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

/// Class for series of round nodes at the top of the page, in
/// which there is series of numbers that represents number of
/// pushups that user is supposed to do
class RoundNodeSeries: UIView {

    var items: [SeriaItem] = []
    fileprivate var nodeSeries = UIView()
    public var state: NodeState = .inactive
    var mainSeries: [Int] = []
    
    /// Initialization of class. There are three functions inside
    /// First one is for calling parent's init function inside which
    /// is also defined frame for this function. Second function is
    /// for filling the array (mainSeries) with number '-1' in order
    /// to let others functions know that in the moment of initialization
    /// there is still no real values inside the 'mainSeries' array. And
    /// finally, third function is just calling setup function
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 42))
        for _ in 0...limit-1 {
            mainSeries.append(-1)
        }
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    
    /// Function for updating content of every node inside node series
    ///
    /// - Parameter receivedArray: array of numbers of pushups
    func update(receivedArray: [Int]){
        mainSeries.removeAll()
        mainSeries.append(contentsOf: receivedArray)
        for (index, item) in items.enumerated() {
            item.dynamicSetuplabel(labelNumber: mainSeries[index])
        }
        layout()
    }
    
    
    /// Main setup in which there is setup for every node
    /// individually and in which are nodes added to the
    /// items array
    func setup() {
        
        for i in 0...limit-1 {
            let item = SeriaItem()
            if i == 4 {
                item.setup(withLine: false)
            } else {
                item.setup(withLine: true)
            }
            items.append(item)
            nodeSeries.addSubview(item)
        }
        addSubview(nodeSeries)
    }

    /// Main layout function that defines xOffset (width and distances)
    /// between nodes and add them one by one to the series
    func layout() {
        let nodeSeriesWidth = CGFloat((limit * 56) - 18)
        nodeSeries.onCenter(nodeSeriesWidth, self.frame.height)
        var xOffset: CGFloat = 0
        for item in items {
            item.onSide(.left, xOffset, width: item.width, height: item.height)
            xOffset += item.width
        }
    }
    
    
    /// Function that updates state of item(node + horizontal line) individually by
    /// accessing it through it's itme's index
    ///
    /// - Parameters:
    ///   - index: index of an item in the items array
    ///   - state: new state of the item
    func updateStateByIndex(index: Int, state: NodeState) {
        items[index].setNodeByState(state: state)
        layout()
    }
}


/// Class that defines whole item which includes
/// node itself, horizontal line that connects node
/// with adjecent node, label that displays number
/// of pushups that need to be done and shadow underneath
/// the node
class SeriaItem: UIView {

    fileprivate var circleNode = UIView()
    fileprivate var horizontalLine = UIView()
    fileprivate var pushUpLabel = UILabel()
    fileprivate var circleShadow = false

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

    /// Main setup of the node and other sub-items
    fileprivate func setup(withLine: Bool) {

        var w:CGFloat = 0
        if !withLine {
            horizontalLine.isHidden = true
            w = 38
        } else {
            horizontalLine.isHidden = false
            w = 56
            addSubview(horizontalLine)
        }

        self.frame.size.width = w
        self.frame.size.height = 38

        addSubview(circleNode)
        circleNode.layer.cornerRadius = 18
        circleNode.layer.borderWidth = 2
        circleNode.addSubview(pushUpLabel)
        pushUpLabel.font = UIFont(name: Font.exoBoldItalic, size: 16)
        pushUpLabel.textAlignment = .center
        pushUpLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        setNodeByState(state: .activeNext)
    }

    func setShadow() {
        circleNode.layer.shadowPath = UIBezierPath(roundedRect: .init(x: 0, y: 7, width: 38, height: 38), cornerRadius: 18).cgPath
        circleNode.layer.shadowColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
        circleNode.layer.shadowOpacity = 1
        circleNode.layer.shouldRasterize = true
    }

    
    /// Function that defines differences between states
    /// of nodes and set item according to the given node
    ///
    /// - Parameter state: state that item needs to get
    func setNodeByState(state: NodeState) {
        switch state {
            case .activeDone:
                circleNode.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                setShadow()
            case .activeNext:
                circleNode.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 1)
                circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1)
                setShadow()
            default:
                circleNode.backgroundColor = #colorLiteral(red: 0.1294117647, green: 0.1294117647, blue: 0.1294117647, alpha: 0.54)
                circleNode.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 0.54)
                horizontalLine.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 0.5388484589)
                circleNode.layer.shadowOpacity = 0
        }
    }
    
    
    /// Dynamic setup of the label according to the
    /// received number
    ///
    /// - Parameter labelNumber: number that is being shown
    func dynamicSetuplabel(labelNumber: Int) {

        if labelNumber > 0 {
            pushUpLabel.text = String(labelNumber)
        } else {
            pushUpLabel.text = ""
            setNodeByState(state: .inactive)
        }

    }

    
    /// Main layout that puts node and line in the item
    fileprivate func layout() {
        circleNode.onSide(.left, 0, width: 38, height: 38)
        if !horizontalLine.isHidden {
            horizontalLine.onSide(.right, 0, width: 18, height: 3)
        }
        pushUpLabel.fillSuperView()
    }
}
