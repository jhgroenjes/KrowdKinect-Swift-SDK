
// Swift SDK for KrowdKinect
//  Jason Groenjes   All rights reserved.     August 2024.



import SwiftUI
import UIKit


public class FullScreenViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    var options: KKOptions?
    
    public init(options: KKOptions) {
        self.options = options
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        guard let options = self.options else { return }
        let contentView = ContentView(options: options)  // Pass host app options to ContentView
        let hostingController = UIHostingController(rootView: contentView)
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
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
            //self.session.disconnectFromAbly()
            //print ("Ably connection closed via Exit button action")
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
   
    public static func launch(from viewController: UIViewController, with options: KKOptions) {
        let fullScreenVC = FullScreenViewController(options: options)
        fullScreenVC.modalPresentationStyle = .fullScreen
        viewController.present(fullScreenVC, animated: true, completion: nil)
    }
}



