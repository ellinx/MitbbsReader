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
        var tieziList = [TieziInfo]()
        
        Alamofire.request(url).responseData { response in
            debugPrint("All Response Info: \(response)")
            let enc = String.Encoding(rawValue: CFStringConvertEncodingToNSStringEncoding(CFStringEncoding(CFStringEncodings.GB_18030_2000.rawValue)))
            
            if let data = response.result.value, let html = String(data: data, encoding: enc) {
                //print("Data: \(html)")
                if let doc = try? HTML(html: html, encoding: .utf8) {
                    print(doc.title)
                    
                    var idx = 0
                    var tiezi = TieziInfo()
                    
                    for row in doc.xpath("//td[@class='taolun_leftright']/table/tr/td") {
                        switch (idx) {
                        case 0:
                            tiezi = TieziInfo()
                            tiezi.id = row.text!
                        case 3:
                            tiezi.replyAndClick = row.text!
                        case 4:
                            tiezi.author = row.text!
                        case 5:
                            tiezi.lastReply = row.text!
                        default:
                            print("Unknown idx \(idx)")
                        }
                        idx += 1
                        if idx == 6 {
                            idx = 0
                            tieziList.append(tiezi)
                        }
                    }
                    
                    idx = 0
                    for title in doc.xpath("//td[@class='taolun_leftright']/table/tr/td/strong/a") {
                        if let trimmedString = title.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                            tieziList[idx].title = trimmedString
                            //print(trimmedString)
                        }
                        tieziList[idx].link = title["href"]!
                        //print(title["href"])
                        idx += 1
                    }
                    
                }
            }
        }
        
        performSegue(withIdentifier: "goToAwesomeJoke", sender: self)
    }
}
