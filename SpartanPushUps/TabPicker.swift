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
    
    
    init(){
        setup()
    }
    
    func setup(){
        //mainView.onSide(.top, yOffset, width: UIScreen.main.bounds.width, height: 40)
        
    }
    
    func setTabBySelectState(state: TabStateSelect) {
        switch state {
            case .selected:
                mainView.backgroundColor = UIColor(hex: "D50000").withAlphaComponent(0.84)
                levelName.font = UIFont(name: Font.exoSemiBoldItalic, size: 20)
            default:
                mainView.backgroundColor = UIColor.white.withAlphaComponent(0)
                levelName.font = UIFont(name: Font.exoItalic, size: 20)
                levelName.text = ("")
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
