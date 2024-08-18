//
//  ViewController.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initCarouselView()
    }
    
    private func initCarouselView() {
        // Create a carousel item provider
        let carouselItemProvider = CarouselItemDataSourceProvider()
        
        // Create segmentViewController
        let segmentViewController = UIHostingController(rootView: OpenSegmentsView())
        
        // Add segmentViewController in container view
        add(asChildViewController: segmentViewController, containerView: containerView)
        
        setupUI()
        
        // Function to setup constraints for segmentViewController
        func setupUI() {
            
            segmentViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                segmentViewController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                segmentViewController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                segmentViewController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                segmentViewController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])

        }
    }
    
}

#Preview{
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
    return vc
}
