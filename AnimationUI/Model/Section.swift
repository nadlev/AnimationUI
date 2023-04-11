//
//  Section.swift
//  AnimationUI
//
//  Created by Надежда Левицкая on 4/11/23.
//

import SwiftUI

enum Section: String, CaseIterable {
    case search = "CuriousRobot"
    case delete = "SadRobot"
    case account = "HappyRobot"
    case explore = "TranslatorRobot"
    case call = "SmartRobot"
    
    var index: CGFloat {
        return CGFloat(Section.allCases.firstIndex(of: self) ?? 0)
    }
    
    static var count: CGFloat {
        return CGFloat(Section.allCases.count)
    }
}
