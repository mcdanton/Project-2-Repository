//
//  ViewController.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 11/30/16.
//  Copyright © 2016 GA. All rights reserved.
//

import UIKit
import SafariServices

class RootViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
   
   
   // MARK: Properties
   var filteredArticles = [Article]()
   var listOfCategories = [String]()
   var sidebarShowing = false
   
   
   
   // MARK: Outlets
   @IBOutlet weak var myTableView: UITableView!
   @IBOutlet weak var searchBar: UISearchBar!
   @IBOutlet weak var categories: UIBarButtonItem!
   @IBOutlet weak var sidebarView: UIView!
   @IBOutlet weak var sidebarTableView: UITableView!
   @IBOutlet weak var sidebarLeadingConstraint: NSLayoutConstraint!
   
   
   
   // MARK: Actions
   
   @IBAction func categoriesPressed(_ sender: Any) {
      if sidebarShowing {
         sidebarLeadingConstraint.constant = -150
      } else {
         sidebarLeadingConstraint.constant = 0
         UIView.animate(withDuration: 0.3, animations: { self.view.layoutIfNeeded()})
      }
      sidebarShowing = !sidebarShowing
   }
   
   
   func searchBarSetup() {
      searchBar.showsScopeBar = false
      self.myTableView.tableHeaderView = searchBar
   }
   
   // MARK: Search Bar Delegate
   
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      filteredArticles = Article.articles.filter({ (mod) -> Bool in
         return mod.title.lowercased().contains(searchText.lowercased())
      })
      self.myTableView.reloadData()
   }
   
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      self.searchBar.endEditing(true)
   }
   
   
   // MARK: Setting Categories
   
   func setCategories() {
      for category in Article.Category.RawValue {
         listOfCategories.append(category)
      }
   }
   
   
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
      searchBar.delegate = self
      sidebarView.layer.shadowOpacity = 1
      sidebarView.layer.shadowRadius = 5
      
      fetchData(closure: { data in
         self.parseJSON(jsonData: data)})
      
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
      view.addGestureRecognizer(tap)
   }
   
   override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
   }
   
   func dismissKeyboard() {
      view.endEditing(true)
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
   
   
   // MARK: Table View Setup
   
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
      var count:Int?
      
      if tableView == myTableView {
         
         if filteredArticles.count > 0 {
            count = filteredArticles.count
         } else {
            count = Article.articles.count
         }
      }
      if tableView == sidebarTableView {
         count = 7
      }
      return count!
   }
   
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
      var cell: UITableViewCell?
      
      if tableView == myTableView {
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! TableViewCell
         if filteredArticles.count > 0 {
            cell.article = filteredArticles[indexPath.row]
            return cell

         } else {
            cell.article = Article.articles[indexPath.row]
            return cell
         }
      }
      
      if tableView == sidebarTableView {
         
         let cell = tableView.dequeueReusableCell(withIdentifier: "SidebarTableViewCell", for: indexPath) as! SidebarTableViewCell
         cell.categoryName.text = "PLACEHOLDER"
         return cell
      }
      print("Something is wrong, your tableviews didn't load correctly....")
      return cell!
   }
   
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      let selectedArticle = Article.articles[indexPath.row]
      let svc = SFSafariViewController(url: URL(string: selectedArticle.url)!)
      self.navigationController?.pushViewController(svc, animated: true)
   }
   
   
}

//extension RootViewController: UISearchResultsUpdating {
//   func updateSearchResults(for searchController: UISearchController) {
//      filterArticles(searchText: searchController.searchBar.text)
//   }
//}



