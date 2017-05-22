//
//  JZNetworkTool.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/22.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

typealias NetworkFinished = (_ success : Bool,_ result:JSON?,_ error : NSError?)->()
class JZNetworkTool: NSObject {

    /// 网络工具类单例
    static let shareNetworkTool = JZNetworkTool()
}

extension JZNetworkTool{


    func get(_ urlString: String,params: [String : Any]?,success: @escaping (_ response : JSON) -> (), failure: @escaping (_ error : Error) ->()) {
        
        Alamofire.request(urlString, method: .get, parameters: params, headers: nil).responseJSON { (reSponse) in
            self.handle(response: reSponse, success: success, failure: failure)
        }
        
    }
    
    func post(_ urlString : String,param : [String : Any]?,success : @escaping (_ response : JSON)->(),failurl : @escaping (_ error : Error) ->()) {
        
        Alamofire.request(urlString, method: .post, parameters: param).responseJSON { (reSponse) in
            
            self.handle(response: reSponse, success: success, failure: failurl)
        }
        
        
    }
    
   fileprivate   func handle(response : DataResponse<Any>,success : (_ resonse : JSON)->(),failure:(_ error : Error)->()) {
        
        switch response.result {
        case .success(let value):
            success(JSON(value))
        case .failure(let error):
            failure(error)
        }
        
    }
    
        
        

}
