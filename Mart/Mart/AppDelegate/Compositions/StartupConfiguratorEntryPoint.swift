//
//  a.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 01/10/22.
//

import Foundation
import UIKit

class StartupConfiguratorEntryPoint: AppDelegationEntryPoint {
    
    var window: UIWindow?
    var applicationCoordinator: ApplicationCoordinator?
}

extension StartupConfiguratorEntryPoint {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        start()
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {

        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {

        return true
    }
    
    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    private func start() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let appCoordinator = ApplicationCoordinator(window: window ?? UIWindow())
        self.applicationCoordinator = appCoordinator
        appDelegate?.window = window
        applicationCoordinator?.start()
    }
}

extension StartupConfiguratorEntryPoint: SceneDelegationEntryPoint {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        start(scene: scene)
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        
    }
    
    private func start(scene: UIScene) {
        guard let windowScene = scene as? UIWindowScene else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        let appCoordinator = ApplicationCoordinator(window: window ?? UIWindow())
        window?.windowScene = windowScene
        appDelegate?.window = window
        self.applicationCoordinator = appCoordinator
        applicationCoordinator?.start()
    }
}

// MARK: UNUserNotificationCenterDelegate

extension StartupConfiguratorEntryPoint: UNUserNotificationCenterDelegate {}
