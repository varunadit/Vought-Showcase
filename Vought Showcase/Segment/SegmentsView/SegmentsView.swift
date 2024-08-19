//
//  SegmentsView.swift
//  Vought Showcase
//
//  Created by Varun Adit on 8/17/24.
//

import SwiftUI

/// A SwiftUI View to present the Segments and Progress Bar
struct SegmentsView: View {
    
    @ObservedObject var segmentTimer: SegmentTimer
    var items: [String]
    @Binding var showSegment: Bool
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack(alignment: .top) {
                    Image(self.items[Int(self.segmentTimer.progress)])
                        .resizable()
                        .ignoresSafeArea()
                        .scaledToFill()
                        .frame(width: proxy.size.width, alignment: .center)
                        .animation(.none, value: 0)
                
                /// HStack to handle the Layout of the progress bars
                HStack(alignment: .center, spacing: 4) {
                    ForEach(self.items.indices) { idx in
                        SegmentProgressBar(
                            progress: min( 
                                max((CGFloat(self.segmentTimer.progress) - CGFloat(idx)), 0.0),
                                1.0
                            )
                        )
                        .frame(height: 2, alignment: .leading)
                        .animation(.linear, value: 0.5)
                    }
                }
                .padding()
                
                SegmentsGestureView(
                    segmentTimer: segmentTimer,
                    dismissSegment: $showSegment
                )
                    
            }
            .onAppear {
                self.segmentTimer.start()
            }
            .onDisappear {
                self.segmentTimer.cancel()
            }
        }
    }
}

struct BindingSegmentsView : View {
    @State
    private var value = false
    
    @State private var dismissSegment = false
    
    var body: some View {
        SegmentsView(
            segmentTimer: SegmentTimer (
                items: SegmentDataSourceProvider().items().count,
                interval: 3.0, dismissSegment: $value
            ),
            items: SegmentDataSourceProvider().items(),
            showSegment: $dismissSegment
        )
    }
}


#Preview {
    BindingSegmentsView()
}
