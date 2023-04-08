//
//  WelcomeViewController.swift
//  Spotify-Clone
//
//  Created by Haydar Demir on 1.10.2022.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let signInButton: UIButton = {
        let value = UIButton()
        value.backgroundColor = .white
        value.layer.masksToBounds = true
        value.layer.cornerRadius = 6
        value.setTitle("SignIn with Spotify", for: .normal)
        value.setTitleColor(.black, for: .normal)
        return value
    }()
    
    private let overlayView: UIView = {
        let value = UIView()
        value.backgroundColor = .black
        value.alpha = 0.7
        return value
    }()
    
    private let imageView: UIImageView = {
        let value = UIImageView()
        value.contentMode = .scaleAspectFill
        value.image = UIImage(named: "artwork")
        return value
    }()
    
    private let logoImageView: UIImageView = {
        let value = UIImageView(image: UIImage(named: "Logo"))
        value.contentMode = .scaleAspectFit
        return value
    }()
    
    private let label: UILabel = {
        let value = UILabel()
        value.numberOfLines = 0
        value.textAlignment = .center
        value.textColor = .white
        value.font = .systemFont(ofSize: 32, weight: .semibold)
        value.text = "Spotify Clone\nDeveloped by Birhos"
        return value
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        view.addSubview(label)
        view.addSubview(logoImageView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        overlayView.frame = view.bounds
        signInButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40, height: 50)
        logoImageView.frame = CGRect(x: (view.width-120)/2, y: (view.height-200)/2, width: 120, height: 120)
        label.frame = CGRect(x: 30, y: logoImageView.bottom+30, width: view.width-60, height: 150)
    }
    
    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.completionHandler = {[weak self]success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool){
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when signingIn", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVC = TabBarViewController()
        mainAppTabBarVC.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVC,animated: true)
    }
}
