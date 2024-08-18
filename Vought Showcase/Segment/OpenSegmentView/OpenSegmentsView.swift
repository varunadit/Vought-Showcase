//
//  OpenSegmentsView.swift
//  Vought Showcase
//
//  Created by Varun Adit on 8/17/24.
//

import Foundation
import SwiftUI

struct OpenSegmentsView: View {
    
    @State var showSegments: Bool = false
    private var segmentItemProvider = SegmentDataSourceProvider()
    
    var body: some View {
        VStack(alignment: .center){
            Spacer()
            Button(action: {
                self.showSegments.toggle()
            }, label: {
                Label("Start", systemImage: "play.circle")
                    .padding(12)
                    .foregroundColor(.black)
                    .background(.yellow,
                                in: RoundedRectangle(cornerRadius: 12))
            })
            .padding(.bottom)
            .fullScreenCover(isPresented: $showSegments, content: {
                SegmentsView(
                    segmentTimer: SegmentTimer(
                        items: segmentItemProvider.items().count,
                        interval: 3, dismissSegment: $showSegments
                    ), items: segmentItemProvider.items(), showSegment: $showSegments
                )
            })
        }
    }
}

#Preview {
    OpenSegmentsView()
}
