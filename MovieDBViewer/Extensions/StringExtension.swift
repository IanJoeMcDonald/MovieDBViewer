//
//  StringExtension.swift
//  RESTfulManager
//
//  Created by Masipack Eletronica on 17/10/19.
//  Copyright © 2019 Masipack Eletronica. All rights reserved.
//

import Foundation

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable")
        -> String {
        return NSLocalizedString(self, tableName: tableName,
                                 value: "**\(self)**", comment: "")
    }
    
    init (asset: StringAssets) {
        self.init(asset.rawValue.localized())
    }
    
    init (nonLocalized asset: StringAssets) {
        self.init(asset.rawValue)
    }
    
    init (JSON asset: JSONAssets) {
        self.init(asset.rawValue)
    }
    
    init (Error asset: ErrorAssets) {
        self.init(asset.rawValue.localized())
    }
}
