//
//  ViewController.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit
import Alamofire
import Unbox

class PostsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var authorizeButton: UIButton!
    
    private var postPresenter = PostPresenter()
    private var authorizePresenter = AuthorizePresener()
    
    var posts = [PostData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        postPresenter.attachView(view: self)
        
        DispatchQueue.main.async {
            self.postPresenter.getPosts()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Posts"
        navigationItem.backBarButtonItem = backItem
        
        if segue.identifier == "ShowPost" {
            if let destination = segue.destination as? PostDetailsVC {
                if let post = sender as? PostData {
                    destination.post = post
                }
            }
        }
    }
    
    @IBAction func logoutUser(_ sender: Any) {
        APIManager.sharedInstance.doLogout()
    }
    
}

extension PostsVC: PostsView {
    
    func appendPosts(posts: [PostData]?) {
        for post in posts! {
            self.posts.append(post)
        }
        tableView.reloadData()
    }
    
    func getPosts() {
        postPresenter.getPosts()
    }
    
}

extension PostsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        performSegue(withIdentifier: "ShowPost", sender: post)
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension PostsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? PostCell {
            
            let post = posts[indexPath.row]
            cell.ConfigureCell(post: post)
            
            return cell
            
        } else {
            return PostCell()
        }
    }
    
}
