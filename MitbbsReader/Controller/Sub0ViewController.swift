//
//  Sub0ViewController.swift
//  MitbbsReader
//
//  Created by LXU on 2/7/19.
//  Copyright © 2019 LXU. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class Sub0ViewController: UIViewController {
    
    let baseURL = "https://www.mitbbs.com/bbsdoc/"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onPressBackToMainMenu(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onPressAwesomeJoke(_ sender: UIButton) {
        let url = baseURL + "AwesomeJoke.html"
        
        Alamofire.request(url).responseData { response in
            debugPrint("All Response Info: \(response)")
            let enc = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
            if let data = response.result.value, let html = String(data: data, encoding: enc) {
                //print("Data: \(html)")
                if let doc = try? HTML(html: html, encoding: .utf8) {
                    print(doc.title)
                    
//                    for row in doc.xpath("//td[@class='taolun_leftright']/table/tr/td") {
//                        print(row.text)
//                    }
                    
                    for title in doc.xpath("//td[@class='taolun_leftright']/table/tr/td/strong/a") {
                        if let trimmedString = title.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                            print(trimmedString)
                        }
                        print(title["href"])
                    }
                    
                }
            }
        }
        
        performSegue(withIdentifier: "goToAwesomeJoke", sender: self)
    }
}
