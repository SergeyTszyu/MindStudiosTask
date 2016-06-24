//
//  ManagedArticle+CoreDataProperties.swift
//  MindStudiosTask
//
//  Created by Sergey Tszyu on 22.06.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ManagedArticle {

    @NSManaged var image_medium: NSData?
    @NSManaged var id: NSNumber?
    @NSManaged var image_thumb: NSData?
    @NSManaged var title: String?
    @NSManaged var content_url: String?

}
