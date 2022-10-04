//
//  Firebase.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 01/10/22.
//

import Foundation
import UIKit

class FirebaseConfiguratorEntryPoint: AppDelegationEntryPoint {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        registerForPushNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
    }
    
    private func registerForPushNotifications() {

    }
    
}


extension FirebaseConfiguratorEntryPoint: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
       let _ = response.notification.request.content.userInfo
       
       completionHandler()
   }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
       let _ = notification.request.content.userInfo
       completionHandler([[.alert, .sound]])
   }
}

extension FirebaseConfiguratorEntryPoint: SceneDelegationEntryPoint {}
