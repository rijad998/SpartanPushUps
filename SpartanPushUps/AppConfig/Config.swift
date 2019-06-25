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
    static let exoSemiBoldItalic = "Exo-SemiBoldItalic"
    static let exoItalic = "Exo-Italic"
}

public var limit = 5

public var shortPause = 10
public var middlePause = 60
public var longPause = 75


public struct Tabs {
    static let numberOfLevels = 4
    static let numberOfPushupTypes = 2
}

public struct TabNames {
    static let levelNames = ["Novice", "Beginner", "Intermediate", "Spartan"]
    static let pushupNames = ["Pushups", "Spartan Pushups"]
}

public let seriesByLevelsTabs = ["2 - 2 - 2 - 2 - 3", "6 - 6 - 6 - 6 - 5", "12 - 12 - 11 - 10 - 10", "24 - 24 - 24 - 24 - 24"]
