//
//  TabPicker.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 21/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

enum TabStateType {
    case level
    case pushup
}

public class TabPicker: UIView {
    fileprivate var titleLabel = UILabel()
    var seriesTab: [Tab] = []
    var seriesTabView = UIView()
    fileprivate var numOfTab = 0
    var tabPickerType: TabStateType
    
    init(tabType: TabStateType){
        self.tabPickerType = tabType
        var tabHeight: CGFloat = 0
        if tabType == .level {
            tabHeight = CGFloat(40 * Tabs.numberOfLevels + 20)
            numOfTab = Tabs.numberOfLevels
            titleLabel.text = ("CHOOSE LEVEL:")
        } else {
            tabHeight = CGFloat(40 * Tabs.numberOfPushupTypes + 20)
            numOfTab = Tabs.numberOfPushupTypes
            titleLabel.text = ("CHOOSE PUSHUP:")
        }
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: tabHeight))
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        layout()
    }
    
    func setup(){
        addSubview(titleLabel)
        titleLabel.onSide(.top, 0, width: self.width - 40, height: 20)
        titleLabel.font = UIFont(name: Font.roboto, size: 14)
        titleLabel.textColor = UIColor.white
        
        
        for i in 0...numOfTab-1 {
            print("\n\n ---- \(i) ----- \n\n")
            let tab = Tab()
            if tabPickerType == .level {
                tab.setup(levelPushupName: TabNames.levelNames[i], seriesLabel: seriesByLevelsTabs[i], tabType: tabPickerType)
                print("\(TabNames.levelNames[i])")
            } else {
                tab.setup(levelPushupName: TabNames.pushupNames[i], seriesLabel: "", tabType: tabPickerType)
            }
            seriesTab.append(tab)
            seriesTabView.addSubview(tab)
        }
        self.addSubview(seriesTabView)
    }
    
    func layout() {
        var yOffset: CGFloat = 25
        seriesTabView.onCenter(self.frame.width, self.frame.height)
        for tab in seriesTab {
            tab.onSide(.top, yOffset, width: self.frame.width, height: 40)
            yOffset += 40
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
    public var selectState: TabStateSelect = .notSelected
    
    init(){
        super.init(frame: CGRect.zero)
        addSubview(levelName)
        addSubview(doneImgView)
        addSubview(separator)
        addSubview(seriesLabel)
        addSubview(eyeButton)
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
        levelName.textColor = UIColor.white
        doneImgView.image = UIImage(named: "done24.png")
        separator.backgroundColor = UIColor.init(hex: "FFFFFF").withAlphaComponent(0.24)
        self.seriesLabel.text = seriesLabel
        setTabByTypeState(state: tabType)
        setTabBySelectState(state: .selected)
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
        default:
            eyeButton.onSide(.right, 20, width: 26, height: 26)
            eyeButton.setImage(eyeImg, for: .normal)
        }
    }
}

