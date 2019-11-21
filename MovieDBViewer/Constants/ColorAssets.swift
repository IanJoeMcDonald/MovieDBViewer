//
//  ColorAssets.swift
//  MovieDBViewer
//
//  Created by Ian McDonald on 15/09/19.
//  Copyright © 2019 Ian McDonald. All rights reserved.
//

import Foundation


enum BaseColors : UInt32 {
    case celadonBlue = 0x0081A7FF
    case maximumBlueGreen = 0x00AFB9FF
    case lightYellow = 0xFDFCDCFF
    case peachPuff = 0xFED9B7FF
    case bittersweet = 0xF07167FF
}

enum ColorAssets : UInt32 {
    
    case background
    case outline
    case text
    case selection
    
    var rawValue: UInt32 {
        switch self {
        case .background:
            return BaseColors.maximumBlueGreen.rawValue
        case .outline:
            return BaseColors.celadonBlue.rawValue
        case .text:
            return BaseColors.peachPuff.rawValue
        case .selection:
            return BaseColors.peachPuff.rawValue
        }
    }
}
