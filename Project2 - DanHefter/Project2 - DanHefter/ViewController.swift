//
//  ViewController.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 11/30/16.
//  Copyright © 2016 GA. All rights reserved.
//

import UIKit
import SafariServices

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
   @IBOutlet weak var myTableView: UITableView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      
      fetchData(closure: { data in
         self.parseJSON(jsonData: data)})
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
         }
      }
      task.resume()
   }
   
   
   func parseJSON(jsonData: Data) {
      do {
         let parsedJSON = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any]
         
         let jSONarticles = parsedJSON["articles"] as! [[String:Any]]
         print(jSONarticles)
         
         for item in jSONarticles {
            
            let title = item["title"] as? (String) ?? "No article title"
            let description = item["description"] as? (String) ?? "No article description"
            let imageLink = item["urlToImage"] as? (String) ?? "No article image"
            let url = item["url"] as? (String) ?? "No article URL"
            let article = Article(title: title, description: description, imageLink: imageLink, url: url)
            Article.articles.append(article)
         }
      }
      catch {
         print(error.localizedDescription)
      }
      DispatchQueue.main.async {
         self.myTableView.reloadData()
      }
   }
   
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return Article.articles.count
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
      cell.article = Article.articles[indexPath.row]
      return cell
   }
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      let selectedArticle = Article.articles[indexPath.row]
      let svc = SFSafariViewController(url: URL(string: selectedArticle.url)!)
      self.navigationController?.pushViewController(svc, animated: true)
   }
   
   
}




  
