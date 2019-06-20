//
//  Extensions.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 03/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    static func loadImageData(_ imageName: String) -> UIImage? {
        let file = imageName.components(separatedBy: ".")
        guard let path = Bundle.main.path(forResource: file[0], ofType:file[1]) else {
            debugPrint( "\(file.joined(separator: ".")) not found")
            return nil
        }
        let url = URL(fileURLWithPath: path)
        let data = NSData(contentsOf: url)
        return UIImage(data: data! as Data)
    }
    
}

extension UIViewController {
    
    var navBarHeight: CGFloat {
        get {
            if let height = self.navigationController?.navigationBar.frame.height {
                return height
            }
            return 0
        }
    }
    
    var statusBarHeight: CGFloat {
        get {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    var topOffset: CGFloat {
        get {
            return navBarHeight + statusBarHeight
        }
    }
    
    var bottomOffset: CGFloat {
        get {
            if DeviceProperty.isTypeX() {
                return 48
            }
            return 24
        }
    }
    
    func setNavigationBarTransparent(){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
}

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
