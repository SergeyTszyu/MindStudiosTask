//
//  AppDelegate.swift
//  MindStudiosTask
//
//  Created by Sergey Tszyu on 22.06.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

import UIKit
import Alamofire
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var manager: DataManager = DataManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        DataManager.sharedManager().saveContext()
    }


}

