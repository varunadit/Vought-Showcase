//
//  SegmentProgressBar.swift
//  Vought Showcase
//
//  Created by Varun Adit on 8/17/24.
//

import Foundation
import SwiftUI

/// UI for the animation of the progress of each segment from start to completion
struct SegmentProgressBar: View {
    
    /// A variable to fill used to track and fill the progress of a segment
    var progress: CGFloat
    
    var body: some View {
        
        /// Geometry reader proxy used to more easily deal with progress bar fill animation
        GeometryReader { proxy in
            
            /// ZStack for the Layout of the two indicators of progress
            ZStack(alignment: .leading) {
                
                ///  1. Grey for remaining progress
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.3))
                    .cornerRadius(5)
                
                ///  2. White for completed progress
                Rectangle()
                    .frame(width: proxy.size.width * self.progress, alignment: .leading)
                    .foregroundColor(Color.white.opacity(0.9))
                    .cornerRadius(5)
            }
        }
    }
}
