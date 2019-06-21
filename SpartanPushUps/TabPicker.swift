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

class TabPicker {
    fileprivate var title = UILabel()
}

class Tab {
    
    fileprivate let mainView = UIView()
    fileprivate var levelName = UILabel()
    fileprivate let doneImg = UIImage.loadImageData("done24.png")
    fileprivate let doneImgView = UIImageView()
    fileprivate let eyeImg = UIImage.loadImageData("eye24.png")
    fileprivate let eyeImgView = UIImageView()
    fileprivate let separator = UIView()
    
    init(){
        setup()
    }
    
    func setup(){
        // MORA SE PROVJERITI JOS!!!
        //mainView.onSide(.top, yOffset, width: UIScreen.main.bounds.width, height: 40)
        doneImgView.onSide(.left, 20, width: 26, height: 26)
        doneImgView.image = UIImage.init(cgImage: doneImg as! CGImage)
        separator.onSide(.bottom, 0, width: mainView.width, height: 1)
        separator.backgroundColor = UIColor.init(hex: "FFFFFF").withAlphaComponent(0.24)
    }
    
    func setTabBySelectState(state: TabStateSelect) {
        switch state {
            case .selected:
                mainView.backgroundColor = UIColor(hex: "D50000").withAlphaComponent(0.84)
                doneImgView.isHidden = false
                levelName.font = UIFont(name: Font.exoSemiBoldItalic, size: 20)
                levelName.onSide(.left, 60, width: 100, height: 200)
            default:
                mainView.backgroundColor = UIColor.white.withAlphaComponent(0)
                doneImgView.isHidden = true
                levelName.font = UIFont(name: Font.exoItalic, size: 20)
                levelName.onSide(.left, 42, width: 100, height: 20)
        }
    }
    
    func setTabByTabState(state: TabStateType) {
        switch state {
        case .level:
            <#code#>
        default:
            <#code#>
        }
    }
}
