//
//  AlertBuilder.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 15/11/2021.
//

import UIKit

class AlertBuilder {
    
    private var viewController: UIViewController?
    private var bakgroundEffect = UIVisualEffectView()
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let blurEffect = UIBlurEffect(style: .light)
    
    private let alertView: UIView =
    {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 17
        return alert
    }()
    
    func showAlert(title: String,
                   message: String,
                   viewController: UIViewController,
                   shouldIndicate: Bool)
    {
        
        self.viewController = viewController
                
        setBakgroundEffect(viewController: viewController)
        viewController.view.addSubview(alertView)
        viewController.view.bringSubviewToFront(alertView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -160,
                                 width: viewController.view.frame.size.width-80,
                                 height: 160)
        
        alertView.backgroundColor = .systemGray6
        
        
        addTitle(title: title)
        addMessage(message: message)
        if shouldIndicate
        {
            addIndicator()
        }
        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25)
            { [weak self] in
                guard let self = self else {return}
                self.bakgroundEffect.isHidden = false
            } completion: { [weak self] _ in
                guard let self = self else {return}
                self.alertView.center = viewController.view.center
                self.activityIndicator.startAnimating()
            }
        }
        
    }
    
    func dimissAlert()
    {
        guard let viewController = viewController else {return}

        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25)
            { [weak self] in
                guard let self = self else {return}
                self.bakgroundEffect.isHidden = true
                self.alertView.frame = CGRect(x: 40,
                                              y: viewController.view.frame.size.height,
                                              width: viewController.view.frame.size.width-80,
                                              height: 160)
                self.activityIndicator.stopAnimating()
            } completion: { [weak self] _ in
                guard let self = self else {return}
                self.alertView.removeFromSuperview()
            }
        }
        
    }
    
    private func setBakgroundEffect(viewController: UIViewController)
    {
        bakgroundEffect = UIVisualEffectView(frame: viewController.view.frame)
        bakgroundEffect.effect = blurEffect
        viewController.view.addSubview(bakgroundEffect)
    }
    
    private func addTitle(title: String)
    {
        let titleLabel = UILabel(frame: CGRect(x: 0,
                                               y: 0,
                                               width: alertView.frame.size.width,
                                               height: 50))
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
    }
    
    private func addMessage(message: String)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                               y: 50,
                                               width: alertView.frame.size.width,
                                               height: 60))
        messageLabel.numberOfLines = 0
        messageLabel.text = message
        messageLabel.font = messageLabel.font.withSize(20)
        messageLabel.textAlignment = .center
        alertView.addSubview(messageLabel)
    }
    
    private func addIndicator()
    {
        activityIndicator.frame = CGRect(x: 0,
                                         y: 110,
                                         width: alertView.frame.size.width,
                                         height: 50)

        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .red
        alertView.addSubview(activityIndicator)
        
    }
}
