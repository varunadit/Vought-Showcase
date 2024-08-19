//
//  SegmentTimer.swift
//  Vought Showcase
//
//  Created by Varun Adit on 8/17/24.
//

import Foundation
import Combine
import SwiftUI

/// Class to handle the Timer and Progress of segments
class SegmentTimer: ObservableObject {
    
    /// A @Published variable to publish the progress to observers
    @Published var progress: Double
    
    /// The time interval between segments
    private var interval: TimeInterval
    
    /// Number of segments in One Segment Group
    private var max: Int
    
    /// A cancellable to store the timer
    private var cancellable: AnyCancellable?
    
    /// A @Binding variable to dismiss the segments upon completing max segments
    @Binding var showSegments: Bool {
        didSet {
            if !showSegments {
                cancel()
            }
        }
    }
    
    /// Initializes a new SegmentedProgressBar with the specified number of segments and duration.
    /// - Parameters:
    ///   - items: The number of segments in the progress bar.
    ///   - interval: The duration of each segment's animation. Defaults to 5.0 seconds.
    init(items: Int, interval: TimeInterval, dismissSegment: Binding<Bool>) {
        self.max = items
        self.progress = 0
        self.interval = interval
        self._showSegments = dismissSegment
    }
    
    /// Starts the Timer Publisher and defines the logic for updating progress
    func start() {
        self.cancellable = Timer
            .publish(every: 0.01, on: .main, in: .default)
            .autoconnect()
            .sink{ [weak self]  _ in
                if let self = self {
                    var newProgress = self.progress + (0.01 / self.interval)
                    if Int(newProgress) >= self.max {
                        newProgress = 0
                        showSegments.toggle()
                        self.cancel()
                    }
                    self.progress = newProgress
                }
            }
    }
    
    /// Function to skip progress to next segment or rewind progress to previous segment
    func advance(by number: Int) {
        var newProgress = Int(self.progress) + number
        if newProgress >= self.max {
            cancel()
            showSegments = false
            return
        } else if newProgress < 1 {
            newProgress = 0
        }
        self.progress = Double(newProgress)
    }
    
    func cancel() {
        self.cancellable = nil
        self.progress = 0
    }
    
    func pause() {
        cancellable?.cancel()
    }
    
    func unpause() {
        self.cancellable = Timer.publish(every: 0.01, on: .main, in: .default).autoconnect().sink(receiveValue: {  _ in
            var newProgress = self.progress + (0.01 / self.interval)
            if Int(newProgress) >= self.max { newProgress = 0 }
            self.progress = newProgress
        })
    }
}
