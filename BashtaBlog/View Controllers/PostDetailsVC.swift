//
//  SecondViewController.swift
//  BashtaBlog
//
//  Created by Andrey Bashta on 1/29/18.
//  Copyright © 2018 Andrey Bashta. All rights reserved.
//

import UIKit
import Alamofire

class PostDetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var postContentView: PostContentView!
    
    var post: PostData?
    var marks = [MarkData]()
    var comments = [CommentData]()
    
    private var presenter = PostDetailsPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        presenter.attachView(view: self)
        
        DispatchQueue.main.async {
            self.presenter.getCommentsByPostID(post: self.post!)
            self.presenter.getMarksByPostID(post: self.post!)
        }

        postContentView.ConfigureCell(post: post!)
        
    }
    
}

extension PostDetailsVC: PostsDetailsView {
    
    func addMarks(marks: [MarkData]?) {
        guard let marks = marks else { return }
        
        self.marks = marks
        
        postContentView.setScrollViewItems(marks: marks)
        postContentView.setScrollSize(marks: marks)
    }
    
    func getMarksByPostID(post: PostData?) {
        presenter.getMarksByPostID(post: self.post)
    }
    

    func addComments(comments: [CommentData]?) {
        self.comments = comments!
        tableView.reloadData()
    }
    
    func getCommentsByPostID(post: PostData?) {
        presenter.getCommentsByPostID(post: self.post)
    }
    
}

extension PostDetailsVC: UITableViewDelegate {
    
}

extension PostDetailsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let commentCell = tableView.dequeueReusableCell(withIdentifier: "PostCommentCell", for: indexPath) as? PostCommentsCell {
            
            let comment = comments[indexPath.row]
            commentCell.сonfigureCell(comment: comment)
            
            return commentCell
            
        } else {
            return PostCommentsCell()
        }
        
    }
}
