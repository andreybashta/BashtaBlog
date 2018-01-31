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
    
    private var presenter = PostPresenter()
    var posts = [PostData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        presenter.attachView(view: self)
        presenter.getPosts()
        
//        downloadPosts{}
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
    
//    func downloadPosts(completed: @escaping DownloadComplete) {
//        Alamofire.request(BLOG_URL + POSTS, method: .get).responseData { response in
//
//            guard let data = response.data else {
//                let error = checkErrorCode(response.response!.statusCode)
//                print(error)
//                return
//            }
//
//            let posts: [PostData]? = try? unbox(data: data)
//            self.posts = posts!
//            self.tableView.reloadData()
//
//        }
//    }
    
}

extension PostsVC: PostsView {
    
    func addPosts(posts: [PostData]?) {
        for post in posts! {
            self.posts.append(post)
        }
        tableView.reloadData()
    }
    
    func getPosts() {
        presenter.getPosts()
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
