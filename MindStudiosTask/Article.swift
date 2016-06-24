//
//  Article.swift
//  MindStudiosTask
//
//  Created by Sergey Tszyu on 22.06.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

import Foundation;

struct Article {
    var content_url: String
    var id: Int
    var image_medium: String
    var image_thumb: String
    var title: String
    
    init(dictionary: NSDictionary) {
        content_url = dictionary["content_url"] as! String
        id = dictionary["id"] as! Int
        image_medium = dictionary["image_medium"] as! String
        image_thumb = dictionary["image_thumb"] as! String
        title = dictionary["title"] as! String
    }
}
