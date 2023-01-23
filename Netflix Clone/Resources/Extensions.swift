//
//  Extensions.swift
//  Netflix Clone
//
//  Created by 김준혁 on 2023/01/23.
//

import Foundation


extension String {
    func capitalizeFirstletter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
    // -> only capitalize the first one 
}
