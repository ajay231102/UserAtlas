//
//  SettingsViewController.swift
//  Users Directory
//
//  Created by Ajay Gadwal on 14/03/26.
//

import Foundation
import UIKit

extension String {
    var length: Int {self.count}
    
    func substring(_ from: Int) -> String? {
        guard (from >= 0) && (self.count > from) else { return nil }
        
        let index = self.index(self.startIndex, offsetBy: from)
        return String(self[index...])
    }
}
