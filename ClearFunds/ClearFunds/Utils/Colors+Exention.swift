//
//  Colors+Exention.swift
//  ClearFunds
//
//  Created by Floris, Giulia on 10/11/2026.
//

import SwiftUI

extension Color {
    
    static func background() -> Color {
        
        let monthInt = Calendar.current.component(.month, from: Date())
        
        switch monthInt {
            
            // spring
        case 3, 4, 5:
            return Color(red: 247/255, green: 237/255, blue: 226/255)
            // summer
        case 6, 7, 8:
            return Color(red: 217/255, green: 202/255, blue: 179/255)
            // fall
        case 9, 10, 11:
            return Color(red: 254/255, green: 250/255, blue: 224/255)
            // winter
        case 12, 1, 2:
            return Color(red: 202/255, green: 240/255, blue: 248/255)
        default:
            return .white
            
        }
    }
    
    static func primary() -> Color {
        let monthInt = Calendar.current.component(.month, from: Date())
        
        switch monthInt {
            
            // spring
        case 3, 4, 5:
            return Color(red: 246/255, green: 189/255, blue: 96/255)
            
            // summer
        case 6, 7, 8:
            return Color(red: 94/255, green: 11/255, blue: 21/255)
            // fall
        case 9, 10, 11:
            return Color(red: 40/255, green: 54/255, blue: 24/255)
            // winter
        case 12, 1, 2:
            return Color(red: 3/255, green: 4/255, blue: 94/255)
        default:
            return .white
            
        }
    }
}
