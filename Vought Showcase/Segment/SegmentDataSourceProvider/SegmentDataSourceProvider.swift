//
//  SegmentDataSourceProvider.swift
//  Vought Showcase
//
//  Created by Varun Adit on 8/17/24.
//

import Foundation
import SwiftUI

class SegmentDataSourceProvider: SegmentDataSourceProviderContracts {
    func items() -> [String] {
        return [
        "butcher",
        "frenchie",
        "hughei",
        "mm"
        ]
    }
}
