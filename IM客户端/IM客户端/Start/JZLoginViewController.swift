//
//  JZLoginViewController.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/16.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit

// A delay function
func delay(_ seconds: Double, completion: @escaping ()->Void) {
    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(Int(seconds * 1000.0))) {
        completion()
    }
}


class JZLoginViewController: UIViewController {

    // MARK: IB outlets
    

    
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var cloud1: UIImageView!
    @IBOutlet var cloud2: UIImageView!
    @IBOutlet var cloud3: UIImageView!
    @IBOutlet var cloud4: UIImageView!
    
    // MARK: further UI
    
    let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let status = UIImageView(image: UIImage(named: "banner"))
    let label = UILabel()
    let messages = ["Connecting ...", "Authorizing ...", "Sending credentials ...", "Failed"]
    
    var statusPosition = CGPoint.zero
    
    // MARK: view controller methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up the UI
        loginButton.layer.cornerRadius = 8.0
        loginButton.layer.masksToBounds = true
        
        spinner.frame = CGRect(x: -20.0, y: 6.0, width: 20.0, height: 20.0)
        spinner.startAnimating()
        spinner.alpha = 0.0
        loginButton.addSubview(spinner)
        
        status.isHidden = true
        status.center = loginButton.center
        view.addSubview(status)
        
        label.frame = CGRect(x: 0.0, y: 0.0, width: status.frame.size.width, height: status.frame.size.height)
        label.font = UIFont(name: "HelveticaNeue", size: 18.0)
        label.textColor = UIColor(red: 0.89, green: 0.38, blue: 0.0, alpha: 1.0)
        label.textAlignment = .center
        status.addSubview(label)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x  -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
        
        cloud1.alpha = 0.0
        cloud2.alpha = 0.0
        cloud3.alpha = 0.0
        cloud4.alpha = 0.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.5) {
            self.heading.center.x += self.view.bounds.width
        }
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [],
                       animations: {
                        self.username.center.x += self.view.bounds.width
        },
                       completion: nil
        )
        UIView.animate(withDuration: 0.5, delay: 0.4, options: [],
                       animations: {
                        self.password.center.x += self.view.bounds.width
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [],
                       animations: {
                        self.cloud1.alpha = 1.0
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: [],
                       animations: {
                        self.cloud2.alpha = 1.0
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 0.9, options: [],
                       animations: {
                        self.cloud3.alpha = 1.0
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 0.5, delay: 1.1, options: [],
                       animations: {
                        self.cloud4.alpha = 1.0
        },
                       completion: nil
        )
    }
    
    // MARK: further method
    @IBAction func login() {
       
        
        if (username.text! as NSString).length == 0 ||
          (password.text! as NSString).length == 0
        {
            JZProgressHUD.basicMessageAlert(title: "账户或密码不能为空!")
            return
        }
        
        guard let account = username.text else {
             JZProgressHUD.basicMessageAlert(title: "账户不能为空!")
            return
        }
        guard let password = password.text else {
             JZProgressHUD.basicMessageAlert(title: "密码不能为空!")
            return
        }
        
        let loginURL = BASE_URL.appending("/login?phone=\(account)&password=\(password)")

        JZNetworkTool.shareNetworkTool.get(loginURL, params: nil, success: { (json) in
            
            print(json)
            
            let msg = (json.dictionary?["msg"])?.string
            
            guard let message = msg else
            {
              return
            }
            
            JZProgressHUD.showSuccessWithStatus(message)
            
            
        }) { (error) in
              print(error)
        }
        
        
        
        JZClientManager.shared.connectToServer()

        
        let  initialCount = 0
        let  pageSize = 50
        
        var dataSource: FakeDataSource?
//        if segue.identifier == "0 messages" {
//            initialCount = 0
//        } else if segue.identifier == "2 messages" {
//            initialCount = 2
//        } else if segue.identifier == "10000 messages" {
//            initialCount = 10000
//        } else if segue.identifier == "overview" {
//            dataSource = FakeDataSource(messages: TutorialMessageFactory.createMessages(), pageSize: pageSize)
//        } else {
//            assert(false, "segue not handled!")
//        }
        
//        let chat2Controller = { () -> DemoChatViewController? in
//            if let controller = segue.destination as? DemoChatViewController {
//                return controller
//            }
//            if let tabController = segue.destination as? UITabBarController,
//                let controller = tabController.viewControllers?.first as? DemoChatViewController {
//                return controller
//            }
//            return nil
//            }()!
        
        let chatController = DemoChatViewController()
        
        if dataSource == nil {
            dataSource = FakeDataSource(count: initialCount, pageSize: pageSize)
        }
        
        guard let dataSource2 = dataSource else {
            return
        }
        
        chatController.dataSource = dataSource2
        chatController.messageSender = dataSource2.messageSender

        navigationController?.pushViewController(chatController, animated: true)
        
    }
    
 
    @IBAction func register(_ sender: Any) {
        
        JZProgressHUD.showSuccessWithStatus("注册成功")
        
    }
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextField = (textField === username) ? password : username
        nextField?.becomeFirstResponder()
        return true
    }
    

}
