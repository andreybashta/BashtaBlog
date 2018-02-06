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
    @IBOutlet weak var addCommentView: AddCommentView!
    
    var post: PostData?
    var marks = [MarkData]()
    var comments = [CommentData]()
    
    private var presenter = PostDetailsPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        addCommentView.commentTextField.delegate = self
        presenter.attachView(view: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        DispatchQueue.main.async {
            self.presenter.getCommentsByPostID(post: self.post!)
            self.presenter.getMarksByPostID(post: self.post!)
        }

        postContentView.ConfigureCell(post: post!)
        
    }
    
    @IBAction func addComment(_ sender: Any) {
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateResult = formatter.string(from: date)

        let author = UserDefaults.standard.string(forKey: "username")
        
        let comment = CommentData(commentID: 0, text: addCommentView.commentTextField.text!, datePublic: dateResult, author: author!)

        setComment(post: self.post, comment: comment)
        
    }
    
}

// Keyboard extension
extension PostDetailsVC {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 && (comments.count > 1) {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
}

extension PostDetailsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addCommentView.commentTextField.resignFirstResponder()
        return true
    }
    
}

extension PostDetailsVC: PostsDetailsView {
    
    func appendComment(comment: CommentData?) {
        guard let comment = comment else {
            print("COMMENT DIDN'T ADDED TO ARRAY")
            return
        }
        self.comments.append(comment)
        tableView.reloadData()
    }

    func setComment(post: PostData?, comment: CommentData?) {
        presenter.setComment(post: post, comment: comment)
    }
    
    func appendMarks(marks: [MarkData]?) {
        guard let marks = marks else {
            print("MARKS DIDN'T ADDED TO ARRAY")
            return
        }
        
        self.marks = marks
        
        if marks.count != 0 {
            postContentView.marksScrollView.isHidden = false
            postContentView.setScrollViewItems(marks: marks)
            postContentView.setScrollSize(marks: marks)
        }
        
    }
    
    func getMarksByPostID(post: PostData?) {
        presenter.getMarksByPostID(post: self.post)
    }
    

    func appendComments(comments: [CommentData]?) {
        guard let comments = comments else {
            print("COMMENTS DIDN'T ADDED TO ARRAY")
            return
        }
        self.comments = comments
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
