//
//  AppDelegate.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/10.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
        
  
        setupRootVC()
        setupGlobalStyle()
        
    
        return true
    }


    
    func setupRootVC()  {
        window = UIWindow(frame:UIScreen.main.bounds)
        let rootVC = UIStoryboard(name: "JZLoginViewController", bundle:Bundle.main).instantiateInitialViewController()!
        window?.rootViewController = JZNavigationViewController(rootViewController: rootVC)
        window?.makeKeyAndVisible()
        
    }
    
    func setupGlobalStyle() {
        
        JZProgressHUD.setuoHUD()
        
    }


}

