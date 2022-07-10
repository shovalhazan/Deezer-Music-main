//
//  Int+Extension.swift
//  Music
//
//  Created by Shoval Hazan on 08/07/2022.
//

import Foundation

extension Int32 {
    
    var formattedTimeFromSeconds: String {
        let seconds: Int32 = self % 60
        let minutes: Int32 = (self / 60) % 60
        let hours: Int32 = self / 3600
        return String(format: "%02d:%02d:%02d", hours,minutes,seconds)
    }
}
