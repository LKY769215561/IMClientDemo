//
//  JZProgressHUD.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/22.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit
import SVProgressHUD



class JZProgressHUD: NSObject {

    
    fileprivate static let sharedAlert = SweetAlert()
    
    class func setuoHUD() {
        
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor(white:0.0,alpha:0.8))
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
        SVProgressHUD.setMinimumDismissTimeInterval(2.0)
        
    }
    
    func show() {
        SVProgressHUD.show()
    }
    
    func showWithStatus(_ status : String){
        SVProgressHUD.show(withStatus: status)
    }
    
    func showInfoWithStatus(_ status : String) {
        SVProgressHUD.showInfo(withStatus: status)
    }
    
    class func showSuccessWithStatus(_ status: String) {
        SVProgressHUD.showSuccess(withStatus: status)
    }
    
    class func showErrorWithStatus(_ status: String) {
        SVProgressHUD.showError(withStatus: status)
    }
    
    class func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    class func basicMessageAlert(title:String) {
        _ = sharedAlert.showAlert(title)
    }
    class func subtitleAlert(title : String){
        _ = sharedAlert.showAlert(title, subTitle: "It's pretty, isn't it?", style: .none)
    }
    
    class func customAlert(title:String,subtitle:String,block:@escaping (Bool)->()) {
        _ = sharedAlert.showAlert(title, subTitle: subtitle, style: .warning, buttonTitle: "cancle", action: block)
    }
    
    class func warningAlert(title:String,subtitle:String,block:@escaping (Bool)->()) {
        _ = sharedAlert.showAlert(title, subTitle: subtitle, style: .warning, buttonTitle: "cancle", action: block)
    }
    
    
    
    
    
}
