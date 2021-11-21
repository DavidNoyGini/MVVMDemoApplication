//
//  AlertBuilder.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 15/11/2021.
//

import UIKit

class AlertBuilder {
    
    //MARK: - Private var/let
    private var viewController: UIViewController?
    private var bakgroundEffect = UIVisualEffectView()
    private var activityIndicator = UIActivityIndicatorView(style: .large)
    private let blurEffect = UIBlurEffect(style: .light)
    private var alertHeight: CGFloat = 160.0
    private var existsedY:CGFloat = 160.0
    
    private let alertView: UIView =
    {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 17
        return alert
    }()
    
    //MARK: - Instance Methods
    func showAlert(title: String,
                   message: String,
                   viewController: UIViewController,
                   isActivityIndicatorVisible: Bool,
                   buttons: AlertButtonsState,
                   onOk: @escaping (() -> Void),
                   onCancel: @escaping (() -> Void))
    {
        self.viewController = viewController
                
        setBakgroundEffect(viewController: viewController)
        viewController.view.addSubview(alertView)
        viewController.view.bringSubviewToFront(alertView)
        
        checkSize(buttons: buttons)
        
        alertView.frame = CGRect(x: 40,
                                 y: -alertHeight,
                                 width: viewController.view.frame.size.width-80,
                                 height: alertHeight)
        
        alertView.backgroundColor = .systemGray6
        
        
        addTitle(title: title)
        addMessage(message: message)
        if isActivityIndicatorVisible
        {
            addIndicator()
        }

        addButtons(buttons: buttons, onOk: onOk, onCancel: onCancel)

        
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.25)
            { [weak self] in
                guard let self = self else {return}
                self.bakgroundEffect.isHidden = false
                self.alertView.center = viewController.view.center
            } completion: { [weak self] _ in
                guard let self = self else {return}
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
                                              height: self.alertHeight)
                self.activityIndicator.stopAnimating()
            } completion: { [weak self] _ in
                guard let self = self else {return}
                self.alertView.removeFromSuperview()
            }
        }
        
    }
    
    //MARK: - Private methods
    
    private func addButtons(buttons: AlertButtonsState,
                            onOk: @escaping (() -> Void),
                            onCancel: @escaping (() -> Void))
    {
        switch buttons {
        case .none:
            break
        case .okButton:
            let okButton = makeButton(title: "OK", style: .default)
            let okAction = UIAction { _ in
                onOk()
            }
            okButton.addAction(okAction, for: .touchUpInside)
            alertView.addSubview(okButton)
        case .cancelButton:
            let cancelButton = makeButton(title: "cancel", style: .cancel)
            let cancelAction = UIAction { _ in
                onCancel()
            }
            cancelButton.addAction(cancelAction, for: .touchUpInside)
            alertView.addSubview(cancelButton)
        case .bothButtons:
            let okButton = makeButton(title: "OK", style: .default)
            let okAction = UIAction { _ in
                onOk()
            }
            okButton.addAction(okAction, for: .touchUpInside)
            alertView.addSubview(okButton)
            
            let cancelButton = makeButton(title: "cancel", style: .cancel)
            let cancelAction = UIAction { _ in
                onCancel()
            }
            cancelButton.addAction(cancelAction, for: .touchUpInside)
            alertView.addSubview(cancelButton)
        }
    }
    
    private func checkSize(buttons: AlertButtonsState)
    {
        switch buttons {
        case .none:
            alertHeight = 160
        case .okButton,.cancelButton:
            alertHeight = 210
        case .bothButtons:
            alertHeight = 260
        }
    }

    private func makeButton(title: String, style: AlertActionStyle) -> UIButton
    {
        let button = UIButton(frame: CGRect(x: 0,
                                            y: existsedY,
                                            width: alertView.frame.size.width,
                                            height: 50))
        existsedY += 50
        button.setTitle(title, for: .normal)
        button.setTitleColor(style.getColorStyle(), for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.systemGray4.cgColor
        return button
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
                                               height: 60))
        titleLabel.text = title
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
    }
    
    private func addMessage(message: String)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0,
                                               y: 60,
                                               width: alertView.frame.size.width,
                                               height: 50))
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

enum AlertState: String {
    case error = "Error"
    case fetchData = "Fetching Data"
}

enum AlertActionStyle {
    case `default`
    case cancel
    
    func getColorStyle() -> UIColor
    {
        switch self {
        case .default:
            return .link
        case .cancel:
            return .red
        }
    }
}

enum AlertButtonsState {
    case none
    case okButton
    case cancelButton
    case bothButtons
}
