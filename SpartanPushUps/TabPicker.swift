//
//  TabPicker.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 21/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

enum TabStateSelect {
    case selected
    case notSelected
}

enum TabStateType {
    case level
    case pushup
}

class TabPicker: UIView {
    fileprivate var title = UILabel()
    var seriesTab: [Tab] = []
    fileprivate var numOfTab = 0
    
    init(tabType: TabStateType){
        var tabHeight = 0
        if tabType == .level {
            tabHeight = 40 * Tabs.numberOfLevels + 20
            numOfTab = Tabs.numberOfLevels
            title.text = ("CHOOSE LEVEL:")
        } else {
            tabHeight = 40 * Tabs.numberOfPushupTypes + 20
            numOfTab = Tabs.numberOfPushupTypes
            title.text = ("CHOOSE PUSHUP:")
        }
        super.init(frame: CGRect(x: 0, y: 0, width: Int(UIScreen.main.bounds.width), height: tabHeight))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(){
        
        var yOffset = 0
        
        title.onSide(.top, 0, width: self.width - 40, height: 20)
        title.font = UIFont(name: Font.roboto, size: 14)
        
        for i in 0...numOfTab-1 {
            
        }
    }
}

class Tab: UIView {
    
    fileprivate var levelName = UILabel()
    fileprivate let doneImg = UIImage.loadImageData("done24.png")
    fileprivate let doneImgView = UIImageView()
    fileprivate let eyeImg = UIImage.loadImageData("eye24.png")
    fileprivate let eyeButton = UIButton()
    var seriesLabel = UILabel()
    fileprivate let separator = UIView()
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func layout(){
        doneImgView.onSide(.left, 20, width: 26, height: 26)
        separator.onSide(.bottom, 0, width: self.width, height: 1)
    }
    
    func setup(levelPushupName: String, seriesLabel: String, tabType: TabStateType){
        levelName.text = levelPushupName
        doneImgView.image = UIImage.init(cgImage: doneImg as! CGImage)
        separator.backgroundColor = UIColor.init(hex: "FFFFFF").withAlphaComponent(0.24)
        
        setTabByTypeState(state: tabType)
        
        self.addSubview(levelName)
        self.addSubview(doneImgView)
        self.addSubview(separator)
    }
    
    func setTabBySelectState(state: TabStateSelect) {
        switch state {
            case .selected:
                self.backgroundColor = UIColor(hex: "D50000").withAlphaComponent(0.84)
                doneImgView.isHidden = false
                levelName.font = UIFont(name: Font.exoSemiBoldItalic, size: 20)
                levelName.onSide(.left, 60, width: 100, height: 26)
            default:
                self.backgroundColor = UIColor.white.withAlphaComponent(0)
                doneImgView.isHidden = true
                levelName.font = UIFont(name: Font.exoItalic, size: 20)
                levelName.onSide(.left, 42, width: 100, height: 26)
        }
    }
    
    func setTabByTypeState(state: TabStateType) {
        switch state {
        case .level:
            seriesLabel.onSide(.right, 20, width: 140, height: 26)
            self.addSubview(seriesLabel)
        default:
            eyeButton.onSide(.right, 20, width: 26, height: 26)
            eyeButton.setImage(eyeImg, for: .normal)
            self.addSubview(eyeButton)
        }
    }
}

