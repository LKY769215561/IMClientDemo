//
//  JZChatMessageTool.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/10.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit


class JZChatMessageTool {
    
    // 全局socket对象
    static  var clientSocket = GCDAsyncSocket()!
    

    class func connectToServer() {
    
       clientSocket.delegate = self
       clientSocket.delegateQueue = DispatchQueue.main
       try?  clientSocket.connect(toHost: "119.23.248.224", onPort: 9091)
        
    }
    
    class func disConnectToServer() {
        clientSocket.disconnect()
    }
    
    
    class func sendtext(text:String){
    
    }
    
    class func sendImage(text:UIImage) {
        
    }
    
    
    
    class  func sendData(sendData : Data, commandId : Int,client : GCDAsyncSocket) {
        
        var totalDataM = Data()
        
        var totalSize = 4 + 4 + (sendData as NSData).length
        let totalSizeData = Data(bytes: &totalSize, count: 4)
        
        // 1.拼接长度(0~3:长度)
        totalDataM.append(totalSizeData)
        
        var commandId = commandId
        let commandIdData = Data(bytes: &commandId, count: 4)
        
        // 2.拼接指令类型(4~7:指令)
        totalDataM.append(commandIdData)
        
        // 3.拼接图片(8~N) 图片数据
        totalDataM.append(sendData)
        client.write(totalDataM, withTimeout: -1, tag: 0)
    }
}

extension JZChatMessageTool : GCDAsyncSocketDelegate{



}


