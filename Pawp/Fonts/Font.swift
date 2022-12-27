//
//  Font.swift
//  Pawp
//
//  Created by Nathan Pabrai on 12/26/22.
//

import Foundation
import UIKit

fileprivate let defaultFontSize: CGFloat = 18

enum Font: String {
    case aeonikRegular = "AeonikTRIAL-Regular"
    case aeonikRegularItalic = "AeonikTRIAL-RegularItalic"
    case aeonikLight = "AeonikTRIAL-Light"
    case aeonikLightItalic = "AeonikTRIAL-LightItalic"
    case aeonikBold = "AeonikTRIAL-Bold"
    case aeonikBoldItalic = "AeonikTRIAL-BoldItalic"
    
    case objectiveRegular = "Objective-Regular"
    case objectiveMedium = "Objective-Medium"
    case objectiveBold = "Objective-Bold"
    
    var uifont: UIFont {
        return UIFont(name: self.rawValue, size: defaultFontSize)!
    }
}
