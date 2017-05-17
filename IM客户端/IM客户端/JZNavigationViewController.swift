//
//  JZNavigationViewController.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/16.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit

class JZNavigationViewController: UINavigationController {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NSDictionary *style = @{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18.0f]};
//        [self.navigationBar setTitleTextAttributes:style];
//        self.interactivePopGestureRecognizer.delegate = self;
//        self.delegate = self;
        
       interactivePopGestureRecognizer?.delegate = self
       delegate = self
        
        
    }
    


}

extension JZNavigationViewController : UIGestureRecognizerDelegate{

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}

extension JZNavigationViewController : UINavigationControllerDelegate{

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        viewController.view.backgroundColor = UIColor.white
        
        if viewController.isKind(of: JZLoginViewController.superclass()!)
        {
            navigationController.setNavigationBarHidden(true, animated: false)
        }else
        {
           navigationController.setNavigationBarHidden(false, animated: false)
        }
        
        
        
        
    }
}

