//
//  Data.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 12/1/16.
//  Copyright © 2016 GA. All rights reserved.
//

import Foundation

class Article {
   
   static var articles = [Article]()
   
   var title: String
   var description: String
   var imageLink : String
   
   
   init(title: String, description: String, imageLink : String) {
      self.title = title
      self.description = description
      self.imageLink = imageLink
//      Article.articles.append(self)
   }
   
   static var dataOfImageLink = [Data]()
   
}







//NewsAPI - APIKey: 3fc2184706b64c03ab90b8472270562e

//WSJ API: https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=3fc2184706b64c03ab90b8472270562e


