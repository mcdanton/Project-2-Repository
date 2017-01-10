//
//  TableViewCell.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 12/1/16.
//  Copyright © 2016 GA. All rights reserved.
//

import UIKit


protocol CustomCellUpdater {
   func updateTableView()
}

class TableViewCell: UITableViewCell {
   
   
   @IBOutlet weak var cellImage: UIImageView!
   @IBOutlet weak var cellLabel: UILabel!
   
   var article: Article! {
      didSet {
         updateUI()
      }
   }
   
   
   override func awakeFromNib() {
      super.awakeFromNib()
      // Initialization code
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
      
      // Configure the view for the selected state
   }
   
   
   
   func updateUI() {
      
      cellLabel.text = article.title
      
      // TODO check article.image before fetch
      
      convertImageLinkToData(imageLink: article.imageLink)
   }
   
   
   func convertImageLinkToData(imageLink: String) {
      
      if imageLink == "" {
         let urlRequest = URLRequest(url: URL(string: "https://subtitling.com/scrn-content/plugins/ajax-search-pro/img/default.jpg")!)
         let urlSession = URLSession(configuration: URLSessionConfiguration.default)
         let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let responseData = data else {
               print("Error \(error.debugDescription): did not receive data")
               return
            }
            DispatchQueue.main.async {
               let image = UIImage(data: responseData)
               self.article.image = image
               self.cellImage.image = image
            }
         }
         task.resume()
      } else {
         let urlRequest = URLRequest(url: URL(string: imageLink)!)
         let urlSession = URLSession(configuration: URLSessionConfiguration.default)
         let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let responseData = data else {
               print("Error \(error.debugDescription): did not receive data")
               return
            }
            DispatchQueue.main.async {
               let image = UIImage(data: responseData)
               self.article.image = image
               self.cellImage.image = image
            }
         }
         task.resume()
      }
}


}

/*
 func convertImageLinkToData(imageURL: @escaping ([Data]) -> ()) {
 for image in Article.articles {
 if image.imageLink == "" {
 let urlRequest = URLRequest(url: URL(string: "http://subtitling.com/scrn-content/plugins/ajax-search-pro/img/default.jpg")!)
 let urlSession = URLSession(configuration: URLSessionConfiguration.default)
 let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
 
 guard let responseData = data else {
 print("Error \(error.debugDescription): did not receive data")
 return
 }
 self.dataArray.append(responseData)
 DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
 imageURL(self.dataArray)
 }
 }
 task.resume()
 } else {
 let urlRequest = URLRequest(url: URL(string: image.imageLink)!)
 let urlSession = URLSession(configuration: URLSessionConfiguration.default)
 let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
 
 guard let responseData = data else {
 print("Error \(error.debugDescription): did not receive data")
 return
 }
 self.dataArray.append(responseData)
 DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
 imageURL(self.dataArray)
 }
 }
 task.resume()
 }
 }
 DispatchQueue.main.async {
 self.myTableView.reloadData()
 }
 }
 */




