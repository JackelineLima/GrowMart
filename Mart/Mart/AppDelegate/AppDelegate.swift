//
//  AppDelegate.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 20/08/22.
//

import UIKit

let appDelegate = UIApplication.shared.delegate as? AppDelegate

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let appDelegateEntryPoint = EntryPointFactory.makeEntryPoints()
    
    var startupEntryPoint: StartupConfiguratorEntryPoint? {
        if #available(iOS 13, *) {
            guard let firstEntryPoint = appDelegateEntryPoint.sceneDelegationEntryPoint.first(where: { $0 is StartupConfiguratorEntryPoint }),
                  let startupEntryPoint = firstEntryPoint as? StartupConfiguratorEntryPoint
            else {
                return nil
            }

            return startupEntryPoint
        }

        guard let firstEntryPoint = appDelegateEntryPoint.appDelegationEntryPoint.first(where: { $0 is StartupConfiguratorEntryPoint }),
              let startupEntryPoint = firstEntryPoint as? StartupConfiguratorEntryPoint
        else {
            return nil
        }

        return startupEntryPoint
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        _ = appDelegateEntryPoint.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return appDelegateEntryPoint.application(application, willFinishLaunchingWithOptions: launchOptions)
    }

}
