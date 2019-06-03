//
//  Neon.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 03/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }) { (completed) in
            self.isHidden = true
            completion(true)
        }
    }
    
    
    func fillSuperView() {
        guard let superView = superview else {
            return
        }
        self.frame.size = superView.bounds.size
        self.frame.origin.x = 0
        self.frame.origin.y = 0
    }
    
    func fillSuperView(top: CGFloat, right: CGFloat, bottom: CGFloat, left: CGFloat) {
        guard let superView = superview else {
            return
        }
        if top + bottom > superView.height {
            return
        }
        if right + left > superView.width {
            return
        }
        if top < 0 || bottom < 0 || left < 0 || right < 0 {
            return
        }
        let w = superView.width - right - left
        let h = superView.height - top - bottom
        setupFrame(left, top, w, h)
    }
    
    func onCenter(_ width: CGFloat, _ height: CGFloat) {
        guard let superView = superview else {
            return
        }
        if width < 0 || height < 0 {
            return
        }
        var w = width
        var h = height
        if w > superView.width {
            w = superView.width
        }
        if h > superView.width {
            h = superView.width
        }
        let left = (superView.width - w) / 2
        let top = (superView.height - h) / 2
        setupFrame(left, top, w, h)
    }
    
    
    
    func onSide(_ side: Side, _ padding: CGFloat, width: CGFloat, height: CGFloat) {
        guard let superView = superview else {
            return
        }
        if padding < 0 || width < 0 || height < 0 {
            return
        }
        var w = width
        var h = height
        if w > superView.width {
            w = superView.width
        }
        if h > superView.height {
            h = superView.height
        }
        var xConf = padding
        var yConf = padding
        switch side {
        case .top:
            xConf = (superView.width - w) / 2
        case .bottom:
            yConf = superView.height - padding - h
            xConf = (superView.width - w) / 2
        case .left:
            yConf = (superView.height - h) / 2
        case .right:
            xConf = superView.width - padding - w
            yConf = (superView.height - h) / 2
        }
        setupFrame(xConf, yConf, w, h)
    }
    
    func onCorner(_ corner: Corner, x:CGFloat, y:CGFloat, w: CGFloat, h: CGFloat) {
        guard let superView = superview else {
            return
        }
        if x < 0 || y < 0 || width < 0 || height < 0 {
            return
        }
        var xConf = x
        var yConf = y
        switch corner {
        case .topLeft:
            xConf = x
            yConf = y
        case .topRight:
            xConf = superView.width - x - w
        case .bottomLeft:
            yConf = superView.height - y - h
        case .bottomRight:
            yConf = superView.height - y - h
            xConf = superView.width - x - w
        }
        setupFrame(xConf, yConf, w, h)
    }
    
    var width: CGFloat {
        get {
            return bounds.width
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.height
        }
    }
    
    func setupFrame(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        self.frame.origin.x = x
        self.frame.origin.y = y
        self.frame.size.width = w
        self.frame.size.height = h
    }
}

enum Side {
    case top
    case bottom
    case left
    case right
}

enum Corner {
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
}
