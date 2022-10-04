//
//  EntryPointFactory.swift
//  Mart
//
//  Created by Jackeline Pires De Lima on 01/10/22.
//

import Foundation

enum EntryPointFactory {
    static func makeEntryPoints() -> CompositeEntryPoint {
        let firebase = FirebaseConfiguratorEntryPoint()
        let startup = StartupConfiguratorEntryPoint()
        
        let listAppEntryPoint: [AppDelegationEntryPoint] = [
            firebase,
            startup
        ]
        
        if #available(iOS 13, *) {
            let listSceneEntryPoint: [SceneDelegationEntryPoint] = [
                firebase,
                startup
            ]
            return CompositeEntryPoint(
                sceneEntryPoint: listSceneEntryPoint,
                appEntryPoints: listAppEntryPoint
            )
        }
        return CompositeEntryPoint(appEntryPoints: listAppEntryPoint)
    }
}
