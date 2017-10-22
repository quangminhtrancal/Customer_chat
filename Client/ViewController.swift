//
//  ViewController.swift
//  Client
//
//  Created by Minh on 2017-10-14.
//  Copyright © 2017 Minh. All rights reserved.
//

import UIKit
import SocketIO

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtout: UITextField!
    
    @IBOutlet weak var txtin: UITextField!
    
    let socket = SocketIOClient(socketURL: URL(string: "http://\(ip):2017")!, config: [.log(true), .compress])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // CONNECT to HOST
        socket.connect()
        
        socket.on("Data") { (data, ack) in
            print(data)
            self.txtout.text=data[0] as! String
            
        }
        
    }

    @IBAction func send(_ sender: Any) {
        if (txtin.text != ""){
            socket.emit("Name", with: [txtin.text!])
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

