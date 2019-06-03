//
//  DeviceProperties.swift
//  SpartanPushUps
//
//  Created by Rijad Babovic on 03/06/2019.
//  Copyright © 2019 Rijad Babovic. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

enum Device {
    case iPhone2G3G4G
    case iPhone4
    case iPhone5orSE
    case iPhone678
    case iPhone678plus
    case iPhoneXandXs
    case iPhoneXsMax
    case iPhoneXr
    case unknown
}

class DeviceProperty {
    
    static let model: String = UIDevice.current.model
    static let name: String = UIDevice.current.name
    static let os: String = UIDevice.current.systemName
    static let version: String = UIDevice.current.systemVersion
    
    
    ///
    struct screen {
        /// current display height by orientation
        static var height: CGFloat {
            get {
                return UIScreen.main.bounds.height
            }
        }
        
        
        /// current display width  by orientation
        static var width: CGFloat {
            get {
                return UIScreen.main.bounds.width
            }
        }
        
        
        
        ///
        static var vertical: Bool {
            get {
                if width < height {
                    return true
                }
                return false
            }
        }
    }
    
    
    /// Returns screen type
    ///
    /// - Returns: enum Device
    static func type() -> Device {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 480:
                return Device.iPhone2G3G4G
            case 960:
                return Device.iPhone4
            case 1136:
                return Device.iPhone5orSE
            case 1334:
                return Device.iPhone678
            case 1920, 2208:
                return Device.iPhone678plus
            case 2436:
                return Device.iPhoneXandXs
            case 2688:
                return Device.iPhoneXsMax
            case 1792:
                return Device.iPhoneXr
            default:
                return Device.unknown
            }
        }
        return Device.unknown
    }
    
    
    /// returns true if device from X Family
    ///
    /// - Returns: Bool
    static func isTypeX() -> Bool {
        let type = DeviceProperty.type()
        switch type {
        case .iPhoneXandXs, .iPhoneXr, .iPhoneXsMax:
            return true
        default:
            return false
        }
    }
    
    
    /// SE device indicator
    /// returns true if the device is SE
    /// - Returns: Bool
    static func isSE() -> Bool {
        let type = DeviceProperty.type()
        if type == .iPhone5orSE {
            return true
        }
        return false
    }
    
    
    /// ipad indicator
    static var ipad: Bool {
        get {
            if DeviceProperty.type() == .unknown {
                return true
            }
            return false
        }
    }
}


enum Vibration {
    case error
    case success
    case warning
    case light
    case medium
    case heavy
    case selection
    case oldSchool
    
    func vibrate() {
        
        switch self {
        case .error:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case .success:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case .warning:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case .light:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case .medium:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case .heavy:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        case .selection:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            
        case .oldSchool:
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        }
    }
}

