//
//  CompositeEntryPoint.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 01/10/22.
//

import Foundation
import UIKit

public typealias AppDelegationEntryPoint = UIApplicationDelegate & UIResponder
public typealias SceneDelegationEntryPoint = UIWindowSceneDelegate

class CompositeEntryPoint: AppDelegationEntryPoint {
    
    private(set) var appDelegationEntryPoint: [AppDelegationEntryPoint] = []
    
    private var anySceneDelegationEntryPoint: [Any?] = []
    
    var sceneDelegationEntryPoint: [SceneDelegationEntryPoint] {
        anySceneDelegationEntryPoint.compactMap { $0 as? SceneDelegationEntryPoint }
    }
    
    init(appEntryPoints: [AppDelegationEntryPoint]) {
        self.appDelegationEntryPoint = appEntryPoints
    }
    
}

extension CompositeEntryPoint {
    
    convenience init(sceneEntryPoint: [SceneDelegationEntryPoint], appEntryPoints: [AppDelegationEntryPoint]) {
        self.init(appEntryPoints: appEntryPoints)
        self.anySceneDelegationEntryPoint = sceneEntryPoint
    }
}

extension CompositeEntryPoint {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        appDelegationEntryPoint.forEach { _ = $0.application?(application, didFinishLaunchingWithOptions: launchOptions) }
        
        return true
    }
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       
        appDelegationEntryPoint.forEach { _ = $0.application?(application, willFinishLaunchingWithOptions: launchOptions) }
        
        return true
    }
}

extension CompositeEntryPoint: SceneDelegationEntryPoint {
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        sceneDelegationEntryPoint.forEach { $0.scene?(scene, willConnectTo: session, options: connectionOptions) }
    }
}
