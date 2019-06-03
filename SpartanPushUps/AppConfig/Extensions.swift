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
}
