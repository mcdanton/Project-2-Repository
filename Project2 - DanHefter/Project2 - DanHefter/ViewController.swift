//
//  ViewController.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 11/30/16.
//  Copyright © 2016 GA. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   @IBOutlet weak var myTableView: UITableView!
   
   
   

   override func viewDidLoad() {
      super.viewDidLoad()
      // Do any additional setup after loading the view, typically from a nib.
      
      fetchData() { data in
         do {
            let parsedJSON = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
            
            let articles = parsedJSON["articles"] as! [[String:Any]]
            
            for item in articles {
                News.articleDescription = item["description"] as! (String)
            }
            
            for imageLink in articles {
               News.imageLink = imageLink["urlToImage"] as! (String)
            }

            News.init(articles: articles, articleDescription: News.articleDescription, imageLink: News.imageLink)
            
         }
         catch {
            print(error.localizedDescription)
         }
   }
      
      
      
      //end of ViewDidLoad
   }

   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   
   
   func fetchData(closure: @escaping (Data) -> ()) {
      
      let urlRequest = URLRequest(url: URL(string: "https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=3fc2184706b64c03ab90b8472270562e")!)
      let urlSession = URLSession(configuration: URLSessionConfiguration.default)
      let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
         
         guard let responseData = data else {
            print("Error \(error.debugDescription): did not receive data")
            return
         }
         DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            closure(responseData)
            self.convertImageLinkToData(urlLink: { link in
               News.dataOfImageLink = link
               self.myTableView.reloadData()
            })
         }
                  }
      task.resume()
   }

   
      func convertImageLinkToData(urlLink: @escaping (Data) -> ()) {
      let urlRequest = URLRequest(url: URL(string: News.imageLink)!)
      let urlSession = URLSession(configuration: URLSessionConfiguration.default)
      let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
         
         guard let responseData = data else {
            print("Error \(error.debugDescription): did not receive data")
            return
         }
         DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            urlLink(responseData)
         }
      }
      task.resume()
      
      
      
      
   }
   
   
   
   
   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
   }

   
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
      
         cell.cellImage.image = UIImage(data: News.dataOfImageLink)
  
      
      return cell
   }

   
   
   
   
   
      }

