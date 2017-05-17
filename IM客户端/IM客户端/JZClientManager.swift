
//
//  JZClientManager.swift
//  IM客户端
//
//  Created by 梁奎元 on 2017/5/16.
//  Copyright © 2017年 九章软件. All rights reserved.
//

import UIKit




class JZClientManager: NSObject {

    fileprivate  lazy var clientSocket : GCDAsyncSocket = {
     
           let socket = GCDAsyncSocket()!
           socket.delegateQueue = DispatchQueue.main
           socket.delegate = self
           return socket
    }()
    
    static let shared = JZClientManager()
    private override init() {
    }
    
    
    
    
    func connectToServer() {
        
        try?  clientSocket.connect(toHost: "119.23.248.224", onPort: 9091)
    }
    
    
    func disConnectToServer() {
        clientSocket.disconnect()
    }
    
}


extension JZClientManager : GCDAsyncSocketDelegate{

    // 与服务器连接成功
    func socket(_ clientSock: GCDAsyncSocket!, didConnectToHost host: String!, port: UInt16) {

        print("客户端连接已连接上服务器")

        NotificationCenter.default.post(name:NSNotification.Name(rawValue:CONNECTSERVER), object: nil)
        //  保证能接收到数据
        clientSock.readData(withTimeout: -1, tag: 0)
        
    }
    
    // 接收服务器响应的数据
    func socket(_ clientSock: GCDAsyncSocket!, didRead data: Data!, withTag tag: Int) {
        
        let responStr = JZChatMessageTool.responServerData(serverData: data)
        clientSock.readData(withTimeout: -1, tag: 0)
        
        print("\(responStr)")
    }
    
    
    // 与服务器连接断开
    func socketDidDisconnect(_ sock: GCDAsyncSocket!, withError err: Error!) {
        NotificationCenter.default.post(name:NSNotification.Name(rawValue:DIDCONNECTSERVER), object: nil)
        print("客户端连接已断开")
    }

}
