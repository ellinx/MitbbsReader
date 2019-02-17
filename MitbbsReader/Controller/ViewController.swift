//
//  ViewController.swift
//  MitbbsReader
//
//  Created by LXU on 1/27/19.
//  Copyright © 2019 LXU. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //getTop();
    }


    func getTop() {
        let url = "https://www.mitbbs.com/mitbbs_bbssec.php";
        
//        Alamofire.request(url).responseString { response in
//            print("Success: \(response.result.isSuccess)")
//            print("Response String: \(response.result.value ?? "no data!")")
//
//        }
        
        Alamofire.request(url).responseData { response in
            debugPrint("All Response Info: \(response)")
            let enc = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
            if let data = response.result.value, let text = String(data: data, encoding: enc) {
                print("Data: \(text)")
            }
        }

    }
    
    @IBAction func onPressSub0(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSub0", sender: self)
    }
    
}

