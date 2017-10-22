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
    
    
    @IBOutlet weak var tbvmessage: UITableView!
    var arrdata:Array<String>=[]
    @IBOutlet weak var txtout: UITextField!
    
    @IBOutlet weak var txtin: UITextField!
    
    let socket = SocketIOClient(socketURL: URL(string: "http://\(ip):2017")!, config: [.log(true), .compress])
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // CONNECT to HOST
        socket.connect()
        tbvmessage.delegate=self
        tbvmessage.dataSource=self
        socket.on("Data") { (data, ack) in
            print(data)
            self.txtout.text=data[0] as! String
            let s:String=data[0] as! String
            self.arrdata.append(s)
            self.tbvmessage.reloadData()
            
        }
        
        
    }

    @IBAction func send(_ sender: Any) {
        if (txtin.text != ""){
            socket.emit("Name", with: [txtin.text!])
        }
        txtin.resignFirstResponder()
        txtin.text=""
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
extension ViewController: UITableViewDelegate,UITableViewDataSource
{

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return arrdata.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell=tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text=arrdata[indexPath.row]
    return cell
}

}
