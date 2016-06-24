//
//  ArticlViewController.swift
//  MindStudiosTask
//
//  Created by Sergey Tszyu on 24.06.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

class ArticlesViewController: CoreDataViewController {
    
    var articles: [Article]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadAllArticles()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setup() {
        // Cell
        tableView.registerNib(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "ArticleCell")
        self.navigationController!.navigationBar.barTintColor = UIColor(red: 1.0, green: 0.27, blue: 0.44, alpha: 1)
        
        // RefreshControl
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ArticlesViewController.refreshData(_:)), forControlEvents: .ValueChanged)
        self.tableView.addSubview(refreshControl)
    }
    
    @objc private func refreshData(refreshControl: UIRefreshControl) {
        loadAllArticles()
        refreshControl.endRefreshing()
    }
    
    private func loadAllArticles() {
        Alamofire.request(.GET, "http://madiosgames.com/api/v1/application/ios_test_task/articles").responseJSON { response in
            guard let articles = response.result.value as? [[String : AnyObject]] else {
                return
            }
            let articleObjects = articles.map { (dictionary) -> Article in
                return Article(dictionary: dictionary)
            }
            
            self.articles = articleObjects
            
            let request = NSFetchRequest(entityName: "ManagedArticle")
            var resultArray: Array<AnyObject>! = Array()
            do {
                resultArray = try self.manager.managedObjectContext.executeFetchRequest(request)
            } catch {
            }
            
            for article in self.articles! {
                
                if self.isEqualObjects(article, array: resultArray) {
                    continue
                }
                
                print("count: \(self.articles?.count)")
                let newArticle = NSEntityDescription.insertNewObjectForEntityForName("ManagedArticle", inManagedObjectContext: self.manager.managedObjectContext) as? ManagedArticle
                newArticle?.id = article.id
                newArticle?.content_url = article.content_url
                newArticle?.title = article.title
                
                // KVC
                let URLMediumImage = NSURL(string: "\(article.image_medium)")
                let dataMediumImage = NSData(contentsOfURL: URLMediumImage!)
                newArticle?.setValue(dataMediumImage, forKey: "image_medium")
                
                let URLThumbImage = NSURL(string: "\(article.image_thumb)")
                let dataThumbImage = NSData(contentsOfURL: URLThumbImage!)
                newArticle?.setValue(dataThumbImage, forKey: "image_thumb")
                
            }
            self.manager.saveContext()
        }
    }
    
    private func isEqualObjects(article: Article, array: [AnyObject]) -> Bool{
        for element in array {
            let temp = element as! ManagedArticle
            if article.id == temp.id {
                return true
            }
        }
        return false
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleCell
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! NSManagedObject
        self.configureCell(cell, withObject: object)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let article = self.fetchedResultsController.objectAtIndexPath(indexPath)
        performSegueWithIdentifier("ArticleInfo", sender: article)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ArticleInfo" {
            let destinationViewController = segue.destinationViewController as! ArticleInfoViewController
            destinationViewController.article = sender as! ManagedArticle
        }
    }
    
    // MARK: - FRC
    
    override var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("ManagedArticle", inManagedObjectContext: self.manager.managedObjectContext)
        fetchRequest.entity = entity
        fetchRequest.fetchBatchSize = 20
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.manager.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            abort()
        }
        return _fetchedResultsController!
    }
    
    override func configureCell(cell: UITableViewCell, withObject object: NSManagedObject) {
        let article = object as! ManagedArticle
        let articleCell = cell as! ArticleCell
        articleCell.titleLabel.text = article.title
        articleCell.thumbImage.image = UIImage(data: article.image_thumb!)
        cell.accessoryType = .DisclosureIndicator
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }
    
}
