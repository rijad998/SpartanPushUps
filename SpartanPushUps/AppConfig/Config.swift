//
//  Config.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 03/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit

public var bgImg: UIImage {
    get {
        return UIImage(named: "bg.png")!
    }
}

public struct Font {
    static let roboto = "Roboto-Regular"
    static let exoBoldItalic = "Exo-BoldItalic"
}

public var limit = 5

public var shortPause = 45
public var middlePause = 60
public var longPause = 75
