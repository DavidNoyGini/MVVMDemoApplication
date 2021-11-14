//
//  AppDelegate.swift
//  MVVMDemoApplication
//
//  Created by David Noy on 03/11/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        launchInitialScreen()
        return true
    }
    
    private func launchInitialScreen()
    {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navVC = UINavigationController()
        
        let router = MainRouter()
        router.navigationController = navVC
        
        window?.rootViewController = navVC
        window?.makeKeyAndVisible()
        
        router.start()
    }
    
}

