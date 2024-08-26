// The Swift Programming Language
// https://docs.swift.org/swift-book

// Swift SDK for KrowdKinect
//  Jason Groenjes   All rights reserved.     August 2024.



import SwiftUI
import UIKit

public class FullScreenViewController: UIViewController {
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Set up SwiftUI view in UIKit container
        let contentView = ContentView()
            .edgesIgnoringSafeArea(.all)  // Make sure the SwiftUI view ignores safe areas
        let hostingController = UIHostingController(rootView: contentView)
        
        // Add the hosting controller as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.frame = view.bounds
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)

        // Add the triple-tap gesture recognizer
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
        tripleTap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTap)
    }
    
    override public var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override public var shouldAutorotate: Bool {
        return false
    }
    
    @objc private func tripleTapped() {
        presentExitConfirmation()
    }
    
    private func presentExitConfirmation() {
        let alertController = UIAlertController(title: "Confirm Exit", message: "Do you really want to exit?", preferredStyle: .alert)
        
        // Cancel Action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        // End Action
        let exitAction = UIAlertAction(title: "End", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
    }
}


public class KrowdKinectSDK {
    
    public static func presentFullScreen(from viewController: UIViewController) {
        let fullScreenVC = FullScreenViewController()
        viewController.present(fullScreenVC, animated: true, completion: nil)
    }
}
