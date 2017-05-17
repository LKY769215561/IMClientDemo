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
    

//    class func connectToServer() {
//    
//       clientSocket.delegate = self
//       clientSocket.delegateQueue = DispatchQueue.main
//       try?  clientSocket.connect(toHost: "119.23.248.224", onPort: 9091)
//        
//    }
    

    
    
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
    
    class func responServerData(serverData : Data) -> String {
        
        
        var totalSize = 0
        var commandId = 0
        var result = 0
        
        
        (serverData as NSData).getBytes(&totalSize, range: NSMakeRange(0, 4))
        (serverData as NSData).getBytes(&commandId, range: NSMakeRange(4, 4))
        (serverData as NSData).getBytes(&result, range: NSMakeRange(8, 4))
        
        
        var responStr = ""
        
        if commandId == 0x00000001 {
            responStr = "图片"
        }else if commandId == 0x00000002{
            responStr = "文字"
        }
        
        if result == 1
        {
            responStr.append("上传成功")
        }else
        {
            responStr.append("上传失败")
        }
        
        return responStr
        
    }
    
    
}

extension JZChatMessageTool : GCDAsyncSocketDelegate{



}


