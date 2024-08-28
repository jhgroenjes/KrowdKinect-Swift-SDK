// The Swift Programming Language
// https://docs.swift.org/swift-book

// Swift SDK for KrowdKinect
//  Jason Groenjes   All rights reserved.     August 2024.



import SwiftUI
import UIKit


public class FullScreenViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    @StateObject var session = WebSocketController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        // Set up SwiftUI view in UIKit container
        let contentView = ContentView()
           // .edgesIgnoringSafeArea(.all)  // Ensure the SwiftUI view ignores safe areas
        let hostingController = UIHostingController(rootView: contentView)
        
        // Add the hosting controller as a child view controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        // Apply constraints to make the hostingController view fill the entire screen
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Add the triple-tap gesture recognizer
        let tripleTap = UITapGestureRecognizer(target: self, action: #selector(tripleTapped))
        tripleTap.numberOfTapsRequired = 3
        view.addGestureRecognizer(tripleTap)
        
        // Set the presentation controller delegate
        self.presentationController?.delegate = self
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
        
        // Exit Action
        let exitAction = UIAlertAction(title: "Exit", style: .destructive) { _ in
            self.dismiss(animated: true, completion: nil)
            self.session.ably.connection.close()
            print ("Ably connection closed")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(exitAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // Disable the down-swipe gesture to dismiss the view
    public func presentationControllerShouldDismiss(_ presentationController: UIPresentationController) -> Bool {
        return false
    }
}



public class KrowdKinectSDK {
    
    public static func presentFullScreen(from viewController: UIViewController) {
        let fullScreenVC = FullScreenViewController()
        fullScreenVC.modalPresentationStyle = .fullScreen  // Ensure full-screen presentation
        viewController.present(fullScreenVC, animated: true, completion: nil)
    }
}
