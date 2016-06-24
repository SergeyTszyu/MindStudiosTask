//
//  ArticleInfoViewController.swift
//  MindStudiosTask
//
//  Created by Sergey Tszyu on 22.06.16.
//  Copyright © 2016 Sergey Tszyu. All rights reserved.
//

import UIKit

class ArticleInfoViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var article: ManagedArticle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        loadPage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private 
    
    private func setNavigationItem() {
        
        let shareButton = UIButton(type: .Custom)
        shareButton.bounds = CGRectMake(0, 0, 30, 30)
        shareButton.setImage(UIImage(named: "share"), forState: .Normal)
        shareButton.addTarget(self, action: #selector(ArticleInfoViewController.shareAction(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: shareButton)
        
        let backButton = UIButton(type: .Custom)
        backButton.bounds = CGRectMake(0, 0, 30, 30)
        backButton.setImage(UIImage(named: "back"), forState: .Normal)
        backButton.addTarget(self, action: #selector(ArticleInfoViewController.backAction(_:)), forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    private func loadPage() {
        let url = NSURL(string: article.content_url!)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    // MARK: - Actions
    
    func shareAction(sender: AnyObject) {
        let URL = NSURL(string: article.content_url!)!
        let image = UIImage(data: article.image_medium!)
        let activityViewController = UIActivityViewController(activityItems: [image!, URL], applicationActivities: nil)
        
        if (UI_USER_INTERFACE_IDIOM() == .Phone) {
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }
        else if (UI_USER_INTERFACE_IDIOM() == .Pad){
            activityViewController.modalPresentationStyle = .Popover
            activityViewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
            self.presentViewController(activityViewController, animated: true, completion: nil)
        }
    }
    
    func backAction(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }
    
}

extension ArticleInfoViewController: UIWebViewDelegate {
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        
    }
    
}


