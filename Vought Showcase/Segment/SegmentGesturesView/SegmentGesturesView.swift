//
//  SegmentGestures.swift
//  Vought Showcase
//
//  Created by Varun Adit on 8/18/24.
//

import Foundation
import SwiftUI

/// SwiftUI clear view specifically to handle the gestures on the segments
struct SegmentsGestureView: View {
    @ObservedObject var segmentTimer: SegmentTimer
    @State private var curentDragOffsetY: CGFloat = 0
    @Binding var dismissSegment: Bool

    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            
            /// View to handle taps on left side of the screen
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.segmentTimer.advance(by: -1)
                }
            
            /// View to handle taps on the right side of the screen
            Rectangle()
                .foregroundColor(.clear)
                .contentShape(Rectangle())
                .onTapGesture {
                    self.segmentTimer.advance(by: 1)
                }
        }
        .gesture(
            
            /// Drag gesture to detect down swipe in order to dismiss the segments
            DragGesture()
                .onChanged{ value in
                    withAnimation(.spring) {
                        curentDragOffsetY = value.translation.height
                    }
                }
                .onEnded{ value in
                    withAnimation(.spring) {
                        if curentDragOffsetY > 100 {
                            curentDragOffsetY = 0
                            dismissSegment = false
                        } else {
                            curentDragOffsetY = 0
                        }
                    }
                }
        )
        
    }
}
