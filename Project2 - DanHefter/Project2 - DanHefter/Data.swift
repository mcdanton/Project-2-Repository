//
//  Data.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 12/1/16.
//  Copyright © 2016 GA. All rights reserved.
//

import Foundation

class News {
   
   var articles: [[String:Any]]
   var articleDescription: String
   var imageLink : String
   
   
   init(articles: [[String:Any]], articleDescription: String, imageLink : String) {
   self.articles = articles
   self.articleDescription = articleDescription
   self.imageLink = imageLink
      
   
   }
   
   static var articleDescription: String = ""
   static var imageLink: String = ""
   static var dataOfImageLink = Data()
   
}






//NewsAPI - APIKey: 3fc2184706b64c03ab90b8472270562e

//WSJ API: https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=3fc2184706b64c03ab90b8472270562e


