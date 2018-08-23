//
//  ExUIDevice.swift
//  WTFoundation
//
//  Created by sxq on 2018/4/26.
//  Copyright © 2018年 sxq. All rights reserved.
//

import Foundation

import UIKit

// Device Type
public enum Device {
    #if os(iOS)
    
    case iPodTouch5
    case iPodTouch6
    case iPhone4
    case iPhone4s
    case iPhone5
    case iPhone5c
    case iPhone5s
    case iPhone6
    case iPhone6Plus
    case iPhone6s
    case iPhone6sPlus
    case iPhone7
    case iPhone7Plus
    case iPhoneSE
    case iPhone8
    case iPhone8Plus
    case iPhoneX
    case iPad2
    case iPad3
    case iPad4
    case iPadAir
    case iPadAir2
    case iPad5
    case iPadMini
    case iPadMini2
    case iPadMini3
    case iPadMini4
    case iPadPro9Inch
    case iPadPro12Inch
    case iPadPro12Inch2
    case iPadPro10Inch
    #elseif os(tvOS)
    case appleTV4
    #endif
    indirect case simulator(Device)
    case unknown(String)
}

public enum Diagonal: Double {
    case unknown = -1
    case inch_3_5 = 3.5
    case inch_4 = 4
    case inch_4_7 = 4.7
    case inch_5_5 = 5.5
    case inch_5_8 = 5.8
    case inch_7_9 = 7.9
    case inch_9_7 = 9.7
    case inch_10_5 = 10.5
    case inch_12_9 = 12.9
}



public extension Extension where Base: UIDevice {

    public static var type: Device {
        return mapToDevice(identifier: identifier)
    }
    
    /// Gets the identifier from the system, such as "iPhone7,1".
    public static var identifier: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let mirror = Mirror(reflecting: systemInfo.machine)
        
        let identifier = mirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    /// - returns: An initialized `Device`.
    public static func mapToDevice(identifier: String) -> Device { // swiftlint:disable:this cyclomatic_complexity
        #if os(iOS)
        switch identifier {
        case "iPod5,1": return Device.iPodTouch5
        case "iPod7,1": return Device.iPodTouch6
        case "iPhone3,1", "iPhone3,2", "iPhone3,3": return Device.iPhone4
        case "iPhone4,1": return Device.iPhone4s
        case "iPhone5,1", "iPhone5,2": return Device.iPhone5
        case "iPhone5,3", "iPhone5,4": return Device.iPhone5c
        case "iPhone6,1", "iPhone6,2": return Device.iPhone5s
        case "iPhone7,2": return Device.iPhone6
        case "iPhone7,1": return Device.iPhone6Plus
        case "iPhone8,1": return Device.iPhone6s
        case "iPhone8,2": return Device.iPhone6sPlus
        case "iPhone9,1", "iPhone9,3": return Device.iPhone7
        case "iPhone9,2", "iPhone9,4": return Device.iPhone7Plus
        case "iPhone8,4": return Device.iPhoneSE
        case "iPhone10,4": return Device.iPhone8
        case "iPhone10,5": return Device.iPhone8Plus
        case "iPhone10,3": return Device.iPhoneX
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return Device.iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3": return Device.iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6": return Device.iPad4
        case "iPad4,1", "iPad4,2", "iPad4,3": return Device.iPadAir
        case "iPad5,3", "iPad5,4": return Device.iPadAir2
        case "iPad6,11", "iPad6,12": return Device.iPad5
        case "iPad2,5", "iPad2,6", "iPad2,7": return Device.iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6": return Device.iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9": return Device.iPadMini3
        case "iPad5,1", "iPad5,2": return Device.iPadMini4
        case "iPad6,3", "iPad6,4": return Device.iPadPro9Inch
        case "iPad6,7", "iPad6,8": return Device.iPadPro12Inch
        case "iPad7,1", "iPad7,2": return Device.iPadPro12Inch2
        case "iPad7,3", "iPad7,4": return Device.iPadPro10Inch
        case "i386", "x86_64": return Device.simulator(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))
        default: return Device.unknown(identifier)
        }
        #elseif os(tvOS)
        switch identifier {
        case "AppleTV5,3": return appleTV4
        case "i386", "x86_64": return simulator(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))
        default: return unknown(identifier)
        }
        #endif
    }
    
    /// Returns diagonal screen length in inches
    public static func xDiagonal(type: Device = type) -> Diagonal {
        switch type {
        case .iPodTouch5: return .inch_4
        case .iPodTouch6: return .inch_4
        case .iPhone4: return .inch_3_5
        case .iPhone4s: return .inch_3_5
        case .iPhone5: return .inch_4
        case .iPhone5c: return .inch_4
        case .iPhone5s: return .inch_4
        case .iPhone6: return .inch_4_7
        case .iPhone6Plus: return .inch_5_5
        case .iPhone6s: return .inch_4_7
        case .iPhone6sPlus: return .inch_5_5
        case .iPhone7: return .inch_4_7
        case .iPhone7Plus: return .inch_5_5
        case .iPhoneSE: return .inch_4
        case .iPhone8: return .inch_4_7
        case .iPhone8Plus: return .inch_5_5
        case .iPhoneX: return .inch_5_8
        case .iPad2: return .inch_9_7
        case .iPad3: return .inch_9_7
        case .iPad4: return .inch_9_7
        case .iPadAir: return .inch_9_7
        case .iPadAir2: return .inch_9_7
        case .iPad5: return .inch_9_7
        case .iPadMini: return .inch_7_9
        case .iPadMini2: return .inch_7_9
        case .iPadMini3: return .inch_7_9
        case .iPadMini4: return .inch_7_9
        case .iPadPro9Inch: return .inch_9_7
        case .iPadPro12Inch: return .inch_12_9
        case .iPadPro12Inch2: return .inch_12_9
        case .iPadPro10Inch: return .inch_10_5
        case .simulator(let model): return xDiagonal(type: model)
        case .unknown: return .unknown
        }
    }
}
