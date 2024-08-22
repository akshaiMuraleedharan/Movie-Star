//
//  SplashViewController.swift
//  MovieStar
//
//  Created by Subhosting's MacBook Pro on 22/08/24.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Customize the splash screen 
        view.backgroundColor = UIColor(named: "splashbg")
        let splashImage = UIImageView(image: UIImage(named: "clapboard"))
        splashImage.contentMode = .scaleAspectFit
        splashImage.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashImage)
        
        // Center the splash image in the view
        NSLayoutConstraint.activate([
            splashImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            splashImage.widthAnchor.constraint(equalToConstant: 300),
            splashImage.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        // Navigate to the main screen after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.showMainScreen()
        }
    }

    private func showMainScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = mainStoryboard.instantiateInitialViewController() {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = mainViewController
                window.makeKeyAndVisible()
            }
        }
    }
}
