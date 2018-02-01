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
    
    var post: PostData?
    
    var marks = [MarkData]()
    var comments = [CommentData]()
    
    private var presenter = PostDetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        presenter.attachView(view: self)
        presenter.getComments()
    }
    
}

extension PostDetailsVC: PostsDetailsView {
    
    func addComments(comments: [CommentData]?) {
        for comment in comments! {
            self.comments.append(comment)
        }
        tableView.reloadData()
    }
    
    func getComments() {
        presenter.getComments()
    }
    
    func addMarks(marks: [MarkData]?) {
        for mark in marks! {
            self.marks.append(mark)
        }
        tableView.reloadData()
    }
    
    func addPostContent() {
        
    }
    
    func getMarks() {
        presenter.getMarks()
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

        if let commentCell = tableView.dequeueReusableCell(withIdentifier: "PostCommentCell", for: indexPath) as? PostCommentCell {
            
            let comment = comments[indexPath.row]
            commentCell.ConfigureCell(comment: comment)
            
            return commentCell
            
        } else {
            return PostCommentCell()
        }
        
    }
}
