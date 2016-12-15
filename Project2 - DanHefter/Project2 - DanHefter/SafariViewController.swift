//
//  SafariViewController.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 12/14/16.
//  Copyright © 2016 GA. All rights reserved.
//

import UIKit
import SafariServices


class SafariViewController: UIViewController {
   
   
   
   
   func showTutorial(_ which: Int) {
      if let url = URL(string: "https://www.hackingwithswift.com/read/\(which + 1)") {
         let vc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
         present(vc, animated: true)
      }
   }
   
   

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
