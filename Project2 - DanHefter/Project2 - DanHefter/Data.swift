//
//  Data.swift
//  Project2 - DanHefter
//
//  Created by Dan Hefter on 12/1/16.
//  Copyright © 2016 GA. All rights reserved.
//

import Foundation
import UIKit

class Article {
   
   static var articles = [Article]()
   
   var title: String
   var description: String
   var imageLink : String
   var url: String
   var image: UIImage?
   
   
   init(title: String, description: String, imageLink: String, url: String) {
      self.title = title
      self.description = description
      self.imageLink = imageLink
      self.url = url
   }
   
   static var dataOfImageLink = [Data]()
   
   

   
}


enum Category: String {
   
   case allStories = "All Stories"
   case sports = "Sports"
   case entertainment = "Entertainment"
   case business = "Business"
   case finance = "Finance"
   case politics = "Politics"
   
   static let allEnums: [String] = {
      return [Category.allStories.rawValue, Category.sports.rawValue, Category.entertainment.rawValue, Category.business.rawValue, Category.finance.rawValue, Category.politics.rawValue]
   }()
   
   
   
}







//NewsAPI - APIKey: 3fc2184706b64c03ab90b8472270562e

//WSJ API: https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=3fc2184706b64c03ab90b8472270562e

//Buzzfeed API:  https://newsapi.org/v1/articles?source=buzzfeed&sortBy=latest&apiKey=3fc2184706b64c03ab90b8472270562e
